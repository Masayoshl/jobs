// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:jobs/UI/router/main_router.dart';
import 'package:jobs/domain/data_providers/auth_api_provider.dart';
import 'package:jobs/domain/enums/button_state.dart';
import 'package:jobs/domain/servises/auth_service.dart';
import 'package:jobs/domain/validators/auth_validator.dart';

class _SignInViewModelState {
  final String email;
  final String? emailErrorMessage;
  final bool isEmailHaveError;

  final String password;
  final String? passwordErrorMessage;
  final bool isPasswordHaveError;

  final bool keepIn;

  final bool inProcess;
  _SignInViewModelState({
    this.email = '',
    this.emailErrorMessage,
    this.isEmailHaveError = false,
    this.password = '',
    this.passwordErrorMessage,
    this.isPasswordHaveError = false,
    this.keepIn = false,
    this.inProcess = false,
  });

  ButtonState get buttonState {
    if (inProcess) {
      return ButtonState.inProcess;
    } else if (!isEmailHaveError && !isPasswordHaveError) {
      return ButtonState.canSubmit;
    } else {
      return ButtonState.disable;
    }
  }

  _SignInViewModelState copyWith({
    String? email,
    String? emailErrorMessage,
    bool? isEmailHaveError,
    String? password,
    String? passwordErrorMessage,
    bool? isPasswordHaveError,
    bool? keepIn,
    bool? inProcess,
  }) {
    return _SignInViewModelState(
      email: email ?? this.email,
      emailErrorMessage: emailErrorMessage ?? this.emailErrorMessage,
      isEmailHaveError: isEmailHaveError ?? this.isEmailHaveError,
      password: password ?? this.password,
      passwordErrorMessage: passwordErrorMessage ?? this.passwordErrorMessage,
      isPasswordHaveError: isPasswordHaveError ?? this.isPasswordHaveError,
      keepIn: keepIn ?? this.keepIn,
      inProcess: inProcess ?? this.inProcess,
    );
  }
}

class SignInViewModel extends ChangeNotifier {
  final _authService = AuthService();
  var _state = _SignInViewModelState();
  // ignore: library_private_types_in_public_api
  _SignInViewModelState get state => _state;

  void changeEmail(String value) {
    final emailError = AuthValidator.validateEmail(value);
    _state = _state.copyWith(
      email: value.trim(),
      isEmailHaveError: !emailError.isValid,
      emailErrorMessage: emailError.errorMessage,
    );
    notifyListeners();
  }

  void changePassword(String value) {
    final passwordError = AuthValidator.validatePassword(value);
    _state = _state.copyWith(
      password: value.trim(),
      isPasswordHaveError: !passwordError.isValid,
      passwordErrorMessage: passwordError.errorMessage,
    );
    notifyListeners();
  }

  void toggleKeepIn() {
    bool change = !_state.keepIn;
    _state = _state.copyWith(keepIn: change);
    notifyListeners();
  }

  void navToForgotPasswordScreen(BuildContext context) {
    SystemSound.play(SystemSoundType.click);
    Navigator.of(context).pushNamed(MainRouterNames.forgotPassword);
  }

  void navToSignUpScreen(BuildContext context) {
    SystemSound.play(SystemSoundType.click);

    Navigator.of(context).pushReplacementNamed(MainRouterNames.signUp);
  }

  Future<void> onAuthButtonPressed(BuildContext context) async {
    if (_state.isEmailHaveError || _state.isPasswordHaveError) return;
    if (_state.email.isEmpty || _state.password.isEmpty) return;

    _state = _state.copyWith(
      emailErrorMessage: null,
      passwordErrorMessage: null,
      isEmailHaveError: false,
      isPasswordHaveError: false,
      inProcess: true,
    );
    notifyListeners();

    try {
      await _authService.signIn(_state.email, _state.password);
      _state = _state.copyWith(inProcess: false);
    } on AuthApiProviderIncorrectEmailDataError {
      _state = _state.copyWith(
        emailErrorMessage:
            'The email you entered isn’t connected to an account.',
        inProcess: false,
        isEmailHaveError: true,
      );
    } catch (e) {
      _state = _state.copyWith(
        emailErrorMessage: 'Unknown error, try later',
        inProcess: false,
      );

      debugPrint('$e');
    } finally {
      notifyListeners();
    }
  }
}
