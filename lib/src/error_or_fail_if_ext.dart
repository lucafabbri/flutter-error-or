import 'package:error_or_plus/error_or_plus.dart';

extension ErrorOrFailIfExt<TValue> on Future<ErrorOr<TValue>> {
  Future<ErrorOr<TValue>> failIf(
    bool Function(TValue value) onValue,
    Errors error,
  ) async {
    var result = await this;
    return result.failIf(onValue, error);
  }

  Future<ErrorOr<TValue>> failIfAsync(
    Future<bool> Function(TValue value) onValue,
    Errors error,
  ) async {
    var result = await this;
    return await result.failIfAsync(onValue, error);
  }
}
