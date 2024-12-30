// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jobs/UI/router/main_router.dart';
import 'package:jobs/domain/data_providers/auth_api_provider.dart';
import 'package:jobs/domain/entity/email.dart';
import 'package:jobs/domain/serviсes/auth_service.dart';
import 'package:jobs/domain/validators/auth_validator.dart';

enum ButtonState { canSubmit, inProcess, disable }

class _SignInViewModelState {
  final Email email;
  final String password;
  final String? passwordErrorMessage;
  final bool isPasswordHaveError;
  final bool keepIn;
  final bool inProcess;

  _SignInViewModelState({
    Email? email,
    this.password = '',
    this.passwordErrorMessage,
    this.isPasswordHaveError = false,
    this.keepIn = false,
    this.inProcess = false,
  }) : email = email ?? Email();

  ButtonState get buttonState {
    if (inProcess) {
      return ButtonState.inProcess;
    } else if (!email.hasError && !isPasswordHaveError) {
      return ButtonState.canSubmit;
    } else {
      return ButtonState.disable;
    }
  }

  _SignInViewModelState copyWith({
    Email? email,
    String? password,
    String? passwordErrorMessage,
    bool? isPasswordHaveError,
    bool? keepIn,
    bool? inProcess,
  }) {
    return _SignInViewModelState(
      email: email ?? this.email,
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
  _SignInViewModelState get state => _state;

  void changeEmail(String value) {
    final newEmail = Email(
      value: value,
      isDirty: true, // Помечаем как "грязный" при изменении
    );
    _state = _state.copyWith(email: newEmail);
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
    if (_state.email.hasError || _state.isPasswordHaveError) return;
    if (_state.email.value.isEmpty || _state.password.isEmpty) return;

    _state = _state.copyWith(
      email: Email(value: _state.email.value), // Reset email validation
      passwordErrorMessage: null,
      isPasswordHaveError: false,
      inProcess: true,
    );
    notifyListeners();

    try {
      await _authService.signIn(_state.email.value, _state.password);
      _state = _state.copyWith(inProcess: false);
    } on AuthApiProviderIncorrectEmailDataError {
      _state = _state.copyWith(
        email: Email(value: _state.email.value), // This will revalidate email
        inProcess: false,
      );
    } catch (e) {
      // В случае неизвестной ошибки создаем новый Email с тем же значением
      final errorEmail = Email(value: _state.email.value);
      _state = _state.copyWith(
        email: errorEmail,
        inProcess: false,
      );
      debugPrint('$e');
    } finally {
      notifyListeners();
    }
  }
}
