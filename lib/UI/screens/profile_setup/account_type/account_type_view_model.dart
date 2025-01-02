// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:jobs/UI/screens/profile_setup/account_type/widgets/type_selector.dart';
import 'package:jobs/domain/data_providers/session_data_provider.dart';
import 'package:jobs/domain/servi%D1%81es/profile_service.dart';
import 'package:jobs/gen/assets.gen.dart';

enum AccountType implements TypeSelectorEnum {
  company,
  employee;

  @override
  String get title => switch (this) {
        AccountType.company => 'Company',
        AccountType.employee => 'Employee'
      };
  @override
  String get subtitle => switch (this) {
        AccountType.company => 'for an employee search',
        AccountType.employee => 'for a job search'
      };
  @override
  String get icon => switch (this) {
        AccountType.company => Assets.images.accountTypeCompanyType,
        AccountType.employee => Assets.images.accountTypeEmployeeType,
      };
}

enum ButtonState { enabled, inProcess, disabled }

class _AccountTypeViewModelState {
  final AccountType accountType;
  final String? errorMessage;
  final bool inProcess;

  ButtonState get buttonState {
    if (inProcess) return ButtonState.inProcess;
    //if (accountType == null) return ButtonState.disabled;
    return ButtonState.enabled;
  }

  const _AccountTypeViewModelState({
    this.accountType = AccountType.company,
    this.errorMessage,
    this.inProcess = false,
  });

  _AccountTypeViewModelState copyWith({
    AccountType? accountType,
    String? errorMessage,
    bool? inProcess,
  }) =>
      _AccountTypeViewModelState(
        accountType: accountType ?? this.accountType,
        errorMessage: errorMessage ?? this.errorMessage,
        inProcess: inProcess ?? this.inProcess,
      );
}

class AccountTypeViewModel extends ChangeNotifier {
  final _profileService = ProfileService();
  var _state = const _AccountTypeViewModelState();
  _AccountTypeViewModelState get state => _state;

  void changeType(AccountType type) {
    if (_state.accountType == type) return;
    _state = _state.copyWith(accountType: type);
    notifyListeners();
  }

  Future<void> onButtonPressed() async {
    // if (_state.accountType == null) return;

    _state = _state.copyWith(inProcess: true);
    notifyListeners();

    try {
      await _profileService.setAccountType();
      _state = _state.copyWith(inProcess: false);
    } on SessionDataProviderInvalidKeyError {
      _state = _state.copyWith(
        errorMessage: 'Invalid Session Key',
        inProcess: false,
      );
    } catch (e) {
      _state = _state.copyWith(
        errorMessage: 'Unknown error, please try again',
        inProcess: false,
      );
    }
    notifyListeners();
  }
}
