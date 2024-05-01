import '../error_or_plus.dart';

/// The `extension ErrorOrDoSwitchExt<TValue> on Future<ErrorOr<TValue>>` is creating an extension
/// method for `Future<ErrorOr<TValue>>`. This extension method allows you to chain additional methods
/// onto a `Future` that resolves to an `ErrorOr` type, providing more functionality to handle the
/// result of asynchronous operations that may contain errors.
extension ErrorOrDoSwitchExt<TValue> on Future<ErrorOr<TValue>> {
  /// The `doSwitch` function takes two callback functions, `onValue` and `onError`, and executes them
  /// based on the result of an asynchronous operation.
  ///
  /// Args:
  ///   onValue (Function(TValue value)): The `onValue` parameter is a function that takes a single
  /// argument of type `TValue` and returns a value. It is used to handle the successful result of the
  /// asynchronous operation.
  ///   onError (Function(List<Errors> errors)): The `onError` parameter is a function that takes a list
  /// of `Errors` objects as input and returns a result.
  ///
  /// Returns:
  ///   The `Future` returned by the `doSwitch` method.
  Future doSwitch(
    Function(TValue value) onValue,
    Function(List<Errors> errors) onError,
  ) async {
    var result = await this;
    return result.doSwitch(onValue, onError);
  }

  /// This function takes two asynchronous functions as parameters and executes them based on the result
  /// of the initial asynchronous operation.
  ///
  /// Args:
  ///   onValue (Future Function(TValue value)): A function that takes a value of type `TValue` and
  /// returns a `Future`.
  ///   onError (Future Function(List<Errors> errors)): The `onError` parameter is a function that takes a
  /// list of `Errors` objects as input and returns a `Future`.
  ///
  /// Returns:
  ///   The `doSwitchAsync` method is being returned, which takes two parameters: `onValue` and `onError`,
  /// both of which are functions that return a `Future`.
  Future doSwitchAsync(
    Future Function(TValue value) onValue,
    Future Function(List<Errors> errors) onError,
  ) async {
    var result = await this;
    return await result.doSwitchAsync(onValue, onError);
  }

  /// This function takes two callback functions, `onValue` and `onError`, and calls `doSwitchFirst` on
  /// the result of an asynchronous operation.
  ///
  /// Args:
  ///   onValue (Function(TValue value)): The `onValue` parameter is a function that takes a single
  /// argument of type `TValue` and returns a value.
  ///   onError (Function(Errors error)): The `onError` parameter is a function that takes an `Errors`
  /// object as an argument. This function is called when an error occurs during the asynchronous
  /// operation.
  ///
  /// Returns:
  ///   The `doSwitchFirst` function is being returned with the `onValue` and `onError` functions passed
  /// as arguments.
  Future doSwitchFirst(
    Function(TValue value) onValue,
    Function(Errors error) onError,
  ) async {
    var result = await this;
    return result.doSwitchFirst(onValue, onError);
  }

  /// The function `doSwitchFirstAsync` takes two asynchronous functions as parameters and recursively
  /// applies them to the result until a value is found.
  ///
  /// Args:
  ///   onValue (Future Function(TValue value)): The `onValue` parameter is a function that takes a single
  /// argument of type `TValue` and returns a `Future`.
  ///   onError (Future Function(Errors error)): The `onError` parameter is a function that takes an
  /// `Errors` object as input and returns a `Future`. This function is called when an error occurs during
  /// the asynchronous operation.
  ///
  /// Returns:
  ///   The `doSwitchFirstAsync` function is being returned, which takes two parameters: `onValue` and
  /// `onError`.
  Future doSwitchFirstAsync(
    Future Function(TValue value) onValue,
    Future Function(Errors error) onError,
  ) async {
    var result = await this;
    return await result.doSwitchFirstAsync(onValue, onError);
  }
}
