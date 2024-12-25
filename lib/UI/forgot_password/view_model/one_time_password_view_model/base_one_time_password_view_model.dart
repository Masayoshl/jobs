import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jobs/UI/base_view_model/base_view_model.dart';
import 'package:jobs/UI/router/main_router.dart';
import 'package:jobs/domain/data_providers/otp_api_provider.dart';
import 'package:jobs/domain/enums/button_state.dart';
import 'package:jobs/domain/servises/otp_service.dart';
import 'package:jobs/domain/validators/otp_code_validator.dart';

abstract class BaseOtpViewModelState extends BaseViewModelState {
  final String code;
  final String? codeErrorMessage;
  final bool isCodeHaveError;
  final int remainingTime;
  final String userEmail;

  const BaseOtpViewModelState({
    required this.code,
    this.codeErrorMessage,
    this.isCodeHaveError = false,
    required this.remainingTime,
    required this.userEmail,
    super.inProcess = false,
  });

  @override
  BaseOtpViewModelState copyWithBase({
    String? code,
    String? codeErrorMessage,
    bool? isCodeHaveError,
    int? remainingTime,
    String? userEmail,
    bool? inProcess,
  });

  ButtonState get buttonState => getButtonState(isCodeHaveError);
}

// base_otp_timer.dart
class OtpTimer {
  const OtpTimer();

  Stream<int> tick({required int seconds}) {
    return Stream.periodic(const Duration(seconds: 1), (x) => seconds - x - 1)
        .take(seconds);
  }
}

// base_otp_view_model.dart
abstract class BaseOtpViewModel<T extends BaseOtpViewModelState>
    extends BaseViewModel<T> {
  final OtpService otpService;
  final OtpTimer _timer;
  StreamSubscription<int>? _timerSubscription;

  BaseOtpViewModel(
    super.state,
    this.otpService, {
    OtpTimer? timer,
  }) : _timer = timer ?? const OtpTimer() {
    _initializeOtp();
  }

  Future<void> _initializeOtp() async {
    await otpService.getOtpCode();
    startTimer();
  }

  void startTimer() {
    _timerSubscription?.cancel();
    updateTimerState(10); // Можно сделать configurable

    _timerSubscription = _timer.tick(seconds: 10).listen(
      (remaining) {
        updateTimerState(remaining);
      },
      onDone: () {
        stopTimer();
      },
    );
  }

  void stopTimer() {
    _timerSubscription?.cancel();
    _timerSubscription = null;
    updateTimerState(0);
  }

  @protected
  void updateTimerState(int remainingTime);

  void onChangeCode(String value) {
    final codeError = OtpCodeValidator.validateCode(value);
    updateCodeState(value.trim(), !codeError.isValid, codeError.errorMessage);
  }

  @protected
  void updateCodeState(String code, bool hasError, String? errorMessage);

  void resendCode() {
    otpService.getOtpCode();
    startTimer();
  }

  Future<void> handleOtpOperation(
      BuildContext context, Future<void> Function() operation) async {
    final codeError = OtpCodeValidator.validateCode(state.code);

    if (!codeError.isValid) {
      updateCodeState(
        state.code,
        true,
        codeError.errorMessage,
      );
      return;
    }

    setState(state.copyWithBase(
      isCodeHaveError: false,
      codeErrorMessage: null,
      inProcess: true,
    ) as T);

    try {
      await operation();
      setState(state.copyWithBase(inProcess: false) as T);
      Navigator.of(context).pushNamed(MainRouterNames.createPassword);
    } on OtpApiProviderIncorrectCodeDataError {
      setState(state.copyWithBase(
        codeErrorMessage: 'Incorrect code',
        isCodeHaveError: true,
        inProcess: false,
      ) as T);
    } catch (e) {
      setState(state.copyWithBase(
        codeErrorMessage: 'Unknown error, try later',
        isCodeHaveError: true,
        inProcess: false,
      ) as T);
      debugPrint('$e');
    }
  }

  @override
  void dispose() {
    _timerSubscription?.cancel();
    super.dispose();
  }
}
