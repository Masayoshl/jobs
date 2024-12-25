import 'package:flutter/material.dart';
import 'package:jobs/UI/auth/view_models/sign_in_view_model/base_auth_view_model.dart';
import 'package:jobs/domain/enums/button_state.dart';
import 'package:jobs/domain/validators/auth_validator.dart';

abstract class BaseSignUpViewModelState extends BaseAuthViewModelState {
  final String name;
  final String? nameErrorMessage;
  final bool isNameHaveError;

  const BaseSignUpViewModelState({
    required super.email,
    super.emailErrorMessage,
    super.isEmailHaveError = false,
    required super.password,
    super.passwordErrorMessage,
    super.isPasswordHaveError = false,
    required this.name,
    this.nameErrorMessage,
    this.isNameHaveError = false,
    super.keepIn = false,
    super.inProcess = false,
  });

  @override
  BaseSignUpViewModelState copyWithBase({
    String? email,
    String? emailErrorMessage,
    bool? isEmailHaveError,
    String? password,
    String? passwordErrorMessage,
    bool? isPasswordHaveError,
    String? name,
    String? nameErrorMessage,
    bool? isNameHaveError,
    bool? keepIn,
    bool? inProcess,
  });

  @override
  ButtonState get buttonState => getButtonState(
        isEmailHaveError || isPasswordHaveError || isNameHaveError,
      );
}

abstract class BaseSignUpViewModel<T extends BaseSignUpViewModelState>
    extends BaseAuthViewModel<T> {
  BaseSignUpViewModel(super.state, super.authService);

  void changeName(String value) {
    final nameError = AuthValidator.validateName(value);
    updateNameState(value.trim(), !nameError.isValid, nameError.errorMessage);
  }

  @protected
  void updateNameState(String name, bool hasError, String? errorMessage);

  @override
  Future<void> handleAuthOperation(
      BuildContext context, Future<void> Function() operation) async {
    if (state.isEmailHaveError ||
        state.isPasswordHaveError ||
        state.isNameHaveError) return;
    if (state.email.isEmpty || state.password.isEmpty || state.name.isEmpty)
      return;

    setState(state.copyWithBase(
      emailErrorMessage: null,
      passwordErrorMessage: null,
      nameErrorMessage: null,
      isEmailHaveError: false,
      isPasswordHaveError: false,
      isNameHaveError: false,
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
