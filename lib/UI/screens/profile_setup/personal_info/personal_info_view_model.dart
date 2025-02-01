// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl_phone_field/countries.dart';

import 'package:jobs/domain/entity/entity.dart';
import 'package:jobs/domain/servi%D1%81es/profile_service.dart';

class PersonalInfoState {
  final Name fullName;
  final Date dateOfBirth;
  final PhoneNumber phoneNumber;
  final Gender gender;
  final Location location;
  PersonalInfoState({
    Name? fullName,
    Date? dateOfBirth,
    PhoneNumber? phoneNumber,
    Gender? gender,
    Location? location,
  })  : fullName = fullName ?? Name(),
        dateOfBirth = dateOfBirth ?? Date(),
        phoneNumber = phoneNumber ??
            PhoneNumber(
              countryCode: '',
              dialCode: '',
              maxLength: 0,
              minLength: 0,
            ),
        gender = gender ?? Gender(),
        location = location ?? Location();

  PersonalInfoState copyWith({
    Name? fullName,
    Date? dateOfBirth,
    PhoneNumber? phoneNumber,
    Gender? gender,
    Location? location,
  }) {
    return PersonalInfoState(
      fullName: fullName ?? this.fullName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      gender: gender ?? this.gender,
      location: location ?? this.location,
    );
  }
}

class PersonalInfoViewModel extends ChangeNotifier {
  final String initialCountryCode;
  PersonalInfoState _state = PersonalInfoState();
  final _profileService = ProfileService();
  PersonalInfoState get state => _state;
  String get accountType => _profileService.accountType;
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  PersonalInfoViewModel(this.initialCountryCode) {
    _initialize();
  }

  void _updateState({
    Name? fullName,
    Date? dateOfBirth,
    PhoneNumber? phoneNumber,
    Gender? gender,
    Location? location,
  }) {
    _state = _state.copyWith(
      fullName: fullName,
      dateOfBirth: dateOfBirth,
      phoneNumber: phoneNumber,
      gender: gender,
      location: location,
    );
    notifyListeners();
  }

  Future<void> _initialize() async {
    try {
      await _profileService.initialize();
      _initializeCountryCode();
    } finally {
      print(_profileService.accountType);
      _isLoading = false;
      notifyListeners();
    }
  }

  void _initializeCountryCode() {
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

  void changeName(String value) {
    final newName = Name(value: value, isDirty: true);
    _updateState(fullName: newName);
  }

  void changePhone(String value) {
    final newPhone = _state.phoneNumber.copyWith(value: value);

    _updateState(phoneNumber: newPhone);
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

  void changeDateOfBirth(String value) {
    final newDateOfBirth = Date(value: value, isDirty: true);
    _updateState(dateOfBirth: newDateOfBirth);
  }

  void changeGender(String? value) {
    final newGender = Gender(value: value, isDirty: true);
    _updateState(gender: newGender);
  }

  void changeCity(String value) {
    final newCity = _state.location.copyWith(city: value);
    _updateState(location: newCity);
  }

  void changeAddress(String value) {
    final newAddress = _state.location.copyWith(address: value);
    _updateState(location: newAddress);
  }

  void changePostalCode(String value) {
    final newPostalCode = _state.location.copyWith(postalCode: value);
    _updateState(location: newPostalCode);
  }
}
