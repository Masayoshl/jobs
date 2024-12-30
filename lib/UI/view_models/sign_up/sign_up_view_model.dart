// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:jobs/UI/router/main_router.dart';
import 'package:jobs/domain/data_providers/auth_api_provider.dart';
import 'package:jobs/domain/interfaces/auth/auth_states.dart';
import 'package:jobs/domain/interfaces/auth/base_state.dart';
import 'package:jobs/domain/servi%D1%81es/auth_service.dart';
import 'package:jobs/domain/validators/auth_validator.dart';
import 'package:jobs/domain/validators/new_password_validator.dart';

class _SignUpState implements ISignUpState {
  @override
  final String email;
  @override
  final String? emailErrorMessage;
  @override
  final bool isEmailHaveError;

  @override
  final String password;
  @override
  final String? passwordErrorMessage;
  @override
  final bool isPasswordHaveError;

  @override
  final String confirmPassword;
  @override
  final String? confirmPasswordErrorMessage;
  @override
  final bool isConfirmPasswordHaveError;

  @override
  final bool keepIn;

  @override
  final bool inProcess;

  _SignUpState({
    this.email = '',
    this.emailErrorMessage,
    this.isEmailHaveError = false,
    this.password = '',
    this.passwordErrorMessage,
    this.isPasswordHaveError = false,
    this.confirmPassword = '',
    this.confirmPasswordErrorMessage,
    this.isConfirmPasswordHaveError = false,
    this.keepIn = false,
    this.inProcess = false,
  });

  @override
  ButtonState get buttonState {
    if (inProcess) {
      return ButtonState.inProcess;
    } else if (!isEmailHaveError &&
        !isPasswordHaveError &&
        !isConfirmPasswordHaveError) {
      return ButtonState.canSubmit;
    } else {
      return ButtonState.disable;
    }
  }

  _SignUpState copyWith({
    String? email,
    String? emailErrorMessage,
    bool? isEmailHaveError,
    String? password,
    String? passwordErrorMessage,
    bool? isPasswordHaveError,
    String? confirmPassword,
    String? confirmPasswordErrorMessage,
    bool? isConfirmPasswordHaveError,
    bool? keepIn,
    bool? inProcess,
  }) {
    return _SignUpState(
      email: email ?? this.email,
      emailErrorMessage: emailErrorMessage ?? this.emailErrorMessage,
      isEmailHaveError: isEmailHaveError ?? this.isEmailHaveError,
      password: password ?? this.password,
      passwordErrorMessage: passwordErrorMessage ?? this.passwordErrorMessage,
      isPasswordHaveError: isPasswordHaveError ?? this.isPasswordHaveError,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      confirmPasswordErrorMessage:
          confirmPasswordErrorMessage ?? this.confirmPasswordErrorMessage,
      isConfirmPasswordHaveError:
          isConfirmPasswordHaveError ?? this.isConfirmPasswordHaveError,
      keepIn: keepIn ?? this.keepIn,
      inProcess: inProcess ?? this.inProcess,
    );
  }
}

class SignUpViewModel extends ChangeNotifier {
  final _authService = AuthService();
  var _state = _SignUpState();
  // ignore: library_private_types_in_public_api
  _SignUpState get state => _state;

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
    if (state.confirmPassword.isNotEmpty) {
      final confirmPasswordError = NewPasswordValidator.comparePasswords(
        value.trim(),
        state.confirmPassword,
      );
      _state = _state.copyWith(
        isConfirmPasswordHaveError: !confirmPasswordError.isValid,
        confirmPasswordErrorMessage: confirmPasswordError.errorMessage,
      );
    }
    notifyListeners();
  }

  void changeConfirmPassword(String value) {
    _state = _state.copyWith(confirmPassword: value.trim());
    final confirmPasswordError = NewPasswordValidator.comparePasswords(
        _state.password, _state.confirmPassword);
    _state = _state.copyWith(
      isConfirmPasswordHaveError: !confirmPasswordError.isValid,
      confirmPasswordErrorMessage: confirmPasswordError.errorMessage,
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
        _state.isConfirmPasswordHaveError) return;
    if (_state.email.isEmpty ||
        _state.password.isEmpty ||
        _state.confirmPassword.isEmpty) return;

    _state = _state.copyWith(
      emailErrorMessage: null,
      passwordErrorMessage: null,
      confirmPasswordErrorMessage: null,
      isEmailHaveError: false,
      isPasswordHaveError: false,
      isConfirmPasswordHaveError: false,
      inProcess: true,
    );
    notifyListeners();

    try {
      await _authService.signUp(
          _state.email, _state.password, _state.confirmPassword);
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
