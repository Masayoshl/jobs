import 'package:jobs/domain/entity/fields/validoation_result.dart';

class IndustryField {
  final String value;
  final String? errorMessage;
  final bool hasError;
  final bool isDirty;

  const IndustryField._({
    required this.value,
    this.errorMessage,
    this.hasError = false,
    this.isDirty = false,
  });

  factory IndustryField({
    String value = '',
    bool isDirty = false,
    String? externalErrorMessage,
  }) {
    if (externalErrorMessage != null) {
      return IndustryField._(
        value: value,
        errorMessage: externalErrorMessage,
        hasError: true,
        isDirty: true,
      );
    }
    final validationResult = IndustryField._validate(value);

    return IndustryField._(
      value: value,
      errorMessage: isDirty ? validationResult.errorMessage : null,
      hasError: isDirty ? !validationResult.isValid : false,
      isDirty: isDirty,
    );
  }

  static ValidationResult _validate(String value) {
    if (value.isEmpty) {
      return const ValidationResult.invalid('Field cannot be empty');
    }
    return const ValidationResult.valid();
  }

  IndustryField copyWith({String? value}) {
    return IndustryField(
      value: value ?? this.value,
      isDirty: true,
    );
  }

  bool get isValid => !hasError;

  @override
  String toString() =>
      'IndustryField(value: $value, isValid: $isValid, error: $errorMessage, isDirty: $isDirty)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is IndustryField &&
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
