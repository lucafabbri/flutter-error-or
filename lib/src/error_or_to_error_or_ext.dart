import '../error_or_plus.dart';

/// This Dart extension named `ValueToErrorOrExt` is adding a method `toErrorOr()` to any type `TValue`.
/// This method allows converting a value of type `TValue` into an `ErrorOr<TValue>` object by calling
/// the `fromValue` constructor of the `ErrorOr` class and passing the value as a parameter. This
/// extension simplifies the process of creating an `ErrorOr` object from a single value.

extension ValueToErrorOrExt<TValue> on TValue {
  ErrorOr<TValue> toErrorOr() => ErrorOr.fromValue(this);
}

/// This extension named `ErrorToErrorOrExt` is adding a method `toErrorOr<TValue>()` to the `Errors`
/// type. This method returns an `ErrorOr<TValue>` object by calling the `fromError` constructor of the
/// `ErrorOr` class and passing the `Errors` object as a parameter.
extension ErrorToErrorOrExt on Errors {
  ErrorOr<TValue> toErrorOr<TValue>() => ErrorOr.fromError(this);
}

/// This extension named `ListErrorsToErrorOrExt` is adding a method `toErrorOr<TValue>()` to the
/// `List<Errors>` type. This method returns an `ErrorOr<TValue>` object by calling the `fromErrors`
/// constructor of the `ErrorOr` class and passing the list of `Errors` as a parameter.
extension ListErrorsToErrorOrExt on List<Errors> {
  ErrorOr<TValue> toErrorOr<TValue>() => ErrorOr.fromErrors(this);
}
