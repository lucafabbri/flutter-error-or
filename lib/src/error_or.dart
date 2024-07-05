import '../error_or_plus.dart';

/// Represents a value that can either be an error or a valid value of type [TValue].
class ErrorOr<TValue> {
  final TValue? _value;

  final List<Errors> _errors;

  /// A static field representing an unexpected error when trying to retrieve the first error from a successful [ErrorOr].
  static final noFirstError = Errors.unexpected(
    code: "ErrorOr.NoFirstError",
    description: "First error cannot be retrieved from a successful ErrorOr.",
  );

  /// A static instance of [Errors.unexpected] representing the absence of any errors.
  static final noErrors = Errors.unexpected(
    code: "ErrorOr.NoErrors",
    description: "Error list cannot be retrieved from a successful ErrorOr.",
  );

  final bool _isError;

  /// Indicates whether the current instance represents an error.
  bool get isError => _isError;

  /// Returns a list of errors if the instance represents an error; otherwise, returns a list containing [noErrors].
  List<Errors> get errors => _isError ? _errors : [noErrors];

  /// Returns a list of errors if the instance represents an error; otherwise, returns an empty list.
  List<Errors> get errorsOrEmptyList => _isError ? _errors : [];

  /// Constructs an [ErrorOr] instance representing an error with the given list of [errors].
  ErrorOr.fromErrors(List<Errors> errors)
      : _errors = errors,
        _value = null,
        _isError = errors.isNotEmpty;

  /// Constructs an [ErrorOr] instance representing an error with the given [error].
  ErrorOr.fromError(Errors error)
      : _errors = [error],
        _value = null,
        _isError = true;

  /// Constructs an [ErrorOr] instance representing a value with the given [value].
  ErrorOr.fromValue(TValue value)
      : _errors = [],
        _value = value,
        _isError = false;

  /// Returns the value if the instance represents a value; otherwise, throws an exception.
  TValue get value => _value!;

  /// Returns the first error if the instance represents an error; otherwise, returns [noFirstError].
  Errors get firstError => _isError ? _errors.first : noFirstError;

  ErrorOr<TValue> orElse({
    Errors Function(List<Errors> errors)? errorOnErrorHandler,
    List<Errors> Function(List<Errors> errors)? errorsOnErrorHandler,
    TValue? Function(List<Errors> errors)? valueOnErrorHandler,
    TValue? valueOnError,
    Errors? errorOnError,
  }) {
    if (!_isError) {
      return value.toErrorOr();
    }
    return valueOnError?.toErrorOr() ??
        valueOnErrorHandler?.call(errors)?.toErrorOr() ??
        errorOnError?.toErrorOr<TValue>() ??
        errorOnErrorHandler?.call(errors).toErrorOr<TValue>() ??
        errorsOnErrorHandler?.call(errors).toErrorOr<TValue>() ??
        errors.toErrorOr<TValue>();
  }

  Future<ErrorOr<TValue>> orElseAsync({
    Future<Errors> Function(List<Errors> errors)? errorOnErrorHandler,
    Future<List<Errors>> Function(List<Errors> errors)? errorsOnErrorHandler,
    Future<TValue?> Function(List<Errors> errors)? valueOnErrorHandler,
    Future<TValue?>? valueOnError,
    Future<Errors>? errorOnError,
  }) async {
    if (!_isError) {
      return value.toErrorOr();
    }
    return (await valueOnError)?.toErrorOr() ??
        (await valueOnErrorHandler?.call(errors))?.toErrorOr() ??
        (await errorOnError)?.toErrorOr<TValue>() ??
        (await errorOnErrorHandler?.call(errors))?.toErrorOr<TValue>() ??
        (await errorsOnErrorHandler?.call(errors))?.toErrorOr<TValue>() ??
        errors.toErrorOr<TValue>();
  }

  /// A class representing a result that can either be an error or a value.
  /// Returns a new [ErrorOr] instance with the specified [onValue] and [error].
  ///
  /// If the current instance is already an error, it returns itself.
  /// Otherwise, it checks if the [onValue] function returns true for the current value.
  /// If it does, it returns a new [ErrorOr] instance created from the [error].
  /// Otherwise, it returns itself.
  ErrorOr<TValue> failIf(
    bool Function(TValue value) onValue,
    Errors error,
  ) {
    if (_isError) {
      return this;
    }
    return onValue(value) ? error.toErrorOr<TValue>() : this;
  }

  /// A method that checks if the current [ErrorOr] instance is not an error and
  /// evaluates a given condition asynchronously. If the condition is true, it
  /// returns an [ErrorOr] instance created from the provided [Errors] object.
  /// Otherwise, it returns the current [ErrorOr] instance.
  ///
  /// The [onValue] function takes a value of type [TValue] and returns a
  /// [Future<bool>] indicating whether the condition is true or false.
  ///
  /// The [error] parameter is an instance of the [Errors] class that represents
  /// the error to be returned if the condition is true.
  ///
  /// Returns a [Future<ErrorOr<TValue>>] representing the result of the operation.
  Future<ErrorOr<TValue>> failIfAsync(
    Future<bool> Function(TValue value) onValue,
    Errors error,
  ) async {
    if (_isError) {
      return this;
    }
    return await onValue(value) ? error.toErrorOr<TValue>() : this;
  }

  /// Matches the value of the `ErrorOr` instance and returns a result based on whether it is an error or a value.
  ///
  /// The [match] method takes two functions as parameters: [onValue] and [onError].
  /// If the `ErrorOr` instance contains a value, the [onValue] function is called with the value as an argument,
  /// and the result of the function is returned.
  /// If the `ErrorOr` instance contains errors, the [onError] function is called with the list of errors as an argument,
  /// and the result of the function is returned.
  ///
  /// The type parameter [TNextValue] represents the type of the result returned by the [onValue] and [onError] functions.
  /// The type parameter [TValue] represents the type of the value contained in the `ErrorOr` instance.
  ///
  /// Example usage:
  /// ```dart
  /// ErrorOr<int> result = ErrorOr.value(42);
  /// int value = result.match(
  ///   (int val) => val * 2,
  ///   (List<Errors> errors) => -1,
  /// );
  /// print(value); // Output: 84
  /// ```
  TNextValue match<TNextValue>(
    TNextValue Function(TValue value) onValue,
    TNextValue Function(List<Errors> errors) onError,
  ) {
    if (_isError) {
      return onError(errors);
    }
    return onValue(value);
  }

  /// Matches the value or errors of the [ErrorOr] instance and returns a future result.
  ///
  /// The [matchAsync] method takes two parameters: [onValue] and [onError].
  /// - [onValue] is a function that takes a value of type [TValue] and returns a future result of type [TNextValue].
  /// - [onError] is a function that takes a list of [Errors] and returns a future result of type [TNextValue].
  ///
  /// If the [ErrorOr] instance contains an error, the [onError] function will be called with the list of errors.
  /// If the [ErrorOr] instance contains a value, the [onValue] function will be called with the value.
  ///
  /// The [matchAsync] method returns a future result of type [TNextValue].
  ///
  /// Example usage:
  /// ```dart
  /// ErrorOr<int> result = ErrorOr<int>.value(42);
  /// int doubledValue = await result.matchAsync(
  ///   (value) => Future.value(value * 2),
  ///   (errors) => Future.error(Exception('Error occurred')),
  /// );
  /// print(doubledValue); // Output: 84
  /// ```
  Future<TNextValue> matchAsync<TNextValue>(
    Future<TNextValue> Function(TValue value) onValue,
    Future<TNextValue> Function(List<Errors> errors) onError,
  ) async {
    if (_isError) {
      return await onError(errors);
    }
    return await onValue(value);
  }

  /// Matches the value of the `ErrorOr` instance and returns the result of the matching function.
  ///
  /// The [matchFirst] method takes two functions as parameters: [onValue] and [onError].
  /// If the `ErrorOr` instance contains a value, the [onValue] function is called with the value as an argument,
  /// and its result is returned. If the `ErrorOr` instance contains an error, the [onError] function is called
  /// with the error as an argument, and its result is returned.
  ///
  /// The type parameter [TNextValue] represents the type of the value returned by the matching functions.
  ///
  /// Example usage:
  /// ```dart
  /// ErrorOr<int> result = ErrorOr<int>.value(42);
  /// int value = result.matchFirst(
  ///   (int val) => val * 2,
  ///   (Errors error) => -1,
  /// );
  /// print(value); // Output: 84
  /// ```
  TNextValue matchFirst<TNextValue>(
    TNextValue Function(TValue value) onValue,
    TNextValue Function(Errors error) onError,
  ) {
    if (_isError) {
      return onError(firstError);
    }
    return onValue(value);
  }

  /// Matches the value or error of the `ErrorOr` instance and returns a future result.
  ///
  /// The [matchFirstAsync] method takes two parameters: [onValue] and [onError].
  /// - The [onValue] parameter is a function that takes a value of type [TValue] and returns a future result of type [TNextValue].
  /// - The [onError] parameter is a function that takes an [Errors] object representing the error and returns a future result of type [TNextValue].
  ///
  /// If the `ErrorOr` instance contains an error, the [onError] function will be called with the first error encountered.
  /// If the `ErrorOr` instance contains a value, the [onValue] function will be called with the value.
  ///
  /// The method returns a future result of type [TNextValue].
  Future<TNextValue> matchFirstAsync<TNextValue>(
    Future<TNextValue> Function(TValue value) onValue,
    Future<TNextValue> Function(Errors error) onError,
  ) async {
    if (_isError) {
      return await onError(firstError);
    }
    return await onValue(value);
  }

  /// Performs a switch operation based on the state of the `ErrorOr` object.
  ///
  /// If the object represents an error, the [onError] function is called with the list of errors.
  /// If the object represents a value, the [onValue] function is called with the value.
  ///
  /// The [onValue] and [onError] functions are required and must be provided.
  void doSwitch(
    Function(TValue value) onValue,
    Function(List<Errors> errors) onError,
  ) {
    if (_isError) {
      onError(errors);
    } else {
      onValue(value);
    }
  }

  /// Performs a switch operation asynchronously based on the state of the [ErrorOr] object.
  ///
  /// If the [ErrorOr] object represents an error, the [onError] function will be called with the list of errors.
  /// If the [ErrorOr] object represents a value, the [onValue] function will be called with the value.
  ///
  /// Returns a [Future] that completes when the switch operation is done.
  Future doSwitchAsync(
    Future Function(TValue value) onValue,
    Future Function(List<Errors> errors) onError,
  ) async {
    if (_isError) {
      await onError(errors);
    } else {
      await onValue(value);
    }
  }

  /// Performs a switch operation on the `ErrorOr` object.
  ///
  /// If the object contains a value, the [onValue] function is called with the value.
  /// If the object contains an error, the [onFirstError] function is called with the error.
  ///
  /// Example usage:
  /// ```dart
  /// ErrorOr<int> result = ErrorOr<int>.value(42);
  /// result.doSwitchFirst(
  ///   (value) => print('Value: $value'),
  ///   (error) => print('Error: $error'),
  /// );
  /// ```
  doSwitchFirst(
    Function(TValue value) onValue,
    Function(Errors error) onFirstError,
  ) {
    if (_isError) {
      onFirstError(firstError);
    } else {
      onValue(value);
    }
  }

  /// Performs a switch operation based on the state of the [ErrorOr] object.
  ///
  /// If the object represents an error, the [onFirstError] function is called
  /// with the first error encountered. If the object represents a value, the
  /// [onValue] function is called with the value.
  ///
  /// Returns a [Future] that completes when the switch operation is finished.
  Future doSwitchFirstAsync(
    Future Function(TValue value) onValue,
    Future Function(Errors error) onFirstError,
  ) async {
    if (_isError) {
      await onFirstError(firstError);
    } else {
      await onValue(value);
    }
  }

  /// Represents a computation that may either produce a value of type [TValue] or an error.
  /// Chains a computation to be executed if this [ErrorOr] contains a value.
  ///
  /// The [onValue] function takes the current value of type [TValue] and returns
  /// an [ErrorOr] of type [TNextValue]. If this [ErrorOr] contains an error,
  /// the errors are converted to an [ErrorOr] of type [TNextValue].
  ///
  /// Returns the result of the computation as an [ErrorOr] of type [TNextValue].
  ErrorOr<TNextValue> also<TNextValue>(
    ErrorOr<TNextValue> Function(TValue value) onValue,
  ) {
    if (_isError) {
      return this.errors.toErrorOr<TNextValue>();
    }

    return onValue(value);
  }

  /// Executes the provided function [onValue] if the [ErrorOr] instance is not an error.
  /// The [onValue] function takes a single argument of type [TValue] and returns no value.
  /// Returns the current [ErrorOr] instance.
  ErrorOr<TValue> alsoDo(
    Function(TValue value) onValue,
  ) {
    if (!_isError) {
      onValue(value);
    }

    return this;
  }

  /// A helper method that allows chaining asynchronous operations on a [ErrorOr] instance.
  ///
  /// It takes a callback function [onValue] that will be called if the current [ErrorOr] instance
  /// contains a value. The callback function receives the value as a parameter and should return
  /// a [Future<ErrorOr<TNextValue>>]. If the current [ErrorOr] instance contains an error, it
  /// converts the error to an [ErrorOr<TNextValue>] and returns it.
  ///
  /// Returns a [Future<ErrorOr<TNextValue>>] representing the result of the asynchronous operation.
  Future<ErrorOr<TNextValue>> alsoAsync<TNextValue>(
    Future<ErrorOr<TNextValue>> Function(TValue value) onValue,
  ) async {
    if (_isError) {
      return this.errors.toErrorOr<TNextValue>();
    }

    return await onValue(value);
  }

  /// A helper method that allows chaining asynchronous operations on a [ErrorOr] object.
  ///
  /// The [alsoDoAsync] method takes a callback function [onValue] that will be executed if the [ErrorOr] object is not an error.
  /// The [onValue] function should take a single parameter of type [TValue] and return a [Future].
  ///
  /// If the [ErrorOr] object is not an error, the [onValue] function will be called with the value of the [ErrorOr] object.
  ///
  /// Returns a [Future] that completes with the original [ErrorOr] object.
  Future<ErrorOr<TValue>> alsoDoAsync(
    Future Function(TValue value) onValue,
  ) async {
    if (!_isError) {
      await onValue(value);
    }

    return this;
  }

  /// Returns the value if the [ErrorOr] is not an error, otherwise returns null.
  TValue? get valueOrNull => isError ? null : value;
}
