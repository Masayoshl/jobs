import 'package:flutter/material.dart';
import 'package:jobs/UI/base_view_model/base_view_model.dart';
import 'package:jobs/domain/data_providers/auth_api_provider.dart';
import 'package:jobs/domain/enums/button_state.dart';
import 'package:jobs/domain/servises/auth_service.dart';
import 'package:jobs/domain/validators/auth_validator.dart';

abstract class BaseEmailOnlyState extends BaseViewModelState {
  final String email;
  final String? emailErrorMessage;
  final bool isEmailHaveError;

  const BaseEmailOnlyState({
    required this.email,
    this.emailErrorMessage,
    this.isEmailHaveError = false,
    super.inProcess = false,
  });

  @override
  BaseEmailOnlyState copyWithBase({
    String? email,
    String? emailErrorMessage,
    bool? isEmailHaveError,
    bool? inProcess,
  });

  ButtonState get buttonState => getButtonState(isEmailHaveError);
}

abstract class BaseEmailOnlyViewModel<T extends BaseEmailOnlyState>
    extends BaseViewModel<T> {
  final AuthService authService;

  BaseEmailOnlyViewModel(super.state, this.authService);

  void changeEmail(String value) {
    final emailError = AuthValidator.validateEmail(value);
    updateEmailState(
      value.trim(),
      !emailError.isValid,
      emailError.errorMessage,
    );
  }

  @protected
  void updateEmailState(String email, bool hasError, String? errorMessage);

  Future<void> handleEmailOperation(
    BuildContext context,
    Future<void> Function(String email) operation,
    String? successRoute,
  ) async {
    if (state.isEmailHaveError) return;
    if (state.email.isEmpty) {
      final emailError = AuthValidator.validateEmail(state.email);
      setState(state.copyWithBase(
        isEmailHaveError: !emailError.isValid,
        emailErrorMessage: emailError.errorMessage,
      ) as T);
      return;
    }

    setState(state.copyWithBase(
      isEmailHaveError: false,
      emailErrorMessage: null,
      inProcess: true,
    ) as T);

    try {
      await operation(state.email);
      setState(state.copyWithBase(inProcess: false) as T);
      if (successRoute != null) {
        Navigator.of(context).pushNamed(successRoute);
      }
    } on AuthApiProviderIncorrectEmailDataError {
      setState(state.copyWithBase(
        emailErrorMessage:
            'The email you entered isn\'t connected to an account.',
        isEmailHaveError: true,
        inProcess: false,
      ) as T);
    } catch (e) {
      setState(state.copyWithBase(
        emailErrorMessage: 'Unknown error, try later',
        inProcess: false,
      ) as T);
      debugPrint('$e');
    }
  }
}
