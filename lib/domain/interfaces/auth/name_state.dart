import 'package:jobs/domain/interfaces/auth/base_state.dart';

abstract interface class INameState implements IBaseState {
  String get name;
  String? get nameErrorMessage;
  bool get isNameHaveError;
}
