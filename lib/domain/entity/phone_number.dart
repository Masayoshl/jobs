class PhoneValidationResult {
  final bool isValid;
  final String? errorMessage;

  const PhoneValidationResult({
    required this.isValid,
    this.errorMessage,
  });

  const PhoneValidationResult.valid()
      : isValid = true,
        errorMessage = null;
  const PhoneValidationResult.invalid(String message)
      : isValid = false,
        errorMessage = message;
}

class PhoneNumber {
  final String value;
  final String countryCode;
  final String dialCode;
  final String? errorMessage;
  final bool hasError;
  final bool isDirty;
  final int maxLength;
  final int minLength;
  String get completeNumber => '+$dialCode$value';
  const PhoneNumber._({
    required this.value,
    required this.countryCode,
    required this.dialCode,
    this.errorMessage,
    this.hasError = false,
    this.isDirty = false,
    required this.maxLength,
    required this.minLength,
  });

  factory PhoneNumber({
    String value = '',
    required String countryCode,
    required String dialCode,
    bool isDirty = false,
    String? externalErrorMessage,
    required int maxLength,
    required int minLength,
  }) {
    if (externalErrorMessage != null) {
      return PhoneNumber._(
        value: value.trim(),
        countryCode: countryCode,
        dialCode: dialCode,
        errorMessage: externalErrorMessage,
        hasError: true,
        isDirty: true,
        maxLength: maxLength + dialCode.length,
        minLength: minLength + dialCode.length,
      );
    }

    final validationResult = PhoneNumber._validatePhone(
        value, maxLength, minLength, dialCode.length);

    return PhoneNumber._(
      value: value.trim(),
      countryCode: countryCode,
      dialCode: dialCode,
      errorMessage: isDirty ? validationResult.errorMessage : null,
      hasError: isDirty ? !validationResult.isValid : false,
      isDirty: isDirty,
      maxLength: maxLength,
      minLength: minLength,
    );
  }

  static PhoneValidationResult _validatePhone(
      String value, int maxLength, int minLength, int dialCodeLength) {
    if (value.isEmpty) {
      return const PhoneValidationResult.invalid(
          'Phone number cannot be empty');
    }
    if (value.length < minLength) {
      return PhoneValidationResult.invalid(
          'Phone number must be at least $minLength digits');
    }
    if (value.length > maxLength) {
      return PhoneValidationResult.invalid(
          'Phone number cannot be longer than $maxLength digits');
    }
    return const PhoneValidationResult.valid();
  }

  PhoneNumber copyWith({
    String? value,
    String? countryCode,
    String? dialCode,
    int? maxLength,
    int? minLength,
  }) {
    return PhoneNumber(
      value: value ?? this.value,
      countryCode: countryCode ?? this.countryCode,
      dialCode: dialCode ?? this.dialCode,
      maxLength: maxLength ?? this.maxLength,
      minLength: minLength ?? this.minLength,
      isDirty: true,
    );
  }

  bool get isValid => !hasError;
}
