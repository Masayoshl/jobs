import 'package:jobs/domain/entity/fields/validoation_result.dart';

class Email {
  final String value;
  final String? errorMessage;
  final bool hasError;
  final bool isDirty;

  static const String _emailRegexPattern =
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';

  const Email._({
    required this.value,
    this.errorMessage,
    this.hasError = false,
    this.isDirty = false,
  });

  factory Email({
    String value = '',
    bool isDirty = false,
    String? externalErrorMessage,
  }) {
    if (externalErrorMessage != null) {
      return Email._(
        value: value.trim(),
        errorMessage: externalErrorMessage,
        hasError: true,
        isDirty: true,
      );
    }

    final validationResult = Email._validate(value);

    return Email._(
      value: value.trim(),
      errorMessage: isDirty ? validationResult.errorMessage : null,
      hasError: isDirty ? !validationResult.isValid : false,
      isDirty: isDirty,
    );
  }

  static ValidationResult _validate(String value) {
    if (value.isEmpty) {
      return const ValidationResult.invalid('Email cannot be empty');
    }

    final emailRegex = RegExp(_emailRegexPattern);
    if (!emailRegex.hasMatch(value)) {
      return const ValidationResult.invalid('Invalid email format');
    }

    return const ValidationResult.valid();
  }

  Email copyWith({String? value}) {
    if (value == null) return this;
    return Email(
      value: value,
      isDirty: true,
    );
  }

  bool get isValid => !hasError;

  @override
  String toString() =>
      'Email(value: $value, isValid: $isValid, error: $errorMessage, isDirty: $isDirty)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Email &&
        other.value == value &&
        other.errorMessage == errorMessage &&
        other.hasError == hasError &&
        other.isDirty == isDirty;
  }

  @override
  int get hashCode =>
      value.hashCode ^
      errorMessage.hashCode ^
      hasError.hashCode ^
      isDirty.hashCode;
}
