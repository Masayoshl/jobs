// base_view_model_state.dart
import 'package:flutter/material.dart';
import 'package:jobs/domain/data_providers/auth_api_provider.dart';
import 'package:jobs/domain/enums/button_state.dart';

abstract class BaseViewModelState {
  final bool inProcess;

  const BaseViewModelState({
    this.inProcess = false,
  });

  BaseViewModelState copyWithBase({
    bool? inProcess,
  });

  // Общий метод для определения состояния кнопки
  ButtonState getButtonState(bool hasErrors) {
    if (inProcess) {
      return ButtonState.inProcess;
    } else if (!hasErrors) {
      return ButtonState.canSubmit;
    } else {
      return ButtonState.disable;
    }
  }
}

abstract class BaseViewModel<T extends BaseViewModelState>
    extends ChangeNotifier {
  T _state;

  BaseViewModel(this._state);

  T get state => _state;

  @protected
  void setState(T newState) {
    _state = newState;
    notifyListeners();
  }

  void toggleKeepIn() {
    // Реализуется в подклассах если нужно
  }

  Future<void> handleError(
    dynamic error, {
    required Function(String message, bool hasError) onEmailError,
    Function(String message, bool hasError)? onPasswordError,
    Function(String message)? onGenericError,
  }) async {
    if (error is AuthApiProviderIncorrectEmailDataError) {
      onEmailError(
        'The email you entered isn\'t connected to an account.',
        true,
      );
    } else {
      const errorMessage = 'Unknown error, try later';
      if (onGenericError != null) {
        onGenericError(errorMessage);
      } else {
        onEmailError(errorMessage, false);
      }
      debugPrint('$error');
    }
  }

  void validateAndSetState({
    required bool Function() validator,
    required Function() onValid,
    required Function() onInvalid,
  }) {
    if (validator()) {
      onValid();
    } else {
      onInvalid();
    }
    notifyListeners();
  }
}
