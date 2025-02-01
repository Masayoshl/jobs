// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jobs/UI/common/button_state.dart';

import 'package:jobs/domain/entity/industry.dart';

class IndustryState {
  final List<Industry> allIndustries;
  final List<Industry> filteredIndustries;
  final Industry? selectedIndustry;
  final bool isLoading;
  final String? errorMessage;
  final TextEditingController searchController;
  IndustryState({
    required this.allIndustries,
    required this.filteredIndustries,
    this.selectedIndustry,
    this.isLoading = false,
    this.errorMessage,
    TextEditingController? searchController,
  }) : searchController = searchController ?? TextEditingController();

  ButtonState get buttonState {
    if (isLoading) return ButtonState.inProcess;
    if (selectedIndustry == null) return ButtonState.disabled;
    return ButtonState.enabled;
  }

  IndustryState copyWith({
    List<Industry>? allIndustries,
    List<Industry>? filteredIndustries,
    Industry? selectedIndustry,
    bool? isLoading,
    String? errorMessage,
    TextEditingController? searchController,
  }) {
    return IndustryState(
      allIndustries: allIndustries ?? this.allIndustries,
      filteredIndustries: filteredIndustries ?? this.filteredIndustries,
      selectedIndustry: selectedIndustry ?? this.selectedIndustry,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      searchController: searchController ?? this.searchController,
    );
  }
}

class IndustryViewModel extends ChangeNotifier {
  final Industry? initialIndustry;
  IndustryState _state;
  IndustryState get state => _state;

  IndustryViewModel(this.initialIndustry)
      : _state = IndustryState(
          allIndustries: [],
          filteredIndustries: [],
          isLoading: true,
          selectedIndustry: initialIndustry,
        ) {
    setIndustries();
  }

  void selectedIndustry(Industry industry) {
    if (industry == state.selectedIndustry) return;
    _updateState(selectedIndustry: industry);
  }

  void _updateState({
    List<Industry>? allIndustries,
    List<Industry>? filteredIndustries,
    Industry? selectedIndustry,
    bool? isLoading,
    String? errorMessage,
  }) {
    _state = _state.copyWith(
      allIndustries: allIndustries,
      filteredIndustries: filteredIndustries,
      selectedIndustry: selectedIndustry,
      isLoading: isLoading,
      errorMessage: errorMessage,
    );
    notifyListeners();
  }

  Future<List<Industry>> _loadIndustries() async {
    final jsonString =
        await rootBundle.loadString('assets/data/industries.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => Industry.fromMap(json)).toList();
  }

  Future<void> setIndustries() async {
    try {
      final industries = await _loadIndustries();
      _updateState(
        allIndustries: industries,
        filteredIndustries: industries,
        isLoading: false,
      );
    } catch (e) {
      _updateState(
        errorMessage: 'Failed to load industries: ${e.toString()}',
        isLoading: false,
      );
    }
  }

  void onSearchQueryChanged(String query) {}

  void onButtonPressed(BuildContext context) async {
    Navigator.of(context).pop(_state.selectedIndustry);
  }
}
