// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jobs/UI/common/button_state.dart';
import 'package:jobs/UI/router/main_router.dart';
import 'package:jobs/domain/data_providers/auth_api_provider.dart';
import 'package:jobs/domain/entity/fields/email.dart';
import 'package:jobs/domain/entity/fields/password.dart';
import 'package:jobs/domain/serviсes/auth_service.dart';

class _SignInViewModelState {
  final Email email;
  final Password password;
  final bool keepIn;
  final bool inProcess;

  _SignInViewModelState({
    Email? email,
    Password? password,
    this.keepIn = false,
    this.inProcess = false,
  })  : email = email ?? Email(),
        password = password ?? Password();

  ButtonState get buttonState {
    if (inProcess) {
      return ButtonState.inProcess;
    } else if (!email.hasError && !password.hasError) {
      return ButtonState.enabled;
    } else {
      return ButtonState.disabled;
    }
  }

  _SignInViewModelState copyWith({
    Email? email,
    Password? password,
    bool? keepIn,
    bool? inProcess,
  }) {
    return _SignInViewModelState(
      email: email ?? this.email,
      password: password ?? this.password,
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
    final newEmail = Email(value: value, isDirty: true);
    _state = _state.copyWith(email: newEmail);
    notifyListeners();
  }

  void changePassword(String value) {
    final newPassword = Password(value: value, isDirty: true);
    _state = _state.copyWith(password: newPassword);
    notifyListeners();
  }

  void toggleKeepIn() {
    _state = _state.copyWith(keepIn: !_state.keepIn);
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
    if (_state.email.hasError || _state.password.hasError) return;
    if (_state.email.value.isEmpty || _state.password.value.isEmpty) return;

    _state = _state.copyWith(inProcess: true);
    notifyListeners();

    try {
      await _authService.signIn(_state.email.value, _state.password.value);
      _state = _state.copyWith(inProcess: false);
    } on AuthApiProviderIncorrectEmailDataError {
      _state = _state.copyWith(
        email: Email(
            value: _state.email.value,
            externalErrorMessage:
                'The email you entered isn’t connected to an account.',
            isDirty: true),
        inProcess: false,
      );
    } catch (e) {
      _state = _state.copyWith(
        email: Email(
            value: _state.email.value,
            externalErrorMessage: 'Unknown error, try later',
            isDirty: true),
        inProcess: false,
      );
      debugPrint('$e');
    }
    notifyListeners();
  }
}
