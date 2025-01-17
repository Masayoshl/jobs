// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl_phone_field/countries.dart';

class PersonalInfoState {
  final String countryCode;
  final int maxLength;
  PersonalInfoState({
    this.countryCode = '',
    this.maxLength = 0,
  });

  PersonalInfoState copyWith({
    String? countryCode,
    int? maxLength,
  }) {
    return PersonalInfoState(
      countryCode: countryCode ?? this.countryCode,
      maxLength: maxLength ?? this.maxLength,
    );
  }
}

class PersonalInfoViewModel extends ChangeNotifier {
  PersonalInfoState _state;

  PersonalInfoViewModel() : _state = PersonalInfoState();

  PersonalInfoState get state => _state;

  void setCountryCode(String code) {
    int maxLength =
        countries.firstWhere((country) => country.code == code).maxLength;
    _state = _state.copyWith(countryCode: code, maxLength: maxLength);
  }
}
