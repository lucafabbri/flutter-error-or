import 'package:error_or/error_or.dart';

extension ErrorOrDoThenExt<TValue> on Future<ErrorOr<TValue>> {
  Future<ErrorOr<TNextValue>> then<TNextValue>(
    ErrorOr<TNextValue> Function(TValue value) onValue,
  ) async {
    var result = await this;
    return result.then(onValue);
  }

  Future<ErrorOr<TValue>> thenDo(
    Function(TValue value) onValue,
  ) async {
    var result = await this;
    return result.thenDo(onValue);
  }

  Future thenAsync<TNextValue>(
    Future<ErrorOr<TNextValue>> Function(TValue value) onValue,
  ) async {
    var result = await this;
    return await result.thenAsync(onValue);
  }

  Future<ErrorOr<TValue>> thenDoAsync(
    Future Function(TValue value) onValue,
  ) async {
    var result = await this;
    return await result.thenDoAsync(onValue);
  }
}
