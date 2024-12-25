// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:jobs/UI/router/main_router.dart';
import 'package:jobs/domain/data_providers/auth_api_provider.dart';
import 'package:jobs/domain/enums/button_state.dart';
import 'package:jobs/domain/servises/auth_service.dart';
import 'package:jobs/domain/validators/auth_validator.dart';

class _SignUpViewModelState {
  final String email;
  final String? emailErrorMessage;
  final bool isEmailHaveError;

  final String password;
  final String? passwordErrorMassage;
  final bool isPasswordHaveError;

  final String name;
  final String? nameErrorMessage;
  final bool isNameHaveError;

  final bool keepIn;

  final bool inProcess;
  _SignUpViewModelState({
    this.email = '',
    this.emailErrorMessage,
    this.isEmailHaveError = false,
    this.password = '',
    this.passwordErrorMassage,
    this.isPasswordHaveError = false,
    this.name = '',
    this.nameErrorMessage,
    this.isNameHaveError = false,
    this.keepIn = false,
    this.inProcess = false,
  });

  ButtonState get buttonState {
    if (inProcess) {
      return ButtonState.inProcess;
    } else if (!isEmailHaveError && !isPasswordHaveError && !isNameHaveError) {
      return ButtonState.canSubmit;
    } else {
      return ButtonState.disable;
    }
  }

  _SignUpViewModelState copyWith({
    String? email,
    String? emailErrorMessage,
    bool? isEmailHaveError,
    String? password,
    String? passwordErrorMassage,
    bool? isPasswordHaveError,
    String? name,
    String? nameErrorMessage,
    bool? isNameHaveError,
    bool? keepIn,
    bool? inProcess,
  }) {
    return _SignUpViewModelState(
      email: email ?? this.email,
      emailErrorMessage: emailErrorMessage ?? this.emailErrorMessage,
      isEmailHaveError: isEmailHaveError ?? this.isEmailHaveError,
      password: password ?? this.password,
      passwordErrorMassage: passwordErrorMassage ?? this.passwordErrorMassage,
      isPasswordHaveError: isPasswordHaveError ?? this.isPasswordHaveError,
      name: name ?? this.name,
      nameErrorMessage: nameErrorMessage ?? this.nameErrorMessage,
      isNameHaveError: isNameHaveError ?? this.isNameHaveError,
      keepIn: keepIn ?? this.keepIn,
      inProcess: inProcess ?? this.inProcess,
    );
  }
}

class SignUpViewModel extends ChangeNotifier {
  final _authService = AuthService();
  var _state = _SignUpViewModelState();
  // ignore: library_private_types_in_public_api
  _SignUpViewModelState get state => _state;

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
      passwordErrorMassage: passwordError.errorMessage,
    );
    notifyListeners();
  }

  void changeName(String value) {
    final nameError = AuthValidator.validateName(value);
    _state = _state.copyWith(
      name: value.trim(),
      isNameHaveError: !nameError.isValid,
      nameErrorMessage: nameError.errorMessage,
    );
    notifyListeners();
  }

  void changeCheckBox() {
    bool change = !_state.keepIn;
    _state = _state.copyWith(keepIn: change);
    notifyListeners();
  }

  void navToSignInScreen(BuildContext context) {
    SystemSound.play(SystemSoundType.click);
    Navigator.of(context).pushReplacementNamed(MainRouterNames.sigIn);
  }

  Future<void> onAuthButtonPressed(BuildContext context) async {
    if (_state.isEmailHaveError ||
        _state.isPasswordHaveError ||
        _state.isNameHaveError) return;
    if (_state.email.isEmpty || _state.password.isEmpty || _state.name.isEmpty)
      return;

    _state = _state.copyWith(
      emailErrorMessage: null,
      passwordErrorMassage: null,
      nameErrorMessage: null,
      isEmailHaveError: false,
      isPasswordHaveError: false,
      isNameHaveError: false,
      inProcess: true,
    );
    notifyListeners();

    try {
      await _authService.signUp(_state.email, _state.password, _state.name);
      _state = _state.copyWith(inProcess: false);
      notifyListeners();
    } on AuthApiProviderIncorrectEmailDataError {
      _state = _state.copyWith(
        emailErrorMessage:
            'The email you entered isn’t connected to an account.',
        isEmailHaveError: true,
        inProcess: false,
      );
      notifyListeners();
    } catch (e) {
      _state = _state.copyWith(
        emailErrorMessage: 'Unknown error, try later',
        inProcess: false,
      );
      notifyListeners();
      debugPrint('$e');
    }
  }
}
