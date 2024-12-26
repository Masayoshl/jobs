import 'package:jobs/domain/interfaces/auth/base_state.dart';

abstract interface class IEmailState implements IBaseState {
  String get email;
  String? get emailErrorMessage;
  bool get isEmailHaveError;
}
