import '../error_or_plus.dart';

/// This Dart class is named Errors.
class Errors {
  /// The line `final String code;` in the Dart class `Errors` is declaring a final instance variable
  /// named `code` of type `String`. This variable will hold the error code associated with an instance
  /// of the `Errors` class. The `final` keyword indicates that once the `code` variable is assigned a
  /// value, it cannot be changed later.
  final String code;

  /// The line `final String description;` in the Dart class `Errors` is declaring a final instance
  /// variable named `description` of type `String`. This variable will hold the description associated
  /// with an instance of the `Errors` class. The `final` keyword indicates that once the `description`
  /// variable is assigned a value, it cannot be changed later.
  final String description;

  /// The line `final ErrorType type;` in the Dart class `Errors` is declaring a final instance variable
  /// named `type` of type `ErrorType`. This variable will hold the type of error associated with an
  /// instance of the `Errors` class. The `final` keyword indicates that once the `type` variable is
  /// assigned a value, it cannot be changed later.
  final ErrorType type;

  /// The line `final int numericType;` in the Dart class `Errors` is declaring a final instance
  /// variable named `numericType` of type `int`. This variable will hold the numeric representation of
  /// the `ErrorType` associated with an instance of the `Errors` class.
  final int numericType;

  /// The line `final Map<String, Object>? metadata;` in the Dart class `Errors` is declaring a final
  /// instance variable named `metadata` of type `Map<String, Object>?`. This variable will hold
  /// additional metadata associated with an instance of the `Errors` class. The `?` indicates that the
  /// `metadata` variable can be `null` or hold a map of key-value pairs where the keys are of type
  /// `String` and the values are of type `Object`.
  final Map<String, Object>? metadata;

  /// The `Errors.failure` factory method creates an instance of `Errors` with specified code,
  /// description, type, and optional metadata.
  ///
  /// Args:
  ///   code (String): The `code` parameter in the `factory Errors.failure` method is used to specify a
  /// unique identifier for the type of failure that occurred. It defaults to "General.Failure" if not
  /// provided. Defaults to General.Failure
  ///   description (String): The `description` parameter in the `Errors.failure` factory method is a
  /// String type parameter that represents a description of the failure that has occurred. It provides
  /// additional information about the nature of the failure. In the default case, if no description is
  /// provided when calling the factory method, it will default to. Defaults to A failure has occurred
  ///   metadata (Map<String, Object>): Metadata is additional information or data that provides context
  /// or details about the error that occurred. It can include key-value pairs of information that may be
  /// useful for debugging or understanding the error better. In the `factory Errors.failure` method you
  /// provided, the `metadata` parameter is a map that allows you to
  factory Errors.failure({
    String code = "General.Failure",
    String description = "A failure has occurred",
    Map<String, Object>? metadata,
  }) =>
      Errors._make(
          code: code,
          description: description,
          type: ErrorType.failure,
          metadata: metadata);

  /// The `Errors.unexpected` factory method creates an unexpected error with a specified code,
  /// description, and optional metadata.
  ///
  /// Args:
  ///   code (String): The `code` parameter in the `Errors.unexpected` factory method is a String
  /// parameter that represents the error code associated with the unexpected error. It has a default
  /// value of "General.Unexpected" if not provided explicitly. Defaults to General.Unexpected
  ///   description (String): The `description` parameter in the `Errors.unexpected` factory method is a
  /// String that provides a description of the unexpected error that occurred. It is a human-readable
  /// explanation of what went wrong in the code. Defaults to A unexpected has occurred
  ///   metadata (Map<String, Object>): Metadata is additional information or data that can be included
  /// along with the error details. It can be in the form of a key-value pair map where the key is a
  /// string and the value can be of any type of object. This metadata can provide more context or details
  /// about the error that occurred.
  factory Errors.unexpected({
    String code = "General.Unexpected",
    String description = "A unexpected has occurred",
    Map<String, Object>? metadata,
  }) =>
      Errors._make(
          code: code,
          description: description,
          type: ErrorType.unexpected,
          metadata: metadata);

  /// The `Errors.validation` factory method creates a validation error with a specified code,
  /// description, and optional metadata.
  ///
  /// Args:
  ///   code (String): The `code` parameter in the `Errors.validation` factory method is used to specify
  /// the error code associated with the validation error. In this case, the default value for `code` is
  /// "General.Validation" if no value is provided when calling the factory method. Defaults to
  /// General.Validation
  ///   description (String): The `description` parameter in the `Errors.validation` factory method is a
  /// string that provides a brief description of the validation error that has occurred. In this case,
  /// the default value for the `description` parameter is set to "A validation has occurred". Defaults to
  /// A validation has occurred
  ///   metadata (Map<String, Object>): Metadata is additional information or data that can be included
  /// along with the error details. It is a map that can contain key-value pairs of any additional
  /// information related to the error. This can be useful for providing more context or details about the
  /// validation error that occurred.
  factory Errors.validation({
    String code = "General.Validation",
    String description = "A validation has occurred",
    Map<String, Object>? metadata,
  }) =>
      Errors._make(
          code: code,
          description: description,
          type: ErrorType.validation,
          metadata: metadata);

  /// The `Errors.conflict` factory method creates an error object with a conflict type, default code,
  /// description, and optional metadata.
  ///
  /// Args:
  ///   code (String): The `code` parameter in the `factory Errors.conflict` method is a String parameter
  /// that represents the error code associated with the conflict error. By default, it is set to
  /// "General.Conflict" but can be customized when calling the method. Defaults to General.Conflict
  ///   description (String): The `description` parameter in the `Errors.conflict` factory method is a
  /// string that provides a brief explanation of the conflict that has occurred. In this case, the
  /// default value for the `description` parameter is set to "A conflict has occurred". Defaults to A
  /// conflict has occurred
  ///   metadata (Map<String, Object>): The `metadata` parameter in the `Errors.conflict` factory method
  /// is a map that allows you to include additional information or context related to the error. This can
  /// be useful for providing more details about the conflict that occurred, such as specific data or
  /// conditions that led to the conflict. You can populate
  factory Errors.conflict({
    String code = "General.Conflict",
    String description = "A conflict has occurred",
    Map<String, Object>? metadata,
  }) =>
      Errors._make(
          code: code,
          description: description,
          type: ErrorType.conflict,
          metadata: metadata);

  /// The `Errors.notfound` factory method creates a custom error object for a "not found" scenario with
  /// optional metadata.
  ///
  /// Args:
  ///   code (String): The `code` parameter in the `Errors.notfound` factory method is a String parameter
  /// with a default value of "General.NotFound". It is used to specify the error code associated with the
  /// not found error. Defaults to General.NotFound
  ///   description (String): The `description` parameter in the `Errors.notfound` factory method is a
  /// string that provides a description of the error that occurred. In this case, the default value for
  /// the `description` parameter is "A notfound has occurred". Defaults to A notfound has occurred
  ///   metadata (Map<String, Object>): The `metadata` parameter in the `Errors.notfound` factory method
  /// is a map that allows you to include additional information or context related to the error that
  /// occurred. This can be useful for providing more details about the error to help with debugging or
  /// troubleshooting. You can include key-value pairs in the `
  factory Errors.notfound({
    String code = "General.NotFound",
    String description = "A notfound has occurred",
    Map<String, Object>? metadata,
  }) =>
      Errors._make(
          code: code,
          description: description,
          type: ErrorType.notFound,
          metadata: metadata);

  /// The `Errors.unauthorized` factory method creates an unauthorized error with a specified code,
  /// description, and optional metadata.
  ///
  /// Args:
  ///   code (String): The `code` parameter in the `Errors.unauthorized` factory method is a String
  /// parameter that represents the error code associated with the unauthorized error. In the provided
  /// code snippet, the default value for `code` is "General.Unauthorized". Defaults to
  /// General.Unauthorized
  ///   description (String): The `description` parameter in the `Errors.unauthorized` factory method is a
  /// string that provides a brief explanation or message about the unauthorized error that occurred. In
  /// this case, the default value for the `description` parameter is set to "A unauthorized has
  /// occurred". Defaults to A unauthorized has occurred
  ///   metadata (Map<String, Object>): The `metadata` parameter in the `Errors.unauthorized` factory
  /// method is a map that allows you to include additional information or context related to the
  /// unauthorized error that occurred. This can be useful for providing more details about the error,
  /// such as user information, timestamps, or any other relevant data that can
  factory Errors.unauthorized({
    String code = "General.Unauthorized",
    String description = "A unauthorized has occurred",
    Map<String, Object>? metadata,
  }) =>
      Errors._make(
          code: code,
          description: description,
          type: ErrorType.unauthorized,
          metadata: metadata);

  /// This Dart factory method creates a Forbidden error with a default code, description, and optional
  /// metadata.
  ///
  /// Args:
  ///   code (String): The `code` parameter in the `Errors.forbidden` factory method is a String that
  /// represents the error code. In the provided code snippet, the default value for `code` is
  /// "General.Forbidden". Defaults to General.Forbidden
  ///   description (String): The `description` parameter in the `Errors.forbidden` factory method is a
  /// string that provides a description of the forbidden error that occurred. In this case, the default
  /// description is "A forbidden has occurred", but you can customize it when calling the factory method.
  /// Defaults to A forbidden has occurred
  ///   metadata (Map<String, Object>): Metadata is additional information or data that can be included
  /// along with the error. It can be in the form of a Map<String, Object> where you can store key-value
  /// pairs of any extra details related to the error. This can be useful for providing more context or
  /// specific information about the error that occurred
  factory Errors.forbidden({
    String code = "General.Forbidden",
    String description = "A forbidden has occurred",
    Map<String, Object>? metadata,
  }) =>
      Errors._make(
          code: code,
          description: description,
          type: ErrorType.forbidden,
          metadata: metadata);

  Errors._make({
    required this.code,
    required this.description,
    required this.type,
    this.metadata,
  }) : numericType = type.index;
}
