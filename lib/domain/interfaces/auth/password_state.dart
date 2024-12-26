import 'package:jobs/domain/interfaces/auth/base_state.dart';

abstract interface class IPasswordState implements IBaseState {
  String get password;
  String? get passwordErrorMessage;
  bool get isPasswordHaveError;
}

// Интерфейс для подтверждения пароля
abstract interface class IConfirmPasswordState implements IPasswordState {
  String get confirmPassword;
  String? get confirmPasswordErrorMessage;
  bool get isConfirmPasswordHaveError;
}
