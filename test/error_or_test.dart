import 'package:error_or_plus/error_or_plus.dart';
import 'package:test/test.dart';

void main() {
  group('ToErrorOr tests', () {
    setUp(() {
      // Additional setup goes here.
    });

    test('Value to ErrorOr Test', () {
      int value = 1;
      var result = value.toErrorOr();
      expect(result.isError, false);
      expect(result.value, 1);
    });

    test('Error to ErrorOr Test', () {
      Errors error = Errors.unexpected();
      var result = error.toErrorOr();
      expect(result.isError, true);
      expect(result.firstError.type, ErrorType.unexpected);
    });

    test('List Errors to ErrorOr Test', () {
      List<Errors> errors = [Errors.unauthorized(), Errors.unexpected()];
      var result = errors.toErrorOr();
      expect(result.isError, true);
      expect(result.errors.length, 2);
    });
  });

  group('Then tests', () {
    test('Then Value test', () {
      int value = 1;
      var result = value.toErrorOr().also((value) => (value + 1).toErrorOr());
      expect(result.isError, false);
      expect(result.value, 2);
    });
    test('Then Error test', () {
      Errors error = Errors.unexpected();
      var result = error.toErrorOr().also((value) => (value + 1).toErrorOr());
      expect(result.isError, true);
      expect(result.firstError.type, ErrorType.unexpected);
    });
    test('Then List Error test', () {
      List<Errors> errors = [Errors.unauthorized(), Errors.unexpected()];
      var result = errors.toErrorOr().also((value) => (value + 1).toErrorOr());
      expect(result.isError, true);
      expect(result.errors.length, 2);
    });
    test('Then Value test Async', () async {
      int value = 1;
      var result = await value
          .toErrorOr()
          .alsoAsync((value) => Future.value((value + 1).toErrorOr()));
      expect(result.isError, false);
      expect(result.value, 2);
    });
    test('Then Error test Async', () async {
      Errors error = Errors.unexpected();
      var result = await error
          .toErrorOr()
          .alsoAsync<int>((value) => Future.value((value + 1).toErrorOr()));
      expect(result.isError, true);
      expect(result.firstError.type, ErrorType.unexpected);
    });
    test('Then List Error test Async', () async {
      List<Errors> errors = [Errors.unauthorized(), Errors.unexpected()];
      var result = await errors
          .toErrorOr()
          .alsoAsync<int>((value) => Future.value((value + 1).toErrorOr()));
      expect(result.isError, true);
      expect(result.errors.length, 2);
    });
    test('Future Then Value test', () async {
      int value = 1;
      var result = await Future.value(value.toErrorOr()).also(
        (value) => (value + 1).toErrorOr(),
      );
      expect(result.isError, false);
      expect(result.value, 2);
    });
    test('Future Then Error test', () async {
      Errors error = Errors.unexpected();
      var result = await Future.value(error.toErrorOr()).also(
        (value) => (value + 1).toErrorOr(),
      );
      expect(result.isError, true);
      expect(result.firstError.type, ErrorType.unexpected);
    });
    test('Future Then List Error test', () async {
      List<Errors> errors = [Errors.unauthorized(), Errors.unexpected()];
      var result = await Future.value(errors.toErrorOr()).also(
        (value) => (value + 1).toErrorOr(),
      );
      expect(result.isError, true);
      expect(result.errors.length, 2);
    });
    test('Future Then Value test Async', () async {
      int value = 1;
      var result = await Future.value(value.toErrorOr()).alsoAsync(
        (value) => Future.value((value + 1).toErrorOr()),
      );
      expect(result.isError, false);
      expect(result.value, 2);
    });
    test('Future Then Error test Async', () async {
      Errors error = Errors.unexpected();
      var result = await Future.value(error.toErrorOr()).alsoAsync<int>(
        (value) => Future.value((value + 1).toErrorOr()),
      );
      expect(result.isError, true);
      expect(result.firstError.type, ErrorType.unexpected);
    });
    test('Future Then List Error test Async', () async {
      List<Errors> errors = [Errors.unauthorized(), Errors.unexpected()];
      var result = await Future.value(errors.toErrorOr()).alsoAsync<int>(
        (value) => Future.value((value + 1).toErrorOr()),
      );
      expect(result.isError, true);
      expect(result.errors.length, 2);
    });
  });

  group('DoSwitch tests', () {
    test('DoSwitch Value test', () {
      int value = 1;
      bool isValue = false;
      value
          .toErrorOr()
          .doSwitch((value) => isValue = true, (error) => isValue = false);
      expect(isValue, true);
    });
    test('DoSwitch Error test', () {
      Errors error = Errors.unexpected();
      bool isValue = false;
      error
          .toErrorOr()
          .doSwitch((value) => isValue = true, (error) => isValue = false);
      expect(isValue, false);
    });
    test('DoSwitch List Error test', () {
      List<Errors> errors = [Errors.unauthorized(), Errors.unexpected()];
      bool isValue = false;
      errors
          .toErrorOr()
          .doSwitch((value) => isValue = true, (error) => isValue = false);
      expect(isValue, false);
    });
    test('Future DoSwitch Value test Async', () async {
      int value = 1;
      bool isValue = false;
      await value.toErrorOr().doSwitchAsync(
          (value) => Future.value(isValue = true),
          (error) => Future.value(isValue = false));
      expect(isValue, true);
    });
    test('Future DoSwitch Error test Async', () async {
      Errors error = Errors.unexpected();
      bool isValue = false;
      await error.toErrorOr().doSwitchAsync(
          (value) => Future.value(isValue = true),
          (error) => Future.value(isValue = false));
      expect(isValue, false);
    });
    test('Future DoSwitch List Error test Async', () async {
      List<Errors> errors = [Errors.unauthorized(), Errors.unexpected()];
      bool isValue = false;
      await errors.toErrorOr().doSwitchAsync(
          (value) => Future.value(isValue = true),
          (error) => Future.value(isValue = false));
      expect(isValue, false);
    });
  });

  group('FailIf', () {
    test('FailIf Value test', () {
      int value = 1;
      var result = value.toErrorOr().failIf(
            (value) => value == 1,
            Errors.unexpected(),
          );
      expect(result.isError, true);
      expect(result.firstError.type, ErrorType.unexpected);
    });
    test('FailIf Error test', () {
      Errors error = Errors.unexpected();
      var result = error.toErrorOr().failIf(
            (value) => value == 1,
            Errors.failure(),
          );
      expect(result.isError, true);
      expect(result.firstError.type, ErrorType.unexpected);
    });
    test('FailIf List Error test', () {
      List<Errors> errors = [Errors.unauthorized(), Errors.unexpected()];
      var result = errors.toErrorOr().failIf(
            (value) => value == 1,
            Errors.failure(),
          );
      expect(result.isError, true);
      expect(result.errors.length, 2);
    });
    test('FailIf Value test Async', () async {
      int value = 1;
      var result = await value.toErrorOr().failIfAsync(
            (value) => Future.value(value == 1),
            Errors.unexpected(),
          );
      expect(result.isError, true);
      expect(result.firstError.type, ErrorType.unexpected);
    });
    test('FailIf Error test Async', () async {
      Errors error = Errors.unexpected();
      var result = await error.toErrorOr().failIfAsync(
            (value) => Future.value(value == 1),
            Errors.failure(),
          );
      expect(result.isError, true);
      expect(result.firstError.type, ErrorType.unexpected);
    });
    test('FailIf List Error test Async', () async {
      List<Errors> errors = [Errors.unauthorized(), Errors.unexpected()];
      var result = await errors.toErrorOr().failIfAsync(
            (value) => Future.value(value == 1),
            Errors.failure(),
          );
      expect(result.isError, true);
      expect(result.errors.length, 2);
    });
  });

  group('Match tests', () {
    test('Match Value test', () {
      int value = 1;
      var result = value.toErrorOr().match(
            (value) => value + 1,
            (error) => 0,
          );
      expect(result, 2);
    });
    test('Match Error test', () {
      Errors error = Errors.unexpected();
      var result = error.toErrorOr().match(
            (value) => value + 1,
            (error) => 0,
          );
      expect(result, 0);
    });
    test('Match List Error test', () {
      List<Errors> errors = [Errors.unauthorized(), Errors.unexpected()];
      var result = errors.toErrorOr().match(
            (value) => value + 1,
            (error) => 0,
          );
      expect(result, 0);
    });
    test('Match Value test Async', () async {
      int value = 1;
      var result = await value.toErrorOr().matchAsync(
            (value) => Future.value(value + 1),
            (error) => Future.value(0),
          );
      expect(result, 2);
    });
    test('Match Error test Async', () async {
      Errors error = Errors.unexpected();
      var result = await error.toErrorOr().matchAsync(
            (value) => Future.value(value + 1),
            (error) => Future.value(0),
          );
      expect(result, 0);
    });
    test('Match List Error test Async', () async {
      List<Errors> errors = [Errors.unauthorized(), Errors.unexpected()];
      var result = await errors.toErrorOr().matchAsync(
            (value) => Future.value(value + 1),
            (error) => Future.value(0),
          );
      expect(result, 0);
    });
  });

  group('OrElse tests', () {
    test('OrElse Value test', () {
      Errors error = Errors.unexpected();
      var result = error.toErrorOr<int>().orElse(valueOnError: 1);
      expect(result.isError, false);
      expect(result.value, 1);
    });
    test('OrElse Error test', () {
      Errors error = Errors.unexpected();
      var result =
          error.toErrorOr<int>().orElse(errorOnError: Errors.conflict());
      expect(result.isError, true);
      expect(result.firstError.type, ErrorType.conflict);
    });
    test('OrElse Error Handler test', () {
      Errors error = Errors.unexpected();
      var result = error
          .toErrorOr<int>()
          .orElse(errorOnErrorHandler: (errors) => Errors.conflict());
      expect(result.isError, true);
      expect(result.firstError.type, ErrorType.conflict);
    });
    test('OrElse List Error Handler test', () {
      Errors error = Errors.unexpected();
      var result = error.toErrorOr<int>().orElse(
          errorsOnErrorHandler: (errors) =>
              [Errors.unauthorized(), Errors.unexpected()]);
      expect(result.isError, true);
      expect(result.errors.length, 2);
    });
    test('OrElse Value test Async', () async {
      Errors error = Errors.unexpected();
      var result = await error
          .toErrorOr<int>()
          .orElseAsync(valueOnError: Future.value(1));
      expect(result.isError, false);
      expect(result.value, 1);
    });
    test('OrElse Error test Async', () async {
      Errors error = Errors.unexpected();
      var result = await error
          .toErrorOr<int>()
          .orElseAsync(errorOnError: Future.value(Errors.conflict()));
      expect(result.isError, true);
      expect(result.firstError.type, ErrorType.conflict);
    });
    test('OrElse Error Handler test Async', () async {
      Errors error = Errors.unexpected();
      var result = await error.toErrorOr<int>().orElseAsync(
          errorOnErrorHandler: (errors) => Future.value(Errors.conflict()));
      expect(result.isError, true);
      expect(result.firstError.type, ErrorType.conflict);
    });
    test('OrElse List Error Handler test Async', () async {
      Errors error = Errors.unexpected();
      var result = await error.toErrorOr<int>().orElseAsync(
          errorsOnErrorHandler: (errors) =>
              Future.value([Errors.unauthorized(), Errors.unexpected()]));
      expect(result.isError, true);
      expect(result.errors.length, 2);
    });
    test('Future OrElse Value test', () async {
      Errors error = Errors.unexpected();
      var result = await Future.value(error.toErrorOr<int>()).orElse(
        valueOnError: 1,
      );
      expect(result.isError, false);
      expect(result.value, 1);
    });
    test('Future OrElse Error test', () async {
      Errors error = Errors.unexpected();
      var result = await Future.value(error.toErrorOr<int>()).orElse(
        errorOnError: Errors.conflict(),
      );
      expect(result.isError, true);
      expect(result.firstError.type, ErrorType.conflict);
    });
    test('Future OrElse Error Handler test', () async {
      Errors error = Errors.unexpected();
      var result = await Future.value(error.toErrorOr<int>()).orElse(
        errorOnErrorHandler: (errors) => Errors.conflict(),
      );
      expect(result.isError, true);
      expect(result.firstError.type, ErrorType.conflict);
    });
    test('Future OrElse List Error Handler test', () async {
      Errors error = Errors.unexpected();
      var result = await Future.value(error.toErrorOr<int>()).orElse(
        errorsOnErrorHandler: (errors) =>
            [Errors.unauthorized(), Errors.unexpected()],
      );
      expect(result.isError, true);
      expect(result.errors.length, 2);
    });
    test('Future OrElse Value test Async', () async {
      Errors error = Errors.unexpected();
      var result = await Future.value(error.toErrorOr<int>()).orElseAsync(
        valueOnError: Future.value(1),
      );
      expect(result.isError, false);
      expect(result.value, 1);
    });
    test('Future OrElse Error test Async', () async {
      Errors error = Errors.unexpected();
      var result = await Future.value(error.toErrorOr<int>()).orElseAsync(
        errorOnError: Future.value(Errors.conflict()),
      );
      expect(result.isError, true);
      expect(result.firstError.type, ErrorType.conflict);
    });
    test('Future OrElse Error Handler test Async', () async {
      Errors error = Errors.unexpected();
      var result = await Future.value(error.toErrorOr<int>()).orElseAsync(
        errorOnErrorHandler: (errors) => Future.value(Errors.conflict()),
      );
      expect(result.isError, true);
      expect(result.firstError.type, ErrorType.conflict);
    });
    test('Future OrElse List Error Handler test Async', () async {
      Errors error = Errors.unexpected();
      var result = await Future.value(error.toErrorOr<int>()).orElseAsync(
        errorsOnErrorHandler: (errors) =>
            Future.value([Errors.unauthorized(), Errors.unexpected()]),
      );
      expect(result.isError, true);
      expect(result.errors.length, 2);
    });
  });
}
