import 'package:error_or_plus/error_or_plus.dart';

void main() {
  try {
    var result = divide(4, 2);
    print(result * 2); // 4
  } on Exception catch (e) {
    print(e);
    return;
  }
  var user = Object();
  var error = Errors.unexpected(
      code: "User.ShouldNeverHappen",
      description: "A user error that should never happen",
      metadata: Map.fromEntries([
        MapEntry("user", user),
      ]));
}

double divide(int a, int b) {
  if (b == 0) {
    throw Exception("Cannot divide by zero");
  }

  return a / b;
}

class User {
  final String _name;

  User._internal(this._name);

  static ErrorOr<User> create(String name) {
    List<Errors> errors = [];

    if (name.length < 2) {
      errors.add(Errors.validation(description: "Name is too short"));
    }

    if (name.length > 100) {
      errors.add(Errors.validation(description: "Name is too long"));
    }

    if (name.isEmpty) {
      errors.add(Errors.validation(
          description: "Name cannot be empty or whitespace only"));
    }

    if (errors.isNotEmpty) {
      return errors.toErrorOr<User>();
    }

    return User._internal(name).toErrorOr();
  }
}
