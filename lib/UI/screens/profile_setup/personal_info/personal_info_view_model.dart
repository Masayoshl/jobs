import 'package:flutter/material.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:jobs/domain/entity/entity.dart';

class PersonalInfoState {
  final Name fullName;
  final Date dateOfBirth;
  final PhoneNumber phoneNumber;

  PersonalInfoState({
    Name? fullName,
    Date? dateOfBirth,
    PhoneNumber? phoneNumber,
  })  : fullName = fullName ?? Name(),
        dateOfBirth = dateOfBirth ?? Date(),
        phoneNumber = phoneNumber ??
            PhoneNumber(
                countryCode: '', dialCode: '', maxLength: 0, minLength: 0);

  PersonalInfoState copyWith({
    Name? fullName,
    Date? dateOfBirth,
    PhoneNumber? phoneNumber,
  }) {
    return PersonalInfoState(
      fullName: fullName ?? this.fullName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}

class PersonalInfoViewModel extends ChangeNotifier {
  final String initialCountryCode;
  PersonalInfoState _state = PersonalInfoState();
  PersonalInfoState get state => _state;

  PersonalInfoViewModel(this.initialCountryCode) {
    _initialize();
  }

  void _initialize() {
    if (initialCountryCode.isEmpty) return;
    try {
      final country =
          countries.firstWhere((country) => country.code == initialCountryCode);
      final phoneNumber = PhoneNumber(
        countryCode: country.code,
        dialCode: country.dialCode,
        maxLength: country.maxLength,
        minLength: country.minLength,
      );
      _updateState(phoneNumber: phoneNumber);
    } catch (e) {
      debugPrint('$initialCountryCode Error initializing phone: $e');
    }
  }

  void _updateState({
    Name? fullName,
    Date? dateOfBirth,
    PhoneNumber? phoneNumber,
  }) {
    _state = _state.copyWith(
      fullName: fullName,
      dateOfBirth: dateOfBirth,
      phoneNumber: phoneNumber,
    );
    notifyListeners();
  }

  void changeName(String value) {
    final newName = Name(value: value, isDirty: true);
    _updateState(fullName: newName);
  }

  void changePhone(String value) {
    final newPhone = _state.phoneNumber.copyWith(value: value);
    _updateState(phoneNumber: newPhone);
  }

  void changeDateOfBirth(String value) {
    final newDateOfBirth = Date(value: value, isDirty: true);
    _updateState(dateOfBirth: newDateOfBirth);
  }

  void setNewCountryCode(String code) {
    final country = countries.firstWhere((country) => country.code == code);
    final newPhone = PhoneNumber(
      value: _state.phoneNumber.value,
      countryCode: country.code,
      dialCode: country.dialCode,
      maxLength: country.maxLength,
      minLength: country.minLength,
      isDirty: _state.phoneNumber.isDirty,
    );
    _updateState(phoneNumber: newPhone);
  }
}
