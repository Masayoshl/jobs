import 'package:jobs/domain/validators/validation_result.dart';

class NewPasswordValidator {
  static ValidationResult comparePasswords(
      String password, String confirmPassword) {
    if (password != confirmPassword) {
      return const ValidationResult(
          isValid: false, errorMessage: 'Passwords did not match');
    } else {
      return const ValidationResult(
        isValid: true,
      );
    }
  }
}
