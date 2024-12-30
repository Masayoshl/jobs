// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:jobs/UI/router/main_router.dart';
import 'package:jobs/domain/data_providers/auth_api_provider.dart';

import 'package:jobs/domain/servi%D1%81es/auth_service.dart';
import 'package:jobs/domain/validators/auth_validator.dart';

enum ButtonState { canSubmit, inProcess, disable }

class _ForgotPasswordViewModelState {
  final String email;
  final String? emailErrorMessage;
  final bool isEmailHaveError;

  final bool inProcess;

  ButtonState get buttonState {
    if (inProcess) {
      return ButtonState.inProcess;
    } else if (!isEmailHaveError) {
      return ButtonState.canSubmit;
    } else {
      return ButtonState.disable;
    }
  }

  _ForgotPasswordViewModelState(
      {this.email = '',
      this.emailErrorMessage,
      this.isEmailHaveError = false,
      this.inProcess = false});

  _ForgotPasswordViewModelState copyWith({
    String? email,
    String? emailErrorMessage,
    bool? isEmailHaveError,
    bool? inProcess,
  }) {
    return _ForgotPasswordViewModelState(
      email: email ?? this.email,
      emailErrorMessage: emailErrorMessage ?? this.emailErrorMessage,
      isEmailHaveError: isEmailHaveError ?? this.isEmailHaveError,
      inProcess: inProcess ?? this.inProcess,
    );
  }
}

class ForgotPasswordViewModel extends ChangeNotifier {
  final _authService = AuthService();
  var _state = _ForgotPasswordViewModelState();
  _ForgotPasswordViewModelState get state => _state;
  void changeEmail(String value) {
    final emailError = AuthValidator.validateEmail(value);

    _state = _state.copyWith(
      email: value.trim(),
      isEmailHaveError: !emailError.isValid,
      emailErrorMessage: emailError.errorMessage,
    );
    notifyListeners();
  }

  Future<void> onButtonPressed(BuildContext context) async {
    if (_state.isEmailHaveError) return;
    if (_state.email.isEmpty) return;

    _state = _state.copyWith(
      isEmailHaveError: false,
      emailErrorMessage: null,
      inProcess: true,
    );
    notifyListeners();

    try {
      await _authService.forgotPassword(_state.email);
      _state = _state.copyWith(inProcess: false);
      notifyListeners();
      Navigator.of(context).pushNamed(MainRouterNames.oneTimePassword);
    } on AuthApiProviderIncorrectEmailDataError {
      //TODO
      _state = _state.copyWith(
        emailErrorMessage:
            'The email you entered isn’t connected to an account.',
        inProcess: false,
        isEmailHaveError: true,
      );
      notifyListeners();
    } catch (e) {
      _state = _state.copyWith(
        emailErrorMessage: 'Unknown error, try later',
        inProcess: false,
      );
      notifyListeners();
      print(e);
    }
  }
}
