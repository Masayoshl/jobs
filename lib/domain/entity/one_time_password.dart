class OneTimePasswordValidationResult {
  final bool isValid;
  final String? errorMessage;

  const OneTimePasswordValidationResult({
    required this.isValid,
    this.errorMessage,
  });

  const OneTimePasswordValidationResult.valid()
      : isValid = true,
        errorMessage = null;

  const OneTimePasswordValidationResult.invalid(String message)
      : isValid = false,
        errorMessage = message;
}

class OneTimePassword {
  final String value;
  final String? errorMessage;
  final bool hasError;
  final bool isDirty;

  const OneTimePassword._({
    required this.value,
    this.errorMessage,
    this.hasError = false,
    this.isDirty = false,
  });

  factory OneTimePassword({
    String value = '',
    bool isDirty = false,
    bool? isIncorrectCode,
  }) {
    final validationResult =
        OneTimePassword._validate(value, isIncorrectCode: isIncorrectCode);

    return OneTimePassword._(
      value: value.trim(),
      errorMessage: isDirty ? validationResult.errorMessage : null,
      hasError: isDirty ? !validationResult.isValid : false,
      isDirty: isDirty,
    );
  }

  static OneTimePasswordValidationResult _validate(String value,
      {bool? isIncorrectCode}) {
    if (value.isEmpty) {
      return const OneTimePasswordValidationResult.invalid(
          'Code cannot be empty');
    }

    if (isIncorrectCode == true) {
      return const OneTimePasswordValidationResult.invalid('Incorrect code');
    }

    return const OneTimePasswordValidationResult.valid();
  }

  OneTimePassword copyWith({String? value}) {
    if (value == null) return this;
    return OneTimePassword(
      value: value,
      isDirty: true,
    );
  }

  bool get isValid => !hasError;
}
