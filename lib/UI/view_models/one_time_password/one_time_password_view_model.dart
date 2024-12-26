// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jobs/UI/router/main_router.dart';
import 'package:jobs/domain/data_providers/otp_api_provider.dart';
import 'package:jobs/domain/interfaces/auth/auth_states.dart';
import 'package:jobs/domain/interfaces/auth/base_state.dart';
import 'package:jobs/domain/servi%D1%81es/otp_service.dart';
import 'package:jobs/domain/validators/otp_code_validator.dart';

class _OtpState implements IOtpState {
  @override
  final String code;
  @override
  final String? codeErrorMessage;
  @override
  final bool isCodeHaveError;
  @override
  final bool inProcess;
  @override
  final int remainingTime;
  @override
  final String userEmail;

  _OtpState({
    this.code = '',
    this.userEmail = '',
    this.codeErrorMessage,
    this.isCodeHaveError = false,
    this.inProcess = false,
    this.remainingTime = 0,
  });

  @override
  ButtonState get buttonState {
    if (inProcess) {
      return ButtonState.inProcess;
    } else if (!isCodeHaveError) {
      return ButtonState.canSubmit;
    } else {
      return ButtonState.disable;
    }
  }

  _OtpState copyWith({
    String? code,
    String? userEmail,
    String? codeErrorMessage,
    bool? isCodeHaveError,
    bool? inProcess,
    int? remainingTime,
  }) {
    return _OtpState(
      code: code ?? this.code,
      userEmail: userEmail ?? this.userEmail,
      codeErrorMessage: codeErrorMessage ?? this.codeErrorMessage,
      isCodeHaveError: isCodeHaveError ?? this.isCodeHaveError,
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
  StreamSubscription<int>? _timerSubscription;

  var _state = _OtpState();

  _OtpState get state => _state;

  OneTimePasswordViewModel() {
    _otpService.getOtpCode();
    startTimer();
  }

  void startTimer() {
    _timerSubscription?.cancel(); // Отменяем предыдущий таймер, если есть
    _state = _state.copyWith(remainingTime: 10);
    notifyListeners();

    _timerSubscription = _timer.tick(seconds: 10).listen(
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

  @override
  void dispose() {
    _timerSubscription?.cancel();
    super.dispose();
  }

  void onChangeCode(String value) {
    final codeError = OtpCodeValidator.validateCode(value);

    _state = _state.copyWith(
      code: value.trim(),
      isCodeHaveError: !codeError.isValid,
      codeErrorMessage: codeError.errorMessage,
    );
    notifyListeners();
  }

  void resendCode() {
    _otpService.getOtpCode();
    startTimer();
  }

  Future<void> onButtonPressed(BuildContext context) async {
    final codeError = OtpCodeValidator.validateCode(_state.code);

    if (codeError.isValid) {
    } else {
      _state = _state.copyWith(
        isCodeHaveError: !codeError.isValid,
        codeErrorMessage: codeError.errorMessage,
      );
      return;
    }
    ;
    _state = _state.copyWith(
      isCodeHaveError: false,
      codeErrorMessage: null,
      inProcess: true,
    );
    notifyListeners();

    try {
      await _otpService.compareCode(_state.code);
      _state = _state.copyWith(inProcess: false);
      notifyListeners();
      Navigator.of(context).pushNamed(MainRouterNames.createPassword);
    } on OtpApiProviderIncorrectCodeDataError {
      _state = _state.copyWith(
        codeErrorMessage: 'Incorrect code',
        inProcess: false,
        isCodeHaveError: true,
      );
      notifyListeners();
    } catch (e) {
      _state = _state.copyWith(
        codeErrorMessage: 'Unknown error, try later',
        inProcess: false,
        isCodeHaveError: true,
      );
      notifyListeners();
      debugPrint('$e');
    }
  }
}
