abstract class ButtonStateBase {
  bool get isEnabled;
  bool get isInProcess;
  bool get isDisabled;
}

enum ButtonState implements ButtonStateBase {
  enabled,
  inProcess,
  disabled;

  @override
  bool get isEnabled => this == ButtonState.enabled;
  @override
  bool get isInProcess => this == ButtonState.inProcess;
  @override
  bool get isDisabled => this == ButtonState.disabled;
}
