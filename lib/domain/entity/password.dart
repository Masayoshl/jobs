class PasswordValidationResult {
  final bool isValid;
  final String? errorMessage;

  const PasswordValidationResult({
    required this.isValid,
    this.errorMessage,
  });

  const PasswordValidationResult.valid()
      : isValid = true,
        errorMessage = null;
  const PasswordValidationResult.invalid(String message)
      : isValid = false,
        errorMessage = message;
}

class Password {
  final String value;
  final String? errorMessage;
  final bool hasError;
  final bool isDirty;
  final String? confirmValue;
  final String? confirmErrorMessage;
  final bool hasConfirmError;

  // static const String _passwordRegex =
  //     r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';

  const Password._({
    required this.value,
    this.errorMessage,
    this.hasError = false,
    this.isDirty = false,
    this.confirmValue,
    this.confirmErrorMessage,
    this.hasConfirmError = false,
  });

  factory Password({
    String value = '',
    String? confirmValue,
    bool isDirty = false,
    String? externalErrorMessage,
  }) {
    if (externalErrorMessage != null) {
      return Password._(
        value: value.trim(),
        errorMessage: externalErrorMessage,
        hasError: true,
        isDirty: true,
      );
    }
    final validationResult = Password._validatePassword(value);
    final confirmResult = confirmValue != null
        ? Password._validateConfirmPassword(value, confirmValue)
        : null;

    return Password._(
      value: value.trim(),
      errorMessage: isDirty ? validationResult.errorMessage : null,
      hasError: isDirty ? !validationResult.isValid : false,
      isDirty: isDirty,
      confirmValue: confirmValue?.trim(),
      confirmErrorMessage:
          isDirty && confirmResult != null ? confirmResult.errorMessage : null,
      hasConfirmError:
          isDirty && confirmResult != null ? !confirmResult.isValid : false,
    );
  }

  static PasswordValidationResult _validatePassword(String value) {
    if (value.isEmpty) {
      return const PasswordValidationResult.invalid('Password cannot be empty');
    }

    if (value.length < 8) {
      return const PasswordValidationResult.invalid(
          'Password must be at least 8 characters long');
    }

    // final regex = RegExp(_passwordRegex);
    // if (!regex.hasMatch(value)) {
    //   return const PasswordValidationResult.invalid(
    //       'Password must contain uppercase, lowercase, number and special character');
    // }

    return const PasswordValidationResult.valid();
  }

  static PasswordValidationResult _validateConfirmPassword(
      String password, String confirmPassword) {
    if (confirmPassword.isEmpty) {
      return const PasswordValidationResult.invalid(
          'Confirm password cannot be empty');
    }

    if (password != confirmPassword) {
      return const PasswordValidationResult.invalid('Passwords do not match');
    }

    return const PasswordValidationResult.valid();
  }

  Password copyWith({
    String? value,
    String? confirmValue,
  }) {
    return Password(
      value: value ?? this.value,
      confirmValue: confirmValue ?? this.confirmValue,
      isDirty: true,
    );
  }

  bool get isValid => !hasError && !hasConfirmError;
}
