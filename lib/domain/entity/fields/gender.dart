import 'package:jobs/domain/entity/fields/validoation_result.dart';

enum GenderType {
  male('Male'),
  female('Female'),
  other('Other'),
  secret('Prefer not to answer');

  const GenderType(this.label);
  final String label;

  static GenderType? fromLabel(String? label) {
    if (label == null) return null;
    return GenderType.values.firstWhere(
      (type) => type.label == label,
      orElse: () => throw ArgumentError('Invalid gender label: $label'),
    );
  }
}

class Gender {
  final String? value;
  final String? errorMessage;
  final bool hasError;
  final bool isDirty;

  const Gender._({
    this.value,
    this.errorMessage,
    this.hasError = false,
    this.isDirty = false,
  });

  factory Gender({
    String? value,
    bool isDirty = false,
    String? externalErrorMessage,
  }) {
    if (externalErrorMessage != null) {
      return Gender._(
        value: value,
        errorMessage: externalErrorMessage,
        hasError: true,
        isDirty: true,
      );
    }

    final validationResult = Gender._validate(value);

    return Gender._(
      value: value,
      errorMessage: isDirty ? validationResult.errorMessage : null,
      hasError: isDirty ? !validationResult.isValid : false,
      isDirty: isDirty,
    );
  }

  static ValidationResult _validate(String? value) {
    if (value == null) {
      return const ValidationResult.invalid('Gender must be selected');
    }

    try {
      GenderType.fromLabel(value);
      return const ValidationResult.valid();
    } catch (e) {
      return const ValidationResult.invalid('Invalid gender value');
    }
  }

  Gender copyWith({String? value}) {
    return Gender(
      value: value ?? this.value,
      isDirty: true,
    );
  }

  bool get isValid => !hasError;

  String? get label => value;

  GenderType? get type => GenderType.fromLabel(value);

  @override
  String toString() =>
      'Gender(value: $value, isValid: $isValid, error: $errorMessage, isDirty: $isDirty)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Gender &&
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
