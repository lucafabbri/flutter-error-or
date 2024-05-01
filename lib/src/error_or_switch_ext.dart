import 'package:error_or_plus/error_or_plus.dart';

extension ErrorOrDoSwitchExt<TValue> on Future<ErrorOr<TValue>> {
  Future doSwitch(
    Function(TValue value) onValue,
    Function(List<Errors> errors) onError,
  ) async {
    var result = await this;
    return result.doSwitch(onValue, onError);
  }

  Future doSwitchAsync(
    Future Function(TValue value) onValue,
    Future Function(List<Errors> errors) onError,
  ) async {
    var result = await this;
    return await result.doSwitchAsync(onValue, onError);
  }

  Future doSwitchFirst(
    Function(TValue value) onValue,
    Function(Errors error) onError,
  ) async {
    var result = await this;
    return result.doSwitchFirst(onValue, onError);
  }

  Future doSwitchFirstAsync(
    Future Function(TValue value) onValue,
    Future Function(Errors error) onError,
  ) async {
    var result = await this;
    return await result.doSwitchFirstAsync(onValue, onError);
  }
}
