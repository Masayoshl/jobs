class ValidationResult {
  final bool isValid;
  final String? errorMessage;

  const ValidationResult({
    required this.isValid,
    this.errorMessage,
  });

  const ValidationResult.valid()
      : isValid = true,
        errorMessage = null;

  const ValidationResult.invalid(String message)
      : isValid = false,
        errorMessage = message;
}
