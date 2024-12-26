// Интерфейс для аутентификации
import 'package:jobs/domain/interfaces/auth/base_state.dart';
import 'package:jobs/domain/interfaces/auth/email_state.dart';
import 'package:jobs/domain/interfaces/auth/name_state.dart';
import 'package:jobs/domain/interfaces/auth/password_state.dart';

// Интерфейс для аутентификации
abstract interface class ISignInState implements IEmailState, IPasswordState {
  bool get keepIn;
}

// Интерфейс для регистрации
abstract interface class ISignUpState implements ISignInState, INameState {
  // Наследует все необходимые поля от IAuthState и INameState
}

abstract interface class IForgotPasswordState implements IEmailState {
  // Наследует все необходимые поля от IEmailState, который уже включает IBaseState
}

// Интерфейс для состояния создания нового пароля
abstract interface class INewPasswordState implements IConfirmPasswordState {
  bool get keepIn;
}

// Интерфейс для OTP состояния
abstract interface class IOtpState implements IBaseState {
  String get code;
  String? get codeErrorMessage;
  bool get isCodeHaveError;
  int get remainingTime;
  String get userEmail;
}
