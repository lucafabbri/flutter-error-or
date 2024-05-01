import '../error_or_plus.dart';

/// This Dart extension `ErrorOrMatchExt` is extending the functionality of a `Future` containing an
/// `ErrorOr` type. It provides methods to handle the `ErrorOr` result asynchronously by matching on the
/// value or errors it may contain. The extension includes methods like `match`, `matchAsync`,
/// `matchFirst`, and `matchFirstAsync` which allow you to specify functions to handle the success value
/// or errors inside the `ErrorOr` type.
extension ErrorOrMatchExt<TValue, TNextValue> on Future<ErrorOr<TValue>> {
  /// The `match` function takes two callback functions and returns the result of applying them to the
  /// value or errors of a future.
  ///
  /// Args:
  ///   onValue (TNextValue Function(TValue value)): The `onValue` parameter is a function that takes a
  /// value of type `TValue` and returns a value of type `TNextValue`.
  ///   onError (TNextValue Function(List<Errors> errors)): The `onError` parameter is a function that
  /// takes a list of errors as input and returns a `TNextValue` type. It is used in the `match` method to
  /// handle the case when there are errors in the result.
  ///
  /// Returns:
  ///   The `match` function is returning a `Future<TNextValue>`.
  Future<TNextValue> match(
    TNextValue Function(TValue value) onValue,
    TNextValue Function(List<Errors> errors) onError,
  ) async {
    var result = await this;
    return result.match(onValue, onError);
  }

  Future<TNextValue> matchAsync(
    Future<TNextValue> Function(TValue value) onValue,
    Future<TNextValue> Function(List<Errors> errors) onError,
  ) async {
    var result = await this;
    return await result.matchAsync(onValue, onError);
  }

  Future<TNextValue> matchFirst(
    TNextValue Function(TValue value) onValue,
    TNextValue Function(Errors error) onError,
  ) async {
    var result = await this;
    return result.matchFirst(onValue, onError);
  }

  Future<TNextValue> matchFirstAsync(
    Future<TNextValue> Function(TValue value) onValue,
    Future<TNextValue> Function(Errors error) onError,
  ) async {
    var result = await this;
    return await result.matchFirstAsync(onValue, onError);
  }
}
