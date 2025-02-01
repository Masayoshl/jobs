// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl_phone_field/countries.dart';

import 'package:jobs/domain/entity/entity.dart';
import 'package:jobs/domain/entity/fields/description.dart';
import 'package:jobs/domain/servi%D1%81es/profile_service.dart';

class CompanyInfoState {
  final Name name;
  final Email contactEmail;
  final PhoneNumber phoneNumber;
  final IndustryField industry;
  final Website website;
  final Description description;
  final Location location;
  final bool isLoading;
  final String? errorMessage;
  CompanyInfoState({
    Name? name,
    Email? contactEmail,
    Website? website,
    PhoneNumber? phoneNumber,
    IndustryField? industry,
    Description? description,
    Location? location,
    this.isLoading = true,
    this.errorMessage,
  })  : name = name ?? Name(),
        contactEmail = contactEmail ?? Email(),
        website = website ?? Website(),
        industry = industry ?? IndustryField(),
        description = description ?? Description(),
        phoneNumber = phoneNumber ??
            PhoneNumber(
              countryCode: '',
              dialCode: '',
              maxLength: 0,
              minLength: 0,
            ),
        location = location ?? Location();

  CompanyInfoState copyWith({
    Name? name,
    Email? contactEmail,
    PhoneNumber? phoneNumber,
    IndustryField? industry,
    Website? website,
    Description? description,
    Location? location,
    bool? isLoading,
    String? errorMessage,
  }) {
    return CompanyInfoState(
      name: name ?? this.name,
      contactEmail: contactEmail ?? this.contactEmail,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      industry: industry ?? this.industry,
      website: website ?? this.website,
      description: description ?? this.description,
      location: location ?? this.location,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class CompanyInfoViewModel extends ChangeNotifier {
  final String initialCountryCode;
  CompanyInfoState _state = CompanyInfoState();
  final _profileService = ProfileService();
  CompanyInfoState get state => _state;
  String get accountType => _profileService.accountType;

  CompanyInfoViewModel(this.initialCountryCode) {
    _initialize();
  }

  void _updateState({
    Name? name,
    Email? contactEmail,
    Website? website,
    PhoneNumber? phoneNumber,
    IndustryField? industry,
    Description? description,
    Location? location,
    bool? isLoading,
    String? errorMessage,
  }) {
    _state = _state.copyWith(
      name: name,
      contactEmail: contactEmail,
      website: website,
      phoneNumber: phoneNumber,
      industry: industry,
      description: description,
      location: location,
      isLoading: isLoading,
      errorMessage: errorMessage,
    );
    notifyListeners();
  }

  Future<void> _initialize() async {
    try {
      await _profileService.initialize();
      _initializeCountryCode();
    } finally {
      print(_profileService.accountType);
      _updateState(isLoading: false);
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
    _updateState(name: newName);
  }

  void changeEmail(String value) {
    final newEmail = Email(value: value, isDirty: true);
    _updateState(contactEmail: newEmail);
  }

  void changeWebsite(String value) {
    final newWebsite = Website(value: value, isDirty: true);
    _updateState(website: newWebsite);
  }

  void changeIndustry(String value) async {
    print('value: $value');
    final newIndustry = IndustryField(value: value, isDirty: true);
    _updateState(industry: newIndustry);
  }

  void changeDescription(String value) async {
    print('value: $value');
    final newDescription = Description(value: value, isDirty: true);
    _updateState(description: newDescription);
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

  void changeCity(String value) {
    final newCity = _state.location.copyWith(city: value);
    _updateState(location: newCity);
  }

  void changeAddress(String value) {
    final newAddress = _state.location.copyWith(address: value);
    _updateState(location: newAddress);
  }

  Future<void> onButtonPressed(BuildContext context) async {
    _state = _state.copyWith(isLoading: true);
    notifyListeners();

    try {
      await _profileService.setAccountInfo();
      _state = _state.copyWith(isLoading: false);
    } on ProfileServiceError catch (e) {
      _updateState(isLoading: false, errorMessage: e.message);
    } catch (e) {
      _updateState(isLoading: false, errorMessage: e.toString());
    }
  }
}
