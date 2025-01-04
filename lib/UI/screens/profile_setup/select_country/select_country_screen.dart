import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jobs/UI/screens/profile_setup/select_country/widgets/country_tile.dart';
import 'package:jobs/UI/theme/theme.dart';

import 'package:jobs/UI/widgets/confirm_button.dart';
import 'package:jobs/UI/widgets/custom_header.dart';
import 'package:jobs/UI/widgets/screen_builder/screen_builder.dart';
import 'package:jobs/gen/assets.gen.dart';

class SelectCountryScreen extends StatelessWidget {
  const SelectCountryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenBuilder(
      useSliverContent: true,
      overridePhysics: AlwaysScrollableScrollPhysics(),
      header: CustomHeader(text: 'Select Your Country'),
      searchField: SearchBar(),
      content: SelectCountryBody(),
      footer: SelectCountryBottom(),
    );
  }
}

class SelectCountryBody extends StatefulWidget {
  const SelectCountryBody({super.key});

  @override
  State<SelectCountryBody> createState() => _SelectCountryBodyState();
}

class _SelectCountryBodyState extends State<SelectCountryBody> {
  String? selectedCountryId;

  void _onCountrySelected(String countryId) {
    setState(() {
      selectedCountryId = countryId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CountryList(
      groupValue: selectedCountryId,
      onChanged: (countryId) => _onCountrySelected(countryId!),
    );
  }
}

class CountryList extends StatelessWidget {
  final String? groupValue;
  final ValueChanged<String?>? onChanged;

  const CountryList({
    super.key,
    this.groupValue,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: countries.length,
      itemBuilder: (context, index) {
        final country = countries[index];
        return CountryTile(
          countryId: country.id,
          countryName: country.name,
          flagAsset: country.flagAsset,
          selectedCountryId: groupValue,
          onChanged: onChanged,
        );
      },
    );
  }
}

// Модель данных для страны
class Country {
  final String id;
  final String name;
  final String flagAsset;

  const Country({
    required this.id,
    required this.name,
    required this.flagAsset,
  });
}

// Пример списка стран
final countries = [
  Country(
    id: 'IN',
    name: 'India',
    flagAsset: Assets.images.india,
  ),
  Country(id: 'ID', name: ' Iceland', flagAsset: Assets.images.iceland),
  Country(
    id: 'IR',
    name: 'Honduras',
    flagAsset: Assets.images.honduras,
  ),
  // ... другие страны
];

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(15);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Material(
        elevation: 2.0,
        borderRadius: borderRadius,
        child: TextField(
          decoration: InputDecoration(
            constraints: const BoxConstraints(
                minHeight: 65, maxHeight: 65, maxWidth: 400, minWidth: 400),
            border: OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: const BorderSide(color: Colors.white),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: const BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: const BorderSide(color: Colors.white),
            ),
            hintText: 'Search',
            hintStyle: AppTextStyles.textXLRegular.copyWith(color: grayColor25),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SvgPicture.asset(
                Assets.icons.searchIcon,
                fit: BoxFit.none,
              ),
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SvgPicture.asset(
                fit: BoxFit.none,
                Assets.icons.microphoneIcon,
                colorFilter:
                    const ColorFilter.mode(primaryColor, BlendMode.srcIn),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SelectCountryBottom extends StatelessWidget {
  const SelectCountryBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return ConfirmButton(
      // indicator: indicator,
      text: 'Continue',
      onPressed: (_) {},
      bottom: 0,
      left: 32,
      right: 32,
    );
  }
}
