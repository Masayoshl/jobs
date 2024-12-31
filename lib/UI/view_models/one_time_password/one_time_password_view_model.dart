// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jobs/UI/router/main_router.dart';
import 'package:jobs/domain/data_providers/otp_api_provider.dart';
import 'package:jobs/domain/entity/one_time_password.dart';

import 'package:jobs/domain/servi%D1%81es/otp_service.dart';

enum ButtonState { canSubmit, inProcess, disable }

class _OneTimePasswordViewModelState {
  final OneTimePassword password;
  final String userEmail;
  final bool inProcess;
  final int remainingTime;

  ButtonState get buttonState {
    if (inProcess) {
      return ButtonState.inProcess;
    } else if (!password.hasError) {
      return ButtonState.canSubmit;
    } else {
      return ButtonState.disable;
    }
  }

  _OneTimePasswordViewModelState({
    OneTimePassword? password,
    this.userEmail = 'luckoandrej@gmail.com',
    this.inProcess = false,
    this.remainingTime = 0,
  }) : password = password ?? OneTimePassword();

  _OneTimePasswordViewModelState copyWith({
    OneTimePassword? password,
    String? userEmail,
    bool? inProcess,
    int? remainingTime,
  }) {
    return _OneTimePasswordViewModelState(
      password: password ?? this.password,
      userEmail: userEmail ?? this.userEmail,
      inProcess: inProcess ?? this.inProcess,
      remainingTime: remainingTime ?? this.remainingTime,
    );
  }
}

class _Timer {
  const _Timer();
  Stream<int> tick({required int seconds}) {
    return Stream.periodic(const Duration(seconds: 1), (x) => seconds - x - 1)
        .take(seconds);
  }
}

class OneTimePasswordViewModel extends ChangeNotifier {
  final _otpService = OtpService();
  final _Timer _timer = _Timer();
  static const timeoutSeconds = 10;
  StreamSubscription<int>? _timerSubscription;
  var _state = _OneTimePasswordViewModelState();
  _OneTimePasswordViewModelState get state => _state;

  OneTimePasswordViewModel() {
    _otpService.getOtpCode();
    startTimer();
  }

  void onChangePassword(String value) {
    final newPassword = OneTimePassword(value: value, isDirty: true);
    _state = _state.copyWith(password: newPassword);
    notifyListeners();
  }

  Future<void> onButtonPressed(BuildContext context) async {
    if (_state.password.hasError || _state.password.value.isEmpty) return;

    _state = _state.copyWith(inProcess: true);
    notifyListeners();

    try {
      await _otpService.compareCode(_state.password.value);
      _state = _state.copyWith(inProcess: false);
      notifyListeners();
      Navigator.of(context).pushNamed(MainRouterNames.createPassword);
    } on OtpApiProviderIncorrectCodeDataError {
      _state = _state.copyWith(
        password: OneTimePassword(
            value: _state.password.value, isDirty: true, isIncorrectCode: true),
        inProcess: false,
      );
    } catch (e) {
      _state = _state.copyWith(
        password: OneTimePassword(value: _state.password.value, isDirty: true),
        inProcess: false,
      );
      debugPrint('$e');
    } finally {
      notifyListeners();
    }
  }

  void startTimer() {
    _timerSubscription?.cancel();
    _state = _state.copyWith(remainingTime: timeoutSeconds);
    notifyListeners();

    _timerSubscription = _timer.tick(seconds: timeoutSeconds).listen(
      (remaining) {
        _state = _state.copyWith(remainingTime: remaining);
        notifyListeners();
      },
      onDone: () {
        stopTimer();
        notifyListeners();
      },
    );
  }

  void stopTimer() {
    _timerSubscription?.cancel();
    _timerSubscription = null;
    _state = _state.copyWith(remainingTime: 0);
    notifyListeners();
  }

  void resendCode() {
    _otpService.getOtpCode();
    startTimer();
  }

  @override
  void dispose() {
    _timerSubscription?.cancel();
    super.dispose();
  }
}
