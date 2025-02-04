import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:jobs/UI/common/button_state.dart';
import 'package:jobs/UI/router/main_router.dart';
import 'package:jobs/UI/screens/profile_setup/common/account_type_enum.dart';

import 'package:jobs/domain/controllers/voice_search_controller.dart';
import 'package:jobs/domain/entity/country.dart';
import 'package:jobs/domain/servi%D1%81es/profile_service.dart';

class SelectCountryState {
  final List<Country> allCountries;
  final List<Country> filteredCountries;
  final Country? selectedCountry;
  final String searchQuery;
  final String? errorMessage;
  final bool isLoading;

  final TextEditingController searchController;

  SelectCountryState({
    required this.allCountries,
    required this.filteredCountries,
    this.selectedCountry,
    this.searchQuery = '',
    this.errorMessage,
    this.isLoading = false,
    TextEditingController? searchController,
  }) : searchController = searchController ?? TextEditingController();

  ButtonState get buttonState {
    if (isLoading) return ButtonState.inProcess;
    if (selectedCountry == null) return ButtonState.disabled;
    return ButtonState.enabled;
  }

  SelectCountryState copyWith({
    List<Country>? allCountries,
    List<Country>? filteredCountries,
    Country? selectedCountry,
    String? searchQuery,
    String? errorMessage,
    bool? isLoading,
    TextEditingController? searchController,
  }) {
    return SelectCountryState(
      allCountries: allCountries ?? this.allCountries,
      filteredCountries: filteredCountries ?? this.filteredCountries,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      searchQuery: searchQuery ?? this.searchQuery,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
      searchController: searchController ?? this.searchController,
    );
  }
}

class SelectCountryViewModel extends ChangeNotifier {
  SelectCountryState _state;
  var _searchDebouncer = Timer(const Duration(milliseconds: 500), () {});
  final _profileService = ProfileService();

  late final VoiceSearchController voiceSearchController;
  SelectCountryViewModel()
      : _state = SelectCountryState(
          allCountries: [],
          filteredCountries: [],
          isLoading: true,
        ) {
    voiceSearchController = VoiceSearchController(
      searchController: _state.searchController,
      onSearchQueryChanged: onSearchQueryChanged,
      onStateChanged: notifyListeners,
    );
    setCountries();
    _initializeAccountType();
  }

  SelectCountryState get state => _state;

  Future<void> _initializeAccountType() async {
    try {
      await _profileService.initialize();
    } finally {
      print(_profileService.accountType);
    }
  }

  Future<void> setCountries() async {
    try {
      final countries = await _loadCountries();
      _updateState(
        allCountries: countries,
        filteredCountries: countries,
        isLoading: false,
      );
    } catch (e) {
      _updateState(
        errorMessage: 'Failed to load countries: ${e.toString()}',
        isLoading: false,
      );
    }
  }

  Future<List<Country>> _loadCountries() async {
    final jsonString =
        await rootBundle.loadString('assets/data/countries.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList
        .map((json) => Country.fromJson(json))
        .where((country) => country.iso)
        .toList();
  }

  void onSearchQueryChanged(String query) {
    _searchDebouncer.cancel();
    _searchDebouncer = Timer(const Duration(milliseconds: 500), () {
      _updateState(
        searchQuery: query,
        filteredCountries: _filterCountries(query),
      );
    });
  }

  List<Country> _filterCountries(String query) {
    if (query.isEmpty) return _state.allCountries;

    final lowercaseQuery = query.toLowerCase();
    return _state.allCountries.where((country) {
      return country.name.toLowerCase().contains(lowercaseQuery);
    }).toList();
  }

  void selectCountry(Country country) {
    if (country == state.selectedCountry) return;
    _updateState(selectedCountry: country);
  }

  void navToPersonalInfoScreen(BuildContext context) {
    Navigator.of(context).pushNamed(MainRouterNames.personalInfo,
        arguments: {'countryCode': state.selectedCountry!.code});
  }

  void navToCompanyInfoScreen(BuildContext context) {
    Navigator.of(context).pushNamed(MainRouterNames.companyInfo,
        arguments: {'countryCode': state.selectedCountry!.code});
  }

  Future<void> onButtonPressed(BuildContext context) async {
    // if (_state.accountType == null) return;

    _state = _state.copyWith(isLoading: true);
    notifyListeners();

    try {
      await _profileService.setAccountCountry();
      _state = _state.copyWith(isLoading: false);
      final accountType = _profileService.accountType;
      if (accountType == AccountType.employee.title) {
        navToPersonalInfoScreen(context);
      } else {
        navToCompanyInfoScreen(context);
      }
    } on ProfileServiceError catch (e) {
      _state = _state.copyWith(
        errorMessage: e.message,
        isLoading: false,
      );
      debugPrint(_state.errorMessage);
    } catch (e) {
      _state = _state.copyWith(
        errorMessage: e.toString(),
        isLoading: false,
      );
    } finally {
      notifyListeners();
      //debugPrint(_state.errorMessage);
    }
  }

  void _updateState({
    List<Country>? allCountries,
    List<Country>? filteredCountries,
    Country? selectedCountry,
    String? searchQuery,
    String? errorMessage,
    bool? isLoading,
  }) {
    _state = _state.copyWith(
      allCountries: allCountries,
      filteredCountries: filteredCountries,
      selectedCountry: selectedCountry,
      searchQuery: searchQuery,
      errorMessage: errorMessage,
      isLoading: isLoading,
    );
    notifyListeners();
  }

  void dispose() {
    _searchDebouncer.cancel();
    _state.searchController.dispose();
    voiceSearchController.dispose();
    super.dispose();
  }
}
