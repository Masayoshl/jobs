// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jobs/UI/common/button_state.dart';
import 'package:jobs/UI/router/main_router.dart';
import 'package:jobs/domain/data_providers/auth_api_provider.dart';
import 'package:jobs/domain/entity/email.dart';
import 'package:jobs/domain/entity/name.dart';
import 'package:jobs/domain/entity/password.dart';
import 'package:jobs/domain/servi%D1%81es/auth_service.dart';

class _SignUpViewModelState {
  final Email email;
  final Password password;
  final Name name;
  final bool keepIn;
  final bool inProcess;

  _SignUpViewModelState({
    Email? email,
    Password? password,
    Name? name,
    this.keepIn = false,
    this.inProcess = false,
  })  : email = email ?? Email(),
        password = password ?? Password(),
        name = name ?? Name();

  ButtonState get buttonState {
    if (inProcess) {
      return ButtonState.inProcess;
    } else if (!email.hasError && !password.hasError && !name.hasError) {
      return ButtonState.enabled;
    } else {
      return ButtonState.disabled;
    }
  }

  _SignUpViewModelState copyWith({
    Email? email,
    Password? password,
    Name? name,
    bool? keepIn,
    bool? inProcess,
  }) {
    return _SignUpViewModelState(
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      keepIn: keepIn ?? this.keepIn,
      inProcess: inProcess ?? this.inProcess,
    );
  }
}

class SignUpViewModel extends ChangeNotifier {
  final _authService = AuthService();
  var _state = _SignUpViewModelState();
  _SignUpViewModelState get state => _state;

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

  void changeName(String value) {
    final newName = Name(value: value, isDirty: true);
    _state = _state.copyWith(name: newName);
    notifyListeners();
  }

  void changeCheckBox() {
    _state = _state.copyWith(keepIn: !_state.keepIn);
    notifyListeners();
  }

  void navToSignInScreen(BuildContext context) {
    SystemSound.play(SystemSoundType.click);
    Navigator.of(context).pushReplacementNamed(MainRouterNames.sigIn);
  }

  Future<void> onAuthButtonPressed(BuildContext context) async {
    if (_state.email.hasError ||
        _state.password.hasError ||
        _state.name.hasError) return;
    if (_state.email.value.isEmpty ||
        _state.password.value.isEmpty ||
        _state.name.value.isEmpty) return;

    _state = _state.copyWith(inProcess: true);
    notifyListeners();

    try {
      await _authService.signUp(
          _state.email.value, _state.password.value, _state.name.value);
      _state = _state.copyWith(inProcess: false);
      Navigator.of(context).pushNamed(MainRouterNames.profileSetup);
    } on AuthApiProviderIncorrectEmailDataError {
      _state = _state.copyWith(
        email: Email(
            externalErrorMessage: 'The mail is already being used',
            isDirty: true),
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
