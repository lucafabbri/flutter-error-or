import '../error_or_plus.dart';

/// The `extension ErrorOrDoThenExt<TValue> on Future<ErrorOr<TValue>>` is creating an extension method
/// for `Future<ErrorOr<TValue>>`. This extension method provides additional functionality to work with
/// `Future` objects that contain `ErrorOr` values. It adds methods like `then`, `thenDo`, `thenAsync`,
/// and `thenDoAsync` to the `Future<ErrorOr<TValue>>` type, allowing for easier chaining and processing
/// of asynchronous operations that may result in an `ErrorOr` value.
/// The `extension ErrorOrDoSwitchExt<TValue> on Future<ErrorOr<TValue>>` is creating an extension
/// method for `Future<ErrorOr<TValue>>`. This extension method allows you to add additional
/// functionality to objects of type `Future<ErrorOr<TValue>>` without modifying the original class
/// definition.
extension ErrorOrDoThenExt<TValue> on Future<ErrorOr<TValue>> {
  /// The `then` function takes a callback that transforms the current value inside a
  /// `Future<ErrorOr<TValue>>` into a new value of type `ErrorOr<TNextValue>`.
  ///
  /// Args:
  ///   onValue (ErrorOr<TNextValue> Function(TValue value)): The `onValue` parameter is a function that
  /// takes a value of type `TValue` and returns an `ErrorOr<TNextValue>`.
  ///
  /// Returns:
  ///   A `Future<ErrorOr<TNextValue>>` is being returned.
  Future<ErrorOr<TNextValue>> then<TNextValue>(
    ErrorOr<TNextValue> Function(TValue value) onValue,
  ) async {
    var result = await this;
    return result.then(onValue);
  }

  /// The `thenDo` function takes a callback function and applies it to the value inside a
  /// `Future<ErrorOr<TValue>>`.
  ///
  /// Args:
  ///   onValue (Function(TValue value)): The `onValue` parameter is a function that takes a single
  /// argument of type `TValue` and returns a value of any type. It is used to process the value contained
  /// in the `Future<ErrorOr<TValue>>` object when the future completes successfully.
  ///
  /// Returns:
  ///   A `Future<ErrorOr<TValue>>` is being returned.
  Future<ErrorOr<TValue>> thenDo(
    Function(TValue value) onValue,
  ) async {
    var result = await this;
    return result.thenDo(onValue);
  }

  /// The `thenAsync` function takes a callback that operates on a value wrapped in a `Future` and returns
  /// a new `Future` with the transformed value.
  ///
  /// Args:
  ///   onValue (Future<ErrorOr<TNextValue>> Function(TValue value)): The `onValue` parameter is a
  /// function that takes a value of type `TValue` and returns a `Future` that resolves to an
  /// `ErrorOr<TNextValue>`.
  ///
  /// Returns:
  ///   The `thenAsync` method is returning a `Future` that will eventually contain the result of applying
  /// the `onValue` function to the value inside the original `Future`.
  Future thenAsync<TNextValue>(
    Future<ErrorOr<TNextValue>> Function(TValue value) onValue,
  ) async {
    var result = await this;
    return await result.thenAsync(onValue);
  }

  /// The `thenDoAsync` function takes a future value, applies an asynchronous function to it, and returns
  /// a future result.
  ///
  /// Args:
  ///   onValue (Future Function(TValue value)): The `onValue` parameter is a function that takes a value
  /// of type `TValue` and returns a `Future`.
  ///
  /// Returns:
  ///   A `Future<ErrorOr<TValue>>` is being returned.
  Future<ErrorOr<TValue>> thenDoAsync(
    Future Function(TValue value) onValue,
  ) async {
    var result = await this;
    return await result.thenDoAsync(onValue);
  }
}
