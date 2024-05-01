import '../error_or_plus.dart';

extension ValueToErrorOrExt<TValue> on TValue {
  ErrorOr<TValue> toErrorOr() => ErrorOr.fromValue(this);
}

extension ErrorToErrorOrExt on Errors {
  ErrorOr<TValue> toErrorOr<TValue>() => ErrorOr.fromError(this);
}

extension ListErrorsToErrorOrExt on List<Errors> {
  ErrorOr<TValue> toErrorOr<TValue>() => ErrorOr.fromErrors(this);
}
