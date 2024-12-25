import 'package:flutter/material.dart';
import 'package:jobs/UI/base_view_model/base_view_model.dart';
import 'package:jobs/domain/enums/button_state.dart';
import 'package:jobs/domain/servises/auth_service.dart';
import 'package:jobs/domain/validators/auth_validator.dart';

abstract class BaseAuthViewModelState extends BaseViewModelState {
  final String email;
  final String? emailErrorMessage;
  final bool isEmailHaveError;

  final String password;
  final String? passwordErrorMessage;
  final bool isPasswordHaveError;

  final bool keepIn;

  const BaseAuthViewModelState({
    this.email = '',
    this.emailErrorMessage,
    this.isEmailHaveError = false,
    this.password = '',
    this.passwordErrorMessage,
    this.isPasswordHaveError = false,
    this.keepIn = false,
    super.inProcess = false,
  });

  @override
  BaseAuthViewModelState copyWithBase({
    String? email,
    String? emailErrorMessage,
    bool? isEmailHaveError,
    String? password,
    String? passwordErrorMessage,
    bool? isPasswordHaveError,
    bool? keepIn,
    bool? inProcess,
  });

  ButtonState get buttonState =>
      getButtonState(isEmailHaveError || isPasswordHaveError);
}

// base_auth_view_model.dart
abstract class BaseAuthViewModel<T extends BaseAuthViewModelState>
    extends BaseViewModel<T> {
  final AuthService authService;

  BaseAuthViewModel(super.state, this.authService);

  void changeEmail(String value) {
    final emailError = AuthValidator.validateEmail(value);
    updateEmailState(
        value.trim(), !emailError.isValid, emailError.errorMessage);
  }

  void changePassword(String value) {
    final passwordError = AuthValidator.validatePassword(value);
    updatePasswordState(
        value.trim(), !passwordError.isValid, passwordError.errorMessage);
  }

  @protected
  void updateEmailState(String email, bool hasError, String? errorMessage);

  @protected
  void updatePasswordState(
      String password, bool hasError, String? errorMessage);

  @override
  void toggleKeepIn() {
    updateKeepInState(!state.keepIn);
  }

  @protected
  void updateKeepInState(bool keepIn);

  @protected
  Future<void> handleAuthOperation(
      BuildContext context, Future<void> Function() operation) async {
    if (state.isEmailHaveError || state.isPasswordHaveError) return;
    if (state.email.isEmpty || state.password.isEmpty) return;

    setState(state.copyWithBase(
      emailErrorMessage: null,
      passwordErrorMessage: null,
      isEmailHaveError: false,
      isPasswordHaveError: false,
      inProcess: true,
    ) as T);

    try {
      await operation();
      setState(state.copyWithBase(inProcess: false) as T);
    } catch (e) {
      await handleError(
        e,
        onEmailError: (message, hasError) {
          setState(state.copyWithBase(
            emailErrorMessage: message,
            isEmailHaveError: hasError,
            inProcess: false,
          ) as T);
        },
        onPasswordError: (message, hasError) {
          setState(state.copyWithBase(
            passwordErrorMessage: message,
            isPasswordHaveError: hasError,
            inProcess: false,
          ) as T);
        },
      );
    }
  }
}
