import 'package:error_or_plus/error_or_plus.dart';

main() {
  User.create("Luca Fabbri")
      .thenDo((value) => print("${value.name} was created."));
}

class User {
  final String _name;

  String get name => _name;

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
