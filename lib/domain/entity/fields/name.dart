import 'package:jobs/domain/entity/fields/validoation_result.dart';

class Name {
  final String value;
  final String? errorMessage;
  final bool hasError;
  final bool isDirty;

  static const int _minLength = 4;

  const Name._({
    required this.value,
    this.errorMessage,
    this.hasError = false,
    this.isDirty = false,
  });

  factory Name({
    String value = '',
    bool isDirty = false,
    String? externalErrorMessage,
  }) {
    if (externalErrorMessage != null) {
      return Name._(
        value: value.trim(),
        errorMessage: externalErrorMessage,
        hasError: true,
        isDirty: true,
      );
    }
    final validationResult = Name._validate(value);

    return Name._(
      value: value.trim(),
      errorMessage: isDirty ? validationResult.errorMessage : null,
      hasError: isDirty ? !validationResult.isValid : false,
      isDirty: isDirty,
    );
  }

  static ValidationResult _validate(String value) {
    if (value.isEmpty) {
      return const ValidationResult.invalid('Name cannot be empty');
    }

    if (value.length < _minLength) {
      return const ValidationResult.invalid(
          'Name must be at least 4 characters long');
    }

    return const ValidationResult.valid();
  }

  Name copyWith({String? value}) {
    if (value == null) return this;
    return Name(
      value: value,
      isDirty: true,
    );
  }

  bool get isValid => !hasError;

  @override
  String toString() =>
      'Name(value: $value, isValid: $isValid, error: $errorMessage, isDirty: $isDirty)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Name &&
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
