// base_password_confirmation_state.dart
import 'package:flutter/material.dart';
import 'package:jobs/UI/base_view_model/base_view_model.dart';
import 'package:jobs/domain/enums/button_state.dart';
import 'package:jobs/domain/validators/auth_validator.dart';
import 'package:jobs/domain/validators/new_password_validator.dart';

abstract class BasePasswordConfirmationState extends BaseViewModelState {
  final String password;
  final String? passwordErrorMessage;
  final bool isPasswordHaveError;

  final String confirmPassword;
  final String? confirmPasswordErrorMessage;
  final bool isConfirmPasswordHaveError;

  final bool keepIn;

  const BasePasswordConfirmationState({
    required this.password,
    this.passwordErrorMessage,
    this.isPasswordHaveError = false,
    required this.confirmPassword,
    this.confirmPasswordErrorMessage,
    this.isConfirmPasswordHaveError = false,
    this.keepIn = false,
    super.inProcess = false,
  });

  @override
  BasePasswordConfirmationState copyWithBase({
    String? password,
    String? passwordErrorMessage,
    bool? isPasswordHaveError,
    String? confirmPassword,
    String? confirmPasswordErrorMessage,
    bool? isConfirmPasswordHaveError,
    bool? keepIn,
    bool? inProcess,
  });

  ButtonState get buttonState => getButtonState(
        isPasswordHaveError || isConfirmPasswordHaveError,
      );
}

// base_password_confirmation_view_model.dart
abstract class BasePasswordConfirmationViewModel<
    T extends BasePasswordConfirmationState> extends BaseViewModel<T> {
  BasePasswordConfirmationViewModel(super.state);

  void changePassword(String value) {
    final passwordError = AuthValidator.validatePassword(value);
    updatePasswordState(
      value.trim(),
      !passwordError.isValid,
      passwordError.errorMessage,
    );

    // При изменении пароля нужно перепроверить confirmPassword
    if (state.confirmPassword.isNotEmpty) {
      final confirmPasswordError = NewPasswordValidator.comparePasswords(
        value.trim(),
        state.confirmPassword,
      );
      updateConfirmPasswordState(
        state.confirmPassword,
        !confirmPasswordError.isValid,
        confirmPasswordError.errorMessage,
      );
    }
  }

  void changeConfirmPassword(String value) {
    final confirmPasswordError = NewPasswordValidator.comparePasswords(
      state.password,
      value.trim(),
    );
    updateConfirmPasswordState(
      value.trim(),
      !confirmPasswordError.isValid,
      confirmPasswordError.errorMessage,
    );
  }

  @protected
  void updatePasswordState(
      String password, bool hasError, String? errorMessage);

  @protected
  void updateConfirmPasswordState(
    String confirmPassword,
    bool hasError,
    String? errorMessage,
  );

  @override
  void toggleKeepIn() {
    updateKeepInState(!state.keepIn);
  }

  @protected
  void updateKeepInState(bool keepIn);

  Future<void> handlePasswordOperation(
    OverlayPortalController controller,
    Future<void> Function(String password) operation,
  ) async {
    if (state.password.isEmpty || state.confirmPassword.isEmpty) {
      final passwordError = AuthValidator.validatePassword(state.password);
      await Future.delayed(const Duration(milliseconds: 200));
      setState(state.copyWithBase(
        isPasswordHaveError: !passwordError.isValid,
        passwordErrorMessage: passwordError.errorMessage,
        isConfirmPasswordHaveError: !passwordError.isValid,
        confirmPasswordErrorMessage: passwordError.errorMessage,
      ) as T);
      return;
    }

    if (state.isPasswordHaveError || state.isConfirmPasswordHaveError) return;

    setState(state.copyWithBase(
      passwordErrorMessage: null,
      confirmPasswordErrorMessage: null,
      isPasswordHaveError: false,
      isConfirmPasswordHaveError: false,
      inProcess: true,
    ) as T);

    try {
      await operation(state.password);
      setState(state.copyWithBase(inProcess: false) as T);
      controller.toggle();
    } on ArgumentError {
      setState(state.copyWithBase(
        passwordErrorMessage: 'Something went wrong',
        isPasswordHaveError: true,
        inProcess: false,
      ) as T);
    } catch (e) {
      setState(state.copyWithBase(
        passwordErrorMessage: 'Unknown error, try later',
        inProcess: false,
      ) as T);
      debugPrint('$e');
    }
  }
}
