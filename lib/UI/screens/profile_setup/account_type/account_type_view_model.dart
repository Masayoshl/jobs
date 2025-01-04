// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:jobs/UI/common/button_state.dart';
import 'package:jobs/UI/router/main_router.dart';
import 'package:jobs/UI/screens/profile_setup/account_type/widgets/type_selector.dart';
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

  void navToSelectCountryScreeen(BuildContext context) {
    Navigator.of(context).pushNamed(MainRouterNames.selectCountry);
  }

  Future<void> onButtonPressed(BuildContext context) async {
    // if (_state.accountType == null) return;

    _state = _state.copyWith(inProcess: true);
    notifyListeners();

    try {
      await _profileService.setAccountType();
      _state = _state.copyWith(inProcess: false);
      navToSelectCountryScreeen(context);
    } on ProfileServiceError catch (e) {
      _state = _state.copyWith(
        errorMessage: e.message,
        inProcess: false,
      );
      debugPrint(_state.errorMessage);
    } catch (e) {
      _state = _state.copyWith(
        errorMessage: e.toString(),
        inProcess: false,
      );
    } finally {
      notifyListeners();
      //debugPrint(_state.errorMessage);
    }
  }
}
