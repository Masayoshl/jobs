import 'package:flutter/material.dart';

class PersonalInfoState {
  final String countryCode;

  PersonalInfoState({
    this.countryCode = '',
  });

  PersonalInfoState copyWith({
    String? countryCode,
  }) {
    return PersonalInfoState(
      countryCode: countryCode ?? this.countryCode,
    );
  }
}

class PersonalInfoViewModel extends ChangeNotifier {
  PersonalInfoState _state;

  PersonalInfoViewModel() : _state = PersonalInfoState();

  PersonalInfoState get state => _state;

  void setCountryCode(String code) {
    _state = _state.copyWith(countryCode: code.toUpperCase());
    notifyListeners();
  }
}
