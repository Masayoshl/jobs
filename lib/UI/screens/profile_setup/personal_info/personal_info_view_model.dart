// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl_phone_field/countries.dart';

import 'package:jobs/domain/entity/date.dart';

class PersonalInfoState {
  final Date dateOfBirth;
  final String countryCode;
  final int maxLength;
  PersonalInfoState({
    Date? dateOfBirth,
    this.countryCode = '',
    this.maxLength = 0,
  }) : dateOfBirth = dateOfBirth ?? Date();

  PersonalInfoState copyWith({
    Date? dateOfBirth,
    String? countryCode,
    int? maxLength,
  }) {
    return PersonalInfoState(
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      countryCode: countryCode ?? this.countryCode,
      maxLength: maxLength ?? this.maxLength,
    );
  }
}

class PersonalInfoViewModel extends ChangeNotifier {
  // final String initialCountryCode;
  PersonalInfoState _state = PersonalInfoState();

  // PersonalInfoViewModel(this.initialCountryCode);

  PersonalInfoState get state => _state;

  void changeDateOfBirth(String value) {
    final newDateOfBirth = Date(value: value, isDirty: true);
    _state = _state.copyWith(dateOfBirth: newDateOfBirth);
    notifyListeners();
  }

  void setCountryCode(String code) {
    int maxLength =
        countries.firstWhere((country) => country.code == code).maxLength;
    print(maxLength);
    _state = _state.copyWith(countryCode: code, maxLength: maxLength);
  }
}
