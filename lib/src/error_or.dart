import 'package:error_or_plus/error_or_plus.dart';

class ErrorOr<TValue> {
  final TValue? _value;
  final List<Errors> _errors;
  static final noFirstError = Errors.unexpected(
    code: "ErrorOr.NoFirstError",
    description: "First error cannot be retrieved from a successful ErrorOr.",
  );
  static final noErrors = Errors.unexpected(
    code: "ErrorOr.NoErrors",
    description: "Error list cannot be retrieved from a successful ErrorOr.",
  );
  final bool _isError;
  bool get isError => _isError;
  List<Errors> get errors => _isError ? _errors : [noErrors];
  List<Errors> get errorsOrEmptyList => _isError ? _errors : [];

  ErrorOr.fromErrors(List<Errors> errors)
      : _errors = errors,
        _value = null,
        _isError = errors.isNotEmpty;

  ErrorOr.fromError(Errors error)
      : _errors = [error],
        _value = null,
        _isError = true;

  ErrorOr.fromValue(TValue value)
      : _errors = [],
        _value = value,
        _isError = false;

  TValue get value => _value!;

  Errors get firstError => _isError ? _errors.first : noFirstError;

  ErrorOr<TValue> orElse({
    Errors Function(List<Errors> errors)? errorOnErrorHandler,
    List<Errors> Function(List<Errors> errors)? errorsOnErrorHandler,
    TValue Function(List<Errors> errors)? valueOnErrorHandler,
    TValue? valueOnError,
    Errors? errorOnError,
  }) {
    if (!_isError) {
      return value.toErrorOr();
    }
    return valueOnError?.toErrorOr() ??
        valueOnErrorHandler?.call(errors).toErrorOr() ??
        errorOnError?.toErrorOr<TValue>() ??
        errorOnErrorHandler?.call(errors).toErrorOr<TValue>() ??
        errorsOnErrorHandler?.call(errors).toErrorOr<TValue>() ??
        errors.toErrorOr<TValue>();
  }

  Future<ErrorOr<TValue>> orElseAsync({
    Future<Errors> Function(List<Errors> errors)? errorOnErrorHandler,
    Future<List<Errors>> Function(List<Errors> errors)? errorsOnErrorHandler,
    Future<TValue> Function(List<Errors> errors)? valueOnErrorHandler,
    Future<TValue>? valueOnError,
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

  ErrorOr<TValue> failIf(
    bool Function(TValue value) onValue,
    Errors error,
  ) {
    if (_isError) {
      return this;
    }
    return onValue(value) ? error.toErrorOr<TValue>() : this;
  }

  Future<ErrorOr<TValue>> failIfAsync(
    Future<bool> Function(TValue value) onValue,
    Errors error,
  ) async {
    if (_isError) {
      return this;
    }
    return await onValue(value) ? error.toErrorOr<TValue>() : this;
  }

  TNextValue match<TNextValue>(
    TNextValue Function(TValue value) onValue,
    TNextValue Function(List<Errors> errors) onError,
  ) {
    if (_isError) {
      return onError(errors);
    }
    return onValue(value);
  }

  Future<TNextValue> matchAsync<TNextValue>(
    Future<TNextValue> Function(TValue value) onValue,
    Future<TNextValue> Function(List<Errors> errors) onError,
  ) async {
    if (_isError) {
      return await onError(errors);
    }
    return await onValue(value);
  }

  TNextValue matchFirst<TNextValue>(
    TNextValue Function(TValue value) onValue,
    TNextValue Function(Errors error) onError,
  ) {
    if (_isError) {
      return onError(firstError);
    }
    return onValue(value);
  }

  Future<TNextValue> matchFirstAsync<TNextValue>(
    Future<TNextValue> Function(TValue value) onValue,
    Future<TNextValue> Function(Errors error) onError,
  ) async {
    if (_isError) {
      return await onError(firstError);
    }
    return await onValue(value);
  }

  doSwitch(
    Function(TValue value) onValue,
    Function(List<Errors> errors) onError,
  ) {
    if (_isError) {
      onError(errors);
    } else {
      onValue(value);
    }
  }

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

  ErrorOr<TNextValue> then<TNextValue>(
    ErrorOr<TNextValue> Function(TValue value) onValue,
  ) {
    if (_isError) {
      return this.errors.toErrorOr<TNextValue>();
    }

    return onValue(value);
  }

  ErrorOr<TValue> thenDo(
    Function(TValue value) onValue,
  ) {
    if (!_isError) {
      onValue(value);
    }

    return this;
  }

  Future<ErrorOr<TNextValue>> thenAsync<TNextValue>(
    Future<ErrorOr<TNextValue>> Function(TValue value) onValue,
  ) async {
    if (_isError) {
      return this.errors.toErrorOr<TNextValue>();
    }

    return await onValue(value);
  }

  Future<ErrorOr<TValue>> thenDoAsync(
    Future Function(TValue value) onValue,
  ) async {
    if (!_isError) {
      await onValue(value);
    }

    return this;
  }
}
