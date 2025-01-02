// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:jobs/UI/router/main_router.dart';
import 'package:jobs/domain/entity/password.dart';

import 'package:jobs/domain/servi%D1%81es/new_password_service.dart';

enum ButtonState { enabled, inProcess, disable }

class _NewPasswordViewModelState {
  final Password password;
  final bool keepIn;
  final bool inProcess;

  ButtonState get buttonState {
    if (inProcess) {
      return ButtonState.inProcess;
    } else if (!password.hasError && !password.hasConfirmError) {
      return ButtonState.enabled;
    } else {
      return ButtonState.disable;
    }
  }

  _NewPasswordViewModelState({
    Password? password,
    this.keepIn = false,
    this.inProcess = false,
  }) : password = password ?? Password();

  _NewPasswordViewModelState copyWith({
    Password? password,
    bool? keepIn,
    bool? inProcess,
  }) {
    return _NewPasswordViewModelState(
      password: password ?? this.password,
      keepIn: keepIn ?? this.keepIn,
      inProcess: inProcess ?? this.inProcess,
    );
  }
}

class NewPasswordViewModel extends ChangeNotifier {
  final _newPasswordService = NewPasswordService();
  var _state = _NewPasswordViewModelState();
  _NewPasswordViewModelState get state => _state;

  void changePassword(String value) {
    final newPassword = Password(
      value: value,
      confirmValue: _state.password.confirmValue,
      isDirty: true,
    );
    _state = _state.copyWith(password: newPassword);
    notifyListeners();
  }

  void changeConfirmPassword(String value) {
    final newPassword = Password(
      value: _state.password.value,
      confirmValue: value,
      isDirty: true,
    );
    _state = _state.copyWith(password: newPassword);
    notifyListeners();
  }

  void toggleKeepIn() {
    _state = _state.copyWith(keepIn: !_state.keepIn);
    notifyListeners();
  }

  void navToAboutUserScreen(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(MainRouterNames.signUp);
  }

  Future<void> onButtonPressed(OverlayPortalController controller) async {
    if (_state.password.value.isEmpty ||
        (_state.password.confirmValue?.isEmpty ?? true)) {
      final newPassword = Password(
        value: _state.password.value,
        confirmValue: _state.password.confirmValue,
        isDirty: true,
      );
      _state = _state.copyWith(password: newPassword);
      notifyListeners();
      return;
    }

    if (_state.password.hasError || _state.password.hasConfirmError) return;

    _state = _state.copyWith(inProcess: true);
    notifyListeners();

    try {
      await _newPasswordService.changePassword(_state.password.value);
      _state = _state.copyWith(inProcess: false);
      controller.toggle();
    } on ArgumentError {
      _state = _state.copyWith(
        password: Password(
          value: _state.password.value,
          confirmValue: _state.password.confirmValue,
          isDirty: true,
        ),
        inProcess: false,
      );
    } catch (e) {
      _state = _state.copyWith(
        password: Password(
          value: _state.password.value,
          confirmValue: _state.password.confirmValue,
          isDirty: true,
        ),
        inProcess: false,
      );
      debugPrint('$e');
    }
    notifyListeners();
  }
}
