import '../lib/error_or_plus.dart';
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
      var result = await Future.value(await error.toErrorOr<int>()).orElse(
        valueOnError: 1,
      );
      expect(result.isError, false);
      expect(result.value, 1);
    });
    test('Future OrElse Error test', () async {
      Errors error = Errors.unexpected();
      var result = await Future.value(await error.toErrorOr<int>()).orElse(
        errorOnError: Errors.conflict(),
      );
      expect(result.isError, true);
      expect(result.firstError.type, ErrorType.conflict);
    });
    test('Future OrElse Error Handler test', () async {
      Errors error = Errors.unexpected();
      var result = await Future.value(await error.toErrorOr<int>()).orElse(
        errorOnErrorHandler: (errors) => Errors.conflict(),
      );
      expect(result.isError, true);
      expect(result.firstError.type, ErrorType.conflict);
    });
    test('Future OrElse List Error Handler test', () async {
      Errors error = Errors.unexpected();
      var result = await Future.value(await error.toErrorOr<int>()).orElse(
        errorsOnErrorHandler: (errors) =>
            [Errors.unauthorized(), Errors.unexpected()],
      );
      expect(result.isError, true);
      expect(result.errors.length, 2);
    });
    test('Future OrElse Value test Async', () async {
      Errors error = Errors.unexpected();
      var result = await Future.value(await error.toErrorOr<int>()).orElseAsync(
        valueOnError: Future.value(1),
      );
      expect(result.isError, false);
      expect(result.value, 1);
    });
    test('Future OrElse Error test Async', () async {
      Errors error = Errors.unexpected();
      var result = await Future.value(await error.toErrorOr<int>()).orElseAsync(
        errorOnError: Future.value(Errors.conflict()),
      );
      expect(result.isError, true);
      expect(result.firstError.type, ErrorType.conflict);
    });
    test('Future OrElse Error Handler test Async', () async {
      Errors error = Errors.unexpected();
      var result = await Future.value(await error.toErrorOr<int>()).orElseAsync(
        errorOnErrorHandler: (errors) => Future.value(Errors.conflict()),
      );
      expect(result.isError, true);
      expect(result.firstError.type, ErrorType.conflict);
    });
    test('Future OrElse List Error Handler test Async', () async {
      Errors error = Errors.unexpected();
      var result = await Future.value(await error.toErrorOr<int>()).orElseAsync(
        errorsOnErrorHandler: (errors) =>
            Future.value([Errors.unauthorized(), Errors.unexpected()]),
      );
      expect(result.isError, true);
      expect(result.errors.length, 2);
    });
  });
}
