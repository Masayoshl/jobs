import 'package:jobs/domain/validators/validation_result.dart';

class OtpCodeValidator {
  static ValidationResult validateCode(String code) {
    if (code.isEmpty) {
      return const ValidationResult(
          isValid: false, errorMessage: 'Code cannot be empty');
    }

    return const ValidationResult(isValid: true);
  }
}
