import 'package:error_or/src/error_type.dart';

class Error {
  final String code;
  final String description;
  final ErrorType type;
  final int numericType;
  final Map<String, Object>? metadata;

  factory Error.failure({
    String code = "General.Failure",
    String description = "A failure has occurred",
    Map<String, Object>? metadata,
  }) =>
      Error._make(
          code: code,
          description: description,
          type: ErrorType.failure,
          metadata: metadata);

  Error._make({
    required this.code,
    required this.description,
    required this.type,
    this.metadata,
  }) : numericType = type.index;
}
