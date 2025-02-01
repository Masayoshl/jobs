import 'package:jobs/domain/entity/fields/validoation_result.dart';

class Date {
  final String? value;
  final String? errorMessage;
  final bool hasError;
  final bool isDirty;

  const Date._({
    this.value,
    this.errorMessage,
    this.hasError = false,
    this.isDirty = false,
  });

  factory Date({
    String? value,
    bool isDirty = false,
    String? externalErrorMessage,
  }) {
    if (externalErrorMessage != null) {
      return Date._(
        value: value,
        errorMessage: externalErrorMessage,
        hasError: true,
        isDirty: true,
      );
    }
    final validationResult = Date._validate(value);

    return Date._(
      value: value,
      errorMessage: isDirty ? validationResult.errorMessage : null,
      hasError: isDirty ? !validationResult.isValid : false,
      isDirty: isDirty,
    );
  }

  static ValidationResult _validate(String? value) {
    if (value == null || value.isEmpty) {
      return const ValidationResult.invalid('Field cannot be empty');
    }
    return const ValidationResult.valid();
  }

  Date copyWith({String? value}) {
    if (value == null && this.value == null) return this;
    return Date(
      value: value ?? this.value,
      isDirty: true,
    );
  }

  bool get isValid => !hasError;

  @override
  String toString() =>
      'DateOfBirth(value: $value, isValid: $isValid, error: $errorMessage, isDirty: $isDirty)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Date &&
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
