import '../error_or_plus.dart';

class Errors {
  final String code;
  final String description;
  final ErrorType type;
  final int numericType;
  final Map<String, Object>? metadata;

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
