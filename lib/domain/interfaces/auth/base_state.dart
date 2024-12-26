enum ButtonState { canSubmit, inProcess, disable }

// Базовый интерфейс для всех состояний
abstract interface class IBaseState {
  bool get inProcess;
  ButtonState get buttonState;
}
