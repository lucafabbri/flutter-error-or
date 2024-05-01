<div align="center">

# ErrorOr Plus

This library is a porting of [ErrorOr](https://github.com/amantinband/error-or) for C# made by [Amichai Mantinband](https://github.com/amantinband)

### A simple, fluent discriminated union of an error or a result.

`dart pub add error-or`

</div>

- [Give it a star ⭐!](#give-it-a-star-)
- [Getting Started 🏃](#getting-started-)
  - [Replace throwing exceptions with `ErrorOr<T>`](#replace-throwing-exceptions-with-errorort)
  - [Support For Multiple errors](#support-for-multiple-errors)
  - [Various Functional Methods and Extension Methods](#various-functional-methods-and-extension-methods)
    - [Real world example](#real-world-example)
    - [Simple Example with intermediate steps](#simple-example-with-intermediate-steps)
      - [No Failure](#no-failure)
      - [Failure](#failure)
- [Creating an `ErrorOr` instance](#creating-an-erroror-instance)
  - [Using The `ToErrorOr` Extension Method](#using-the-toerroror-extension-method)
- [Properties](#properties)
  - [`isError`](#iserror)
  - [`value`](#value)
  - [`errors`](#errors)
  - [`firstError`](#firsterror)
  - [`errorsOrEmptyList`](#errorsoremptylist)
- [Methods](#methods)
  - [`match`](#match)
    - [`match`](#match-1)
    - [`matchAsync`](#matchasync)
    - [`matchFirst`](#matchfirst)
    - [`matchFirstAsync`](#matchfirstasync)
  - [`doSwitch`](#switch)
    - [`doSwitch`](#switch-1)
    - [`doSwitchAsync`](#switchasync)
    - [`doSwitchFirst`](#switchfirst)
    - [`doSwitchFirstAsync`](#switchfirstasync)
  - [`then`](#then)
    - [`then`](#then-1)
    - [`thenAsync`](#thenasync)
    - [`thenDo` and `thenDoAsync`](#thendo-and-thendoasync)
    - [Mixing `then`, `thenDo`, `thenAsync`, `thenDoAsync`](#mixing-then-thendo-thenasync-thendoasync)
  - [`failIf`](#failif)
  - [`orElse`](#else)
    - [`orElse`](#else-1)
    - [`orElseAsync`](#elseasync)
- [Mixing Features (`then`, `failIf`, `orElse`, `doSwitch`, `match`)](#mixing-features-then-failif-else-switch-match)
- [Errors Types](#error-types)
  - [Built in error types](#built-in-error-types)
- [Organizing errors](#organizing-errors)(#mediator--fluentvalidation--erroror-)
- [Contribution 🤲](#contribution-)
- [Credits 🙏](#credits-)
- [License 🪪](#license-)

# Give it a star ⭐!

Loving it? Show your support by giving this project a star!

# Getting Started 🏃

## Replace throwing exceptions with `ErrorOr<T>`

This 👇

```dart
double divide(int a, int b)
{
    if (b == 0)
    {
        throw Exception("Cannot divide by zero");
    }

    return a / b;
}

try
{
    var result = divide(4, 2);
    print(result * 2); // 4
}
on Exception catch (e)
{
    print(e);
    return;
}
```

Turns into this 👇

```dart
ErrorOr<double> divide(int a, int b)
{
    if (b == 0)
    {
        return Errors.unexpected(description: "Cannot divide by zero");
    }

    return a / b;
}

var result = divide(4, 2);

if (result.isError)
{
    print(result.firstError.description);
    return;
}

print(result.value * 2); // 4
```

Or, using [then](#then--thenasync)/[orElse](#else--elseasync) and [doSwitch](#switch--switchasync)/[match](#match--matchasync), you can do this 👇

```dart

divide(4, 2)
    .then((val) => val * 2)
    .doSwitchFirst(
        onValue: print, // 4
        onFirstError: (error) => print(error.description));
```

## Support For Multiple errors

Internally, the `ErrorOr` object has a list of `Errors`s, so if you have multiple errors, you don't need to compromise and have only the first one.

```dart
class User
{
    final String _name;

    User._internal(this._name);

    static ErrorOr<User> create(String name)
    {
        List<Errors> errors = [];

        if (name.length < 2)
        {
            errors.add(Errors.validation(description: "Name is too short"));
        }

        if (name.length > 100)
        {
            errors.add(Errors.validation(description: "Name is too long"));
        }

        if (name.isEmpty)
        {
            errors.add(Errors.validation(description: "Name cannot be empty or whitespace only"));
        }

        if (errors.isNotEmpty)
        {
            return errors.toErrorOr<User>();
        }

        return User._internal(name).toErrorOr();
    }
}
```

## Various Functional Methods and Extension Methods

The `ErrorOr` object has a variety of methods that allow you to work with it in a functional way.

This allows you to chain methods together, and handle the result in a clean and concise way.

### Real world example

```dart
return await _userRepository.getByIdAsync(id)
    .then((user) => user.incrementAge()
        .then((success) => user)
        .orElse((errors) => Errors.unexpected("Not expected to fail")))
    .failIf((user) => !user.isOverAge(18), UserErrors.underAge)
    .thenDo((user) => _logger.logInformation("User ${user.Id} incremented age to ${user.Age}"))
    .thenAsync((user) => _userRepository.updateAsync(user))
    .match(
        (_) => noContent(),
        (errors) => errors.toActionResult());
```

### Simple Example with intermediate steps

#### No Failure

```dart
ErrorOr<String> foo = await "2".toErrorOr()
    .then(int.parse) // 2
    .failIf((val) => val > 2, Errors.validation(description: "$${val} is too big") // 2
    .thenDoAsync((val) => Future.delayed(Duration(milliseconds: val))) // Sleep for 2 milliseconds
    .thenDo((val) => print("Finished waiting $${val} milliseconds.")) // Finished waiting 2 milliseconds.
    .thenAsync((val) => Future.value(val * 2)) // 4
    .then((val) => "The result is $${val}") // "The result is 4"
    .orElse((errors) => Errors.unexpected(description: "Yikes")) // "The result is 4"
    .matchFirst(
        (value) => value, // "The result is 4"
        (firstError) => "An error occurred: ${firstError.description}");
```

#### Failure

```dart
ErrorOr<String> foo = await "5".ToErrorOr()
    .then(int.Parse) // 5
    .failIf((val) => val > 2, Errors.validation(description: "${val} is too big")) // Errors.validation()
    .thenDoAsync((val) => Future.delayed(Duration(milliseconds: val))) // Errors.validation()
    .thenDo((val) => print("Finished waiting ${val} milliseconds.")) // Errors.validation()
    .thenAsync((val) => Future.value(val * 2)) // Errors.validation()
    .then((val) => "The result is ${val}") // Errors.validation()
    .orElse((errors) => Errors.unexpected(description: "Yikes")) // Errors.unexpected()
    .matchFirst(
        (value) => value,
        (firstError) => "An error occurred: {firstError.description}"); // An error occurred: Yikes
```

# Creating an `ErrorOr` instance

## Using The `ToErrorOr` Extension Method

```dart
ErrorOr<int> result = 5.ToErrorOr();
ErrorOr<int> result = Errors.unexpected().ToErrorOr<int>();
ErrorOr<int> result = new[] { Errors.validation(), Errors.validation() }.ToErrorOr<int>();
```

# Properties

## `isError`

```dart
ErrorOr<int> result = User.create();

if (result.isError)
{
    // the result contains one or more errors
}
```

## `value`

```dart
ErrorOr<int> result = User.create();

if (!result.isError) // the result contains a value
{
    print(result.value);
}
```

## `errors`

```dart
ErrorOr<int> result = User.create();

if (result.isError)
{
    result.errors // contains the list of errors that occurred
        .forEach((error) => print(error.description));
}
```

## `firstError`

```dart
ErrorOr<int> result = User.create();

if (result.isError)
{
    var firstError = result.firstError; // only the first error that occurred
    print(firstError == result.errors[0]); // true
}
```

## `errorsOrEmptyList`

```dart
ErrorOr<int> result = User.create();

if (result.isError)
{
    result.errorsOrEmptyList // List<Errors> { /* one or more errors */  }
    return;
}

result.errorsOrEmptyList // List<Errors> { }
```

# Methods

## `match`

The `match` method receives two functions, `onValue` and `onError`, `onValue` will be invoked if the result is success, and `onError` is invoked if the result is an error.

### `match`

```dart
String foo = result.match(
    (value) => value,
    (errors) => "${errors.Count} errors occurred.");
```

### `matchAsync`

```dart
String foo = await result.matchAsync(
    (value) => Future.value(value),
    (errors) => Future.value("${errors.Count} errors occurred."));
```

### `matchFirst`

The `matchFirst` method receives two functions, `onValue` and `onError`, `onValue` will be invoked if the result is success, and `onError` is invoked if the result is an error.

Unlike `match`, if the state is error, `matchFirst`'s `onError` function receives only the first error that occurred, not the entire list of errors.

```dart
String foo = result.matchFirst(
    (value) => value,
    (firstError) => firstError.description);
```

### `matchFirstAsync`

```dart
String foo = await result.matchFirstAsync(
    (value) => Future.value(value),
    (firstError) => Future.value(firstError.description));
```

## `doSwitch`

The `doSwitch` method receives two actions, `onValue` and `onError`, `onValue` will be invoked if the result is success, and `onError` is invoked if the result is an error.

### `doSwitch`

```dart
result.doSwitch(
    (value) => print(value),
    (errors) => print("${errors.Count} errors occurred."));
```

### `doSwitchAsync`

```dart
await result.doSwitchAsync(
    (value) => { print(value); return Future.value(true); },
    (errors) => { print("${errors.Count} errors occurred."); return Future.value(true); });
```

### `doSwitchFirst`

The `doSwitchFirst` method receives two actions, `onValue` and `onError`, `onValue` will be invoked if the result is success, and `onError` is invoked if the result is an error.

Unlike `doSwitch`, if the state is error, `doSwitchFirst`'s `onError` function receives only the first error that occurred, not the entire list of errors.

```dart
result.doSwitchFirst(
    (value) => print(value),
    (firstError) => print(firstError.description));
```

### `doSwitchFirstAsync`

```dart
await result.doSwitchFirstAsync(
    (value) => { print(value); return Future.value(true); },
    (firstError) => { print(firstError.description); return Future.value(true); });
```

## `then`

### `then`

`then` receives a function, and invokes it only if the result is not an error.

```dart
ErrorOr<int> foo = result
    .then((val) => val * 2);
```

Multiple `then` methods can be chained together.

```dart
ErrorOr<String> foo = result
    .then((val) => val * 2)
    .then((val) => "The result is ${val}");
```

If any of the methods return an error, the chain will break and the errors will be returned.

```dart
ErrorOr<int> Foo() => Errors.unexpected();

ErrorOr<String> foo = result
    .then((val) => val * 2)
    .then((_) => getAnError())
    .then((val) => "The result is ${val}") // this function will not be invoked
    .then((val) => "The result is ${val}"); // this function will not be invoked
```

### `thenAsync`

`thenAsync` receives an asynchronous function, and invokes it only if the result is not an error.

```dart
ErrorOr<String> foo = await result
    .thenAsync((val) => doSomethingAsync(val))
    .thenAsync((val) => doSomethingElseAsync("The result is ${val}"));
```

### `thenDo` and `thenDoAsync`

`thenDo` and `thenDoAsync` are similar to `then` and `thenAsync`, but instead of invoking a function that returns a value, they invoke an action.

```dart
ErrorOr<String> foo = result
    .thenDo((val) => print(val))
    .thenDo((val) => print("The result is ${val}"));
```

```dart
ErrorOr<String> foo = await result
    .thenDoAsync((val) => Future.delayed(Duration(milliseconds: val)))
    .thenDo((val) => print("Finsihed waiting ${val} seconds."))
    .thenDoAsync((val) => Future.value(val * 2))
    .thenDo((val) => "The result is ${val}");
```

### Mixing `then`, `thenDo`, `thenAsync`, `thenDoAsync`

You can mix and match `then`, `thenDo`, `thenAsync`, `thenDoAsync` methods.

```dart
ErrorOr<String> foo = await result
    .thenDoAsync((val) => Future.delayed(Duration(milliseconds: val)))
    .then((val) => val * 2)
    .thenAsync((val) => doSomethingAsync(val))
    .thenDo((val) => print("Finsihed waiting ${val} seconds."))
    .thenAsync((val) => Future.value(val * 2))
    .then((val) => "The result is ${val}");
```

## `failIf`

`failIf` receives a predicate and an error. If the predicate is true, `failIf` will return the error. Otherwise, it will return the value of the result.

```dart
ErrorOr<int> foo = result
    .failIf((val) => val > 2, Errors.validation(description: "${val} is too big"));
```

Once an error is returned, the chain will break and the error will be returned.

```dart
var result = "2".ToErrorOr()
    .then(int.Parse) // 2
    .failIf((val) => val > 1, Errors.validation(description: "${val} is too big") // validation error
    .then(num => num * 2) // this function will not be invoked
    .then(num => num * 2) // this function will not be invoked
```

## `orElse`

`orElse` receives a value or a function. If the result is an error, `orElse` will return the value or invoke the function. Otherwise, it will return the value of the result.

### `orElse`

```dart
ErrorOr<String> foo = result
    .orElse("fallback value");
```

```dart
ErrorOr<String> foo = result
    .orElse((errors) => "${errors.Count} errors occurred.");
```

### `orElseAsync`

```dart
ErrorOr<String> foo = await result
    .orElseAsync(Future.value("fallback value"));
```

```dart
ErrorOr<String> foo = await result
    .orElseAsync((errors) => Future.value("${errors.Count} errors occurred."));
```

# Mixing Features (`then`, `failIf`, `orElse`, `doSwitch`, `match`)

You can mix `then`, `failIf`, `orElse`, `doSwitch` and `match` methods together.

```dart
ErrorOr<String> foo = await result
    .thenDoAsync((val) => Future.delayed(Duration(milliseconds: val)))
    .failIf((val) => val > 2, Errors.validation(description: "${val} is too big"))
    .thenDo((val) => print("Finished waiting ${val} seconds."))
    .thenAsync((val) => Future.value(val * 2))
    .then((val) => "The result is ${val}")
    .orElse((errors) => Errors.unexpected())
    .matchFirst(
        (value) => value,
        (firstError) => "An error occurred: {firstError.description}");
```

# Errors Types

Each `Errors` instance has a `Type` property, which is an enum value that represents the type of the error.

## Built in error types

The following error types are built in:

```dart
enum ErrorType {
  failure,
  unexpected,
  validation,
  conflict,
  notFound,
  unauthorized,
  forbidden,
}
```

Each error type has a static method that creates an error of that type. For example:

```dart
var error = Errors.notFound();
```

optionally, you can pass a code, description and metadata to the error:

```dart
  var user = Object();
  var error = Errors.unexpected(
      code: "User.ShouldNeverHappen",
      description: "A user error that should never happen",
      metadata: Map.fromEntries([
        MapEntry("user", user),
      ]));
```

The `ErrorType` enum is a good way to categorize errors.

# Organizing errors

A nice approach, is creating a static class with the expected errors. For example:

```dart
public static partial class DivisionErrors
{
    public static Errors CannotdivideByZero = Errors.unexpected(
        code: "Division.CannotdivideByZero",
        description: "Cannot divide by zero.");
}
```

Which can later be used as following 👇

```dart
public ErrorOr<double> divide(int a, int b)
{
    if (b == 0)
    {
        return DivisionErrors.CannotdivideByZero;
    }

    return a / b;
}
```

# Contribution 🤲

If you have any questions, comments, or suggestions, please open an issue or create a pull request 🙂

# Credits 🙏

- [ErrorOr](https://github.com/amantinband/error-or) - An awesome library which provides C# style discriminated unions behavior for C#

# License

This project is licensed under the terms of the [MIT](https://github.com/lucafabbri/flutter-error-or/LICENSE) license.
