import 'package:error_or/error_or.dart';

extension ErrorOrMatchExt<TValue, TNextValue> on Future<ErrorOr<TValue>> {
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
