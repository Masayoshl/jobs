import 'package:jobs/domain/validators/validation_result.dart';

class AuthValidator {
  static const String _emailRegexPattern =
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';

  static ValidationResult validateEmail(String email) {
    if (email.isEmpty) {
      return const ValidationResult(
          isValid: false, errorMessage: 'Email cannot be empty');
    }

    final emailRegex = RegExp(_emailRegexPattern);
    if (!emailRegex.hasMatch(email)) {
      return const ValidationResult(
          isValid: false, errorMessage: 'Invalid email format');
    }

    return const ValidationResult(isValid: true);
  }

  static ValidationResult validatePassword(String password) {
    if (password.isEmpty) {
      return const ValidationResult(
          isValid: false, errorMessage: 'Password cannot be empty');
    }

    if (password.length < 8) {
      return const ValidationResult(
          isValid: false,
          errorMessage: 'Password must be at least 8 characters long');
    }

    // // Дополнительные правила валидации пароля
    // final hasUppercase = password.contains(RegExp(r'[A-Z]'));
    // final hasLowercase = password.contains(RegExp(r'[a-z]'));
    // final hasDigits = password.contains(RegExp(r'[0-9]'));
    // final hasSpecialChar = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    // if (!(hasUppercase && hasLowercase && hasDigits && hasSpecialChar)) {
    //   return const ValidationResult(
    //       isValid: false,
    //       errorMessage:
    //           'Password must include uppercase, lowercase, numbers, and special characters');
    // }

    return const ValidationResult(isValid: true);
  }

  static ValidationResult validateName(String name) {
    if (name.isEmpty) {
      return const ValidationResult(
          isValid: false, errorMessage: 'Name cannot be empty');
    }

    if (name.length < 4) {
      return const ValidationResult(
          isValid: false,
          errorMessage: 'Name must be at least 4 characters long');
    }

    return const ValidationResult(isValid: true);
  }
}
