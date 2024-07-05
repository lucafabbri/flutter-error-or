import '../error_or_plus.dart';

extension ErrorOrElseExt<TValue> on Future<ErrorOr<TValue>> {
  Future<ErrorOr<TValue>> orElse({
    Errors Function(List<Errors> errors)? errorOnErrorHandler,
    List<Errors> Function(List<Errors> errors)? errorsOnErrorHandler,
    TValue? Function(List<Errors> errors)? valueOnErrorHandler,
    TValue? valueOnError,
    Errors? errorOnError,
  }) async {
    var result = await this;
    return result.orElse(
      errorOnError: errorOnError,
      errorOnErrorHandler: errorOnErrorHandler,
      errorsOnErrorHandler: errorsOnErrorHandler,
      valueOnError: valueOnError,
      valueOnErrorHandler: valueOnErrorHandler,
    );
  }

  Future<ErrorOr<TValue>> orElseAsync({
    Future<Errors> Function(List<Errors> errors)? errorOnErrorHandler,
    Future<List<Errors>> Function(List<Errors> errors)? errorsOnErrorHandler,
    Future<TValue?> Function(List<Errors> errors)? valueOnErrorHandler,
    Future<TValue?>? valueOnError,
    Future<Errors>? errorOnError,
  }) async {
    var result = await this;
    return result.orElseAsync(
      errorOnError: errorOnError,
      errorOnErrorHandler: errorOnErrorHandler,
      errorsOnErrorHandler: errorsOnErrorHandler,
      valueOnError: valueOnError,
      valueOnErrorHandler: valueOnErrorHandler,
    );
  }
}
