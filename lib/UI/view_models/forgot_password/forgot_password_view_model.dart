// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:jobs/UI/router/main_router.dart';

import 'package:jobs/domain/data_providers/auth_api_provider.dart';
import 'package:jobs/domain/entity/email.dart';
import 'package:jobs/domain/servi%D1%81es/auth_service.dart';

import '../../common/button_state.dart';

class _ForgotPasswordViewModelState {
  final Email email;

  final bool inProcess;

  ButtonState get buttonState {
    if (inProcess) {
      return ButtonState.inProcess;
    } else if (!email.hasError) {
      return ButtonState.enabled;
    } else {
      return ButtonState.disabled;
    }
  }

  _ForgotPasswordViewModelState({Email? email, this.inProcess = false})
      : email = email ?? Email();

  _ForgotPasswordViewModelState copyWith({
    Email? email,
    bool? inProcess,
  }) {
    return _ForgotPasswordViewModelState(
      email: email ?? this.email,
      inProcess: inProcess ?? this.inProcess,
    );
  }
}

class ForgotPasswordViewModel extends ChangeNotifier {
  final _authService = AuthService();
  var _state = _ForgotPasswordViewModelState();
  _ForgotPasswordViewModelState get state => _state;

  void changeEmail(String value) {
    final newEmail = Email(value: value, isDirty: true);
    _state = _state.copyWith(email: newEmail);
    notifyListeners();
  }

  Future<void> onButtonPressed(BuildContext context) async {
    if (_state.email.hasError) return;
    if (_state.email.value.isEmpty) return;

    _state = _state.copyWith(inProcess: true);
    notifyListeners();

    try {
      await _authService.forgotPassword(_state.email.value);
      _state = _state.copyWith(inProcess: false);
      notifyListeners();
      Navigator.of(context).pushNamed(MainRouterNames.oneTimePassword);
    } on AuthApiProviderIncorrectEmailDataError {
      //TODO
      _state = _state.copyWith(
        email: Email(value: _state.email.value, isDirty: true),
        inProcess: false,
      );
    } catch (e) {
      _state = _state.copyWith(
        email: Email(value: _state.email.value, isDirty: true),
        inProcess: false,
      );
      debugPrint('$e');
    }
    notifyListeners();
  }
}
