import '../error_or_plus.dart';

/// The `ErrorOr` class in Dart provides a way to handle values that may contain errors, allowing for
/// error handling and chaining operations based on the presence of errors.
class ErrorOr<TValue> {
  final TValue? _value;
  final List<Errors> _errors;

  /// The `static final noFirstError` declaration in the `ErrorOr` class is creating a constant instance
  /// of the `Errors` class with a specific code and description. This constant represents a scenario
  /// where there is no first error to retrieve from a successful `ErrorOr` instance. It is used as a
  /// default value when attempting to access the first error in a successful `ErrorOr` instance.
  static final noFirstError = Errors.unexpected(
    code: "ErrorOr.NoFirstError",
    description: "First error cannot be retrieved from a successful ErrorOr.",
  );

  /// The `static final noErrors` declaration in the `ErrorOr` class is creating a constant instance of
  /// the `Errors` class with a specific code and description. This constant represents a scenario where
  /// an error list cannot be retrieved from a successful `ErrorOr` instance. It is used as a default
  /// value when attempting to access the error list in a successful `ErrorOr` instance.
  static final noErrors = Errors.unexpected(
    code: "ErrorOr.NoErrors",
    description: "Error list cannot be retrieved from a successful ErrorOr.",
  );

  final bool _isError;

  /// The `bool get isError => _isError;` in the `ErrorOr` class is creating a getter method named
  /// `isError` that returns the `_isError` property of the class. This getter method allows external
  /// code to access the `_isError` property of an `ErrorOr` instance without directly accessing the
  /// property itself. It provides a convenient way to check if the current `ErrorOr` instance
  /// represents an error state.
  bool get isError => _isError;

  /// The `List<Errors> get errors => _isError ? _errors : [noErrors];` in the `ErrorOr` class is a
  /// getter method named `errors` that returns a list of errors.
  List<Errors> get errors => _isError ? _errors : [noErrors];

  /// The `List<Errors> get errorsOrEmptyList => _isError ? _errors : [];` in the `ErrorOr` class is a
  /// getter method named `errorsOrEmptyList` that returns a list of errors if the current `ErrorOr`
  /// instance represents an error state (`_isError` is true). If there are errors present, it returns
  /// the `_errors` list. If there are no errors (i.e., `_isError` is false), it returns an empty list
  /// `[]`.
  List<Errors> get errorsOrEmptyList => _isError ? _errors : [];

  /// The `ErrorOr.fromErrors(List<Errors> errors)` constructor in the `ErrorOr` class is creating an
  /// instance of `ErrorOr` with a list of errors. It initializes the `_errors` property of the
  /// `ErrorOr` instance with the provided list of errors, sets the `_value` property to `null` since
  /// there is no value associated with errors, and determines the `_isError` property based on whether
  /// the list of errors is not empty.
  ErrorOr.fromErrors(List<Errors> errors)
      : _errors = errors,
        _value = null,
        _isError = errors.isNotEmpty;

  /// The `ErrorOr.fromError(Errors error)` constructor in the `ErrorOr` class is creating an instance
  /// of `ErrorOr` with a single error. It initializes the `_errors` property of the `ErrorOr` instance
  /// with a list containing the provided error, sets the `_value` property to `null` since there is no
  /// value associated with the error, and sets the `_isError` property to true to indicate that this
  /// instance represents an error state.
  ErrorOr.fromError(Errors error)
      : _errors = [error],
        _value = null,
        _isError = true;

  /// The `ErrorOr.fromValue(TValue value)` constructor in the `ErrorOr` class is creating an instance
  /// of `ErrorOr` with a successful value. It initializes the `_value` property of the `ErrorOr`
  /// instance with the provided value, sets the `_errors` property to an empty list since there are no
  /// errors associated with the value, and sets the `_isError` property to false to indicate that this
  /// instance represents a successful state without errors.
  ErrorOr.fromValue(TValue value)
      : _errors = [],
        _value = value,
        _isError = false;

  /// The line `TValue get value => _value!;` in the `ErrorOr` class is creating a getter method named
  /// `value` that returns the `_value` property of the class. The `!` operator is used to assert that
  /// `_value` is non-nullable, meaning it cannot be null. This getter method allows external code to
  /// access the `_value` property of an `ErrorOr` instance and retrieve the value it holds.
  TValue get value => _value!;

  /// The `Errors get firstError => _isError ? _errors.first : noFirstError;` line in the `ErrorOr`
  /// class is creating a getter method named `firstError`. This getter method is used to retrieve the
  /// first error in the `_errors` list if the `ErrorOr` instance represents an error state (`_isError`
  /// is true).
  Errors get firstError => _isError ? _errors.first : noFirstError;

  /// The `orElse` function in Dart returns an `ErrorOr` object based on specified error handling logic or
  /// default values.
  ///
  /// Args:
  ///   errorOnErrorHandler (Errors Function(List<Errors> errors)?): The `errorOnErrorHandler` parameter
  /// is a function that takes a list of errors as input and returns an `Errors` object. This function is
  /// used to handle errors when converting them to a specific type of value.
  ///   errorsOnErrorHandler (List<Errors> Function(List<Errors> errors)?): The `errorsOnErrorHandler`
  /// parameter in the `orElse` method is a function that takes a list of errors as input and returns a
  /// list of errors. This function is used to handle errors when the current value is an error. If
  /// provided, it will be called with the list of errors and should
  ///   valueOnErrorHandler (TValue Function(List<Errors> errors)?): The `valueOnErrorHandler` parameter
  /// in the `orElse` method is a function that takes a list of errors as input and returns a value of
  /// type `TValue`. If the current `ErrorOr` instance is in an error state, this function can be used to
  /// handle the errors and return a
  ///   valueOnError (TValue): The `valueOnError` parameter in the `orElse` method is a value of type
  /// `TValue` that will be returned as an `ErrorOr` instance if the current instance is an error. If the
  /// `valueOnError` parameter is not provided or is null, then the `valueOnErrorHandler
  ///   errorOnError (Errors): The `errorOnError` parameter in the `orElse` method is used to provide a
  /// default error value if the current value is an error. If the current value is not an error, the
  /// method will return the current value wrapped in an `ErrorOr` object.
  ///
  /// Returns:
  ///   The `orElse` method is returning an `ErrorOr<TValue>` object.
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

  /// The function `orElseAsync` returns an `ErrorOr` object based on different error handling scenarios.
  ///
  /// Args:
  ///   errorOnErrorHandler (Future<Errors> Function(List<Errors> errors)?): The `errorOnErrorHandler`
  /// parameter is a function that takes a list of errors as input and returns a Future containing a
  /// single `Errors` object. This function is used to handle errors when there is an error in the
  /// original `Future<ErrorOr<TValue>>` computation.
  ///   errorsOnErrorHandler (Future<List<Errors>> Function(List<Errors> errors)?): The
  /// `errorsOnErrorHandler` parameter is a function that takes a list of errors as input and returns a
  /// future that resolves to a list of errors. This function is used in the `orElseAsync` method to
  /// handle errors when there are multiple errors present. If the primary error handling mechanisms fail
  /// to resolve
  ///   valueOnErrorHandler (Future<TValue> Function(List<Errors> errors)?): The `valueOnErrorHandler`
  /// parameter is a function that takes a list of errors as input and returns a future that resolves to a
  /// value of type `TValue`. If an error occurs during the processing of the original future, this
  /// function can be called to handle the errors and return a new value asynchronously
  ///   valueOnError (Future<TValue>): The `valueOnError` parameter is a `Future` that represents a value
  /// to be returned in case there is an error. If there is no error, the value will be converted to an
  /// `ErrorOr` type and returned.
  ///   errorOnError (Future<Errors>): The `errorOnError` parameter in the `orElseAsync` function is a
  /// `Future<Errors>` type that represents a future containing errors to be handled in case of an error
  /// scenario.
  ///
  /// Returns:
  ///   The `orElseAsync` function returns a `Future` that resolves to an `ErrorOr` object containing a
  /// value of type `TValue` or a list of errors.
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

  /// The `failIf` function returns an `ErrorOr` object with an error if a condition is met, otherwise it
  /// returns the original object.
  ///
  /// Args:
  ///   onValue (bool Function(TValue value)): The `onValue` parameter is a function that takes a value of
  /// type `TValue` as input and returns a boolean value. It is used to determine whether a certain
  /// condition is met based on the input value.
  ///   error (Errors): The `error` parameter in the `failIf` function is of type `Errors`. It is used to
  /// specify the error that should be returned if the condition provided in the `onValue` function is
  /// met.
  ///
  /// Returns:
  ///   The `failIf` function returns an `ErrorOr<TValue>` object.
  ErrorOr<TValue> failIf(
    bool Function(TValue value) onValue,
    Errors error,
  ) {
    if (_isError) {
      return this;
    }
    return onValue(value) ? error.toErrorOr<TValue>() : this;
  }

  /// The `failIfAsync` function returns an `ErrorOr` object based on the result of an asynchronous check
  /// on a value.
  ///
  /// Args:
  ///   onValue (Future<bool> Function(TValue value)): The `onValue` parameter is a function that takes a
  /// value of type `TValue` and returns a `Future<bool>`.
  ///   error (Errors): The `error` parameter in the `failIfAsync` function represents an error object
  /// that can be converted to an `ErrorOr<TValue>` type.
  ///
  /// Returns:
  ///   A `Future<ErrorOr<TValue>>` is being returned.
  Future<ErrorOr<TValue>> failIfAsync(
    Future<bool> Function(TValue value) onValue,
    Errors error,
  ) async {
    if (_isError) {
      return this;
    }
    return await onValue(value) ? error.toErrorOr<TValue>() : this;
  }

  /// The `match` function in Dart takes two functions as arguments and returns the result of one of them
  /// based on whether an error occurred or not.
  ///
  /// Args:
  ///   onValue (TNextValue Function(TValue value)): The `onValue` parameter is a function that takes a
  /// value of type `TValue` and returns a value of type `TNextValue`.
  ///   onError (TNextValue Function(List<Errors> errors)): The `onError` parameter is a function that
  /// takes a list of `Errors` as input and returns a value of type `TNextValue`.
  ///
  /// Returns:
  ///   The `match` function is returning either the result of the `onError` function if `_isError` is
  /// true, or the result of the `onValue` function if `_isError` is false.
  TNextValue match<TNextValue>(
    TNextValue Function(TValue value) onValue,
    TNextValue Function(List<Errors> errors) onError,
  ) {
    if (_isError) {
      return onError(errors);
    }
    return onValue(value);
  }

  /// The `matchAsync` function in Dart takes two asynchronous functions as parameters and executes one of
  /// them based on whether an error occurred or not.
  ///
  /// Args:
  ///   onValue (Future<TNextValue> Function(TValue value)): The `onValue` parameter is a function that
  /// takes a value of type `TValue` and returns a `Future<TNextValue>`. It is used to handle the case
  /// when there is no error and process the value accordingly.
  ///   onError (Future<TNextValue> Function(List<Errors> errors)): The `onError` parameter is a function
  /// that takes a list of errors as input and returns a future that resolves to a value of type
  /// `TNextValue`. This function is called when there are errors present in the context of the
  /// `matchAsync` method.
  ///
  /// Returns:
  ///   The `matchAsync` method returns a `Future<TNextValue>`.
  Future<TNextValue> matchAsync<TNextValue>(
    Future<TNextValue> Function(TValue value) onValue,
    Future<TNextValue> Function(List<Errors> errors) onError,
  ) async {
    if (_isError) {
      return await onError(errors);
    }
    return await onValue(value);
  }

  /// The `matchFirst` function takes two functions as arguments and returns the result of applying one of
  /// them based on whether there is an error or not.
  ///
  /// Args:
  ///   onValue (TNextValue Function(TValue value)): The `onValue` parameter is a function that takes a
  /// value of type `TValue` and returns a value of type `TNextValue`.
  ///   onError (TNextValue Function(Errors error)): The `onError` parameter is a function that takes an
  /// `Errors` object as input and returns a value of type `TNextValue`.
  ///
  /// Returns:
  ///   The `matchFirst` function is returning either the result of the `onError` function with the
  /// `firstError` if `_isError` is true, or the result of the `onValue` function with the `value` if
  /// `_isError` is false.
  TNextValue matchFirst<TNextValue>(
    TNextValue Function(TValue value) onValue,
    TNextValue Function(Errors error) onError,
  ) {
    if (_isError) {
      return onError(firstError);
    }
    return onValue(value);
  }

  /// The `matchFirstAsync` function asynchronously executes a callback based on whether an error occurred
  /// or a value is present.
  ///
  /// Args:
  ///   onValue (Future<TNextValue> Function(TValue value)): The `onValue` parameter is a function that
  /// takes a value of type `TValue` and returns a `Future<TNextValue>`. It is called when there is no
  /// error and processes the value.
  ///   onError (Future<TNextValue> Function(Errors error)): The `onError` parameter is a function that
  /// takes an `Errors` object as input and returns a `Future<TNextValue>`. This function is called when
  /// there is an error condition in the `matchFirstAsync` method.
  ///
  /// Returns:
  ///   The `matchFirstAsync` function returns a `Future<TNextValue>`.
  Future<TNextValue> matchFirstAsync<TNextValue>(
    Future<TNextValue> Function(TValue value) onValue,
    Future<TNextValue> Function(Errors error) onError,
  ) async {
    if (_isError) {
      return await onError(firstError);
    }
    return await onValue(value);
  }

  /// The `doSwitch` function in Dart takes two functions as parameters and executes one of them based on
  /// whether an error occurred or not.
  ///
  /// Args:
  ///   onValue (Function(TValue value)): The `onValue` parameter is a function that takes a single
  /// argument of type `TValue` and returns a result.
  ///   onError (Function(List<Errors> errors)): The `onError` parameter is a function that takes a list
  /// of `Errors` as input and handles the error case when `_isError` is true.
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

  /// The `doSwitchAsync` function asynchronously executes a callback based on whether an error occurred
  /// or not.
  ///
  /// Args:
  ///   onValue (Future Function(TValue value)): The `onValue` parameter is a function that takes a single
  /// argument of type `TValue` and returns a `Future`. This function is called when the `doSwitchAsync`
  /// method is invoked and the internal state indicates that there is no error.
  ///   onError (Future Function(List<Errors> errors)): The `onError` parameter is a function that takes a
  /// list of errors as input and returns a Future. It is used in the `doSwitchAsync` function to handle
  /// the case when there are errors.
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

  /// The `doSwitchFirst` function in Dart executes a callback based on whether an error has occurred or
  /// not.
  ///
  /// Args:
  ///   onValue (Function(TValue value)): The `onValue` parameter is a function that takes a single
  /// argument of type `TValue` and returns void.
  ///   onFirstError (Function(Errors error)): The `onFirstError` parameter is a function that takes an
  /// `Errors` object as an argument and handles the error case when `_isError` is true.
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

  /// The `doSwitchFirstAsync` function asynchronously executes different functions based on whether an
  /// error has occurred or not.
  ///
  /// Args:
  ///   onValue (Future Function(TValue value)): The `onValue` parameter is a function that takes a value
  /// of type `TValue` and returns a `Future`. This function is called when there is no error and the
  /// value is available to be processed.
  ///   onFirstError (Future Function(Errors error)): The `onFirstError` parameter is a function that
  /// takes an `Errors` object as input and returns a `Future`. This function is called when there is an
  /// error condition in the `doSwitchFirstAsync` method, and it is responsible for handling the first
  /// error encountered.
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

  /// The `then` function takes a callback that operates on the current value if there is no error,
  /// otherwise it returns the current errors.
  ///
  /// Args:
  ///   onValue (ErrorOr<TNextValue> Function(TValue value)): The `onValue` parameter is a function that
  /// takes a value of type `TValue` and returns an `ErrorOr<TNextValue>`.
  ///
  /// Returns:
  ///   An `ErrorOr<TNextValue>` object is being returned.
  ErrorOr<TNextValue> then<TNextValue>(
    ErrorOr<TNextValue> Function(TValue value) onValue,
  ) {
    if (_isError) {
      return this.errors.toErrorOr<TNextValue>();
    }

    return onValue(value);
  }

  /// The `thenDo` function in Dart takes a callback function to be executed if there is no error.
  ///
  /// Args:
  ///   onValue (Function(TValue value)): The `onValue` parameter is a function that takes a single
  /// argument of type `TValue` and returns void.
  ///
  /// Returns:
  ///   The `ErrorOr<TValue>` object is being returned.
  ErrorOr<TValue> thenDo(
    Function(TValue value) onValue,
  ) {
    if (!_isError) {
      onValue(value);
    }

    return this;
  }

  /// The `thenAsync` function takes a function that operates on a value and returns a Future containing
  /// the result or an error.
  ///
  /// Args:
  ///   onValue (Future<ErrorOr<TNextValue>> Function(TValue value)): The `onValue` parameter is a
  /// function that takes a value of type `TValue` and returns a `Future` of `ErrorOr<TNextValue>`.
  ///
  /// Returns:
  ///   The `thenAsync` method returns a `Future` containing an `ErrorOr` object that may hold a value of
  /// type `TNextValue`.
  Future<ErrorOr<TNextValue>> thenAsync<TNextValue>(
    Future<ErrorOr<TNextValue>> Function(TValue value) onValue,
  ) async {
    if (_isError) {
      return this.errors.toErrorOr<TNextValue>();
    }

    return await onValue(value);
  }

  /// The `thenDoAsync` function takes a callback that operates on a value asynchronously and returns a
  /// `Future` of `ErrorOr` type.
  ///
  /// Args:
  ///   onValue (Future Function(TValue value)): The `onValue` parameter is a function that takes a value
  /// of type `TValue` and returns a `Future`. In the `thenDoAsync` method, this function is called
  /// asynchronously if the current `Future` instance does not represent an error.
  ///
  /// Returns:
  ///   The `thenDoAsync` method is returning a `Future<ErrorOr<TValue>>`.
  Future<ErrorOr<TValue>> thenDoAsync(
    Future Function(TValue value) onValue,
  ) async {
    if (!_isError) {
      await onValue(value);
    }

    return this;
  }
}
