import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:jobs/UI/common/button_state.dart';
import 'package:jobs/domain/entity/country.dart';

class SelectCountryState {
  final List<Country> allCountries;
  final List<Country> filteredCountries;
  final Country? selectedCountry;
  final String searchQuery;
  final String? errorMessage;
  final bool isLoading;

  SelectCountryState({
    required this.allCountries,
    required this.filteredCountries,
    this.selectedCountry,
    this.searchQuery = '',
    this.errorMessage,
    this.isLoading = false,
  });

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
  }) {
    return SelectCountryState(
      allCountries: allCountries ?? this.allCountries,
      filteredCountries: filteredCountries ?? this.filteredCountries,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      searchQuery: searchQuery ?? this.searchQuery,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class SelectCountryViewModel extends ChangeNotifier {
  SelectCountryState _state;
  var _searchDebouncer = Timer(const Duration(milliseconds: 300), () {});

  SelectCountryViewModel()
      : _state = SelectCountryState(
          allCountries: [],
          filteredCountries: [],
          isLoading: true,
        ) {
    _initializeCountries();
  }

  SelectCountryState get state => _state;

  Future<void> _initializeCountries() async {
    try {
      final countries = await loadCountries();
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

  Future<List<Country>> loadCountries() async {
    final jsonString = await rootBundle.loadString('assets/data/country.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList
        .map((json) => Country.fromJson(json))
        .where((country) => country.iso)
        .toList();
  }

  void onSearchQueryChanged(String query) {
    _searchDebouncer.cancel();
    _searchDebouncer = Timer(const Duration(milliseconds: 300), () {
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
    _updateState(selectedCountry: country);
  }

  Future<void> onButtonPressed() async {
    if (_state.buttonState != ButtonState.enabled) return;

    _updateState(isLoading: true);
    try {
      // Здесь можно добавить логику сохранения выбранной страны
      // await _repository.saveSelectedCountry(_state.selectedCountry!);

      // Навигация к следующему экрану
    } catch (e) {
      _updateState(
        errorMessage: 'Failed to save country: ${e.toString()}',
        isLoading: false,
      );
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

  @override
  void dispose() {
    _searchDebouncer.cancel();
    super.dispose();
  }
}
