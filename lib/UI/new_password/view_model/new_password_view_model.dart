// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:jobs/UI/router/main_router.dart';

import 'package:jobs/domain/enums/button_state.dart';
import 'package:jobs/domain/servises/new_password_service.dart';
import 'package:jobs/domain/validators/auth_validator.dart';
import 'package:jobs/domain/validators/new_password_validator.dart';

class _NewPasswordViewModelState {
  final String password;
  final String? passwordErrorMessage;
  final bool isPasswordHaveError;

  final String confirmPassword;
  final String? confirmPasswordErrorMessage;
  final bool isConfirmPasswordHaveError;

  final bool keepIn;
  final bool inProcess;

  ButtonState get buttonState {
    if (inProcess) {
      return ButtonState.inProcess;
    } else if (!isConfirmPasswordHaveError) {
      return ButtonState.canSubmit;
    } else {
      return ButtonState.disable;
    }
  }

  _NewPasswordViewModelState({
    this.password = '',
    this.passwordErrorMessage,
    this.isPasswordHaveError = false,
    this.confirmPassword = '',
    this.confirmPasswordErrorMessage,
    this.isConfirmPasswordHaveError = false,
    this.inProcess = false,
    this.keepIn = false,
  });

  _NewPasswordViewModelState copyWith({
    String? password,
    String? passwordErrorMessage,
    bool? isPasswordHaveError,
    String? confirmPassword,
    String? confirmPasswordErrorMessage,
    bool? isConfirmPasswordHaveError,
    bool? keepIn,
    bool? inProcess,
  }) {
    return _NewPasswordViewModelState(
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

class NewPasswordViewModel extends ChangeNotifier {
  var _newPasswordSevice = NewPasswordService();
  var _state = _NewPasswordViewModelState();
  // ignore: library_private_types_in_public_api
  _NewPasswordViewModelState get state => _state;

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

  void toggleKeepIn() {
    bool change = !_state.keepIn;
    _state = _state.copyWith(keepIn: change);
    notifyListeners();
  }

  void navToAboutUserScreen(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(MainRouterNames.signUp);
  }

  Future<void> onButtonPressed(OverlayPortalController controler) async {
    // if (_state.isPasswordHaveError || _state.isConfirmPasswordHaveError) return;
    if (_state.password.isEmpty || _state.confirmPassword.isEmpty) {
      final passwordError = AuthValidator.validatePassword(_state.password);
      await Future.delayed(Duration(milliseconds: 200));
      _state = _state.copyWith(
        isPasswordHaveError: !passwordError.isValid,
        passwordErrorMessage: passwordError.errorMessage,
        isConfirmPasswordHaveError: !passwordError.isValid,
        confirmPasswordErrorMessage: passwordError.errorMessage,
      );
      notifyListeners();
      return;
    }
    if (_state.isPasswordHaveError || _state.isConfirmPasswordHaveError) return;
    _state = _state.copyWith(
      passwordErrorMessage: null,
      confirmPasswordErrorMessage: null,
      isPasswordHaveError: false,
      isConfirmPasswordHaveError: false,
      inProcess: true,
    );
    notifyListeners();

    try {
      await _newPasswordSevice.changePassword(_state.password);
      _state = _state.copyWith(inProcess: false);
      controler.toggle();
    } on ArgumentError {
      _state = _state.copyWith(
        passwordErrorMessage: 'Something went wrong',
        isPasswordHaveError: true,
        inProcess: false,
      );
    } catch (e) {
      _state = _state.copyWith(
        passwordErrorMessage: 'Unknown error, try later',
        inProcess: false,
      );

      debugPrint('$e');
    } finally {
      notifyListeners();
    }
  }
}
