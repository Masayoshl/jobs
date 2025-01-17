import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jobs/UI/screens/profile_setup/select_country/select_country_view_model.dart';
import 'package:jobs/UI/screens/profile_setup/select_country/widgets/country_tile.dart';

import 'package:jobs/UI/theme/theme.dart';
import 'package:jobs/UI/widgets/confirm_button.dart';
import 'package:jobs/UI/widgets/custom_header.dart';
import 'package:jobs/UI/widgets/screen_builder/screen_builder.dart';
import 'package:jobs/gen/assets.gen.dart';
import 'package:provider/provider.dart';

class SelectCountryScreen extends StatelessWidget {
  const SelectCountryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenBuilder(
      useSliverContent: true,
      overridePhysics: AlwaysScrollableScrollPhysics(),
      header: CustomHeader(text: 'Select Your Country'),
      searchField: Search(),
      content: SelectCountryBody(),
      footer: SelectCountryBottom(),
    );
  }
}

class Search extends StatelessWidget {
  const Search({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Consumer<SelectCountryViewModel>(
        builder: (context, model, _) {
          return SearchBar(
            controller: model.state.searchController,
            hintText: 'Search',
            hintStyle: WidgetStatePropertyAll(
                AppTextStyles.textXLRegular.copyWith(color: grayColor25)),
            backgroundColor: const WidgetStatePropertyAll(Colors.white),
            leading: SvgPicture.asset(
              Assets.icons.searchIcon,
              fit: BoxFit.none,
            ),
            shadowColor: const WidgetStatePropertyAll(Colors.black),
            elevation: const WidgetStatePropertyAll(2.0),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16))),
            trailing: <Widget>[
              Tooltip(
                message: 'Search by voice',
                child: IconButton(
                  onPressed: model.toggleListening,
                  isSelected: model.state.isListening,
                  icon: SvgPicture.asset(
                    fit: BoxFit.none,
                    Assets.icons.microphoneIcon,
                    colorFilter: const ColorFilter.mode(
                      primaryColor500,
                      BlendMode.srcIn,
                    ),
                  ),
                  selectedIcon: const Icon(
                    color: errorColor500,
                    Icons.stop_circle_rounded,
                    size: 32,
                  ),
                ),
              )
            ],
            onChanged: model.onSearchQueryChanged,
          );
        },
      ),
    );
  }
}

class SelectCountryBody extends StatelessWidget {
  const SelectCountryBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SelectCountryViewModel>(
      builder: (context, model, _) {
        final state = model.state;

        if (state.isLoading) {
          return const SliverFillRemaining(
            child: Center(child: CircularProgressIndicator()),
          );
        }
        if (state.errorMessage != null) {
          return SliverFillRemaining(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    state.errorMessage!,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.textXLSemibold,
                  ),
                ),
                ElevatedButton(
                  onPressed: () => model.setCountries(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }
        return SliverList.builder(
          itemCount: state.filteredCountries.length,
          itemBuilder: (context, index) {
            final country = state.filteredCountries[index];
            return CountryTile(
              country: country,
              selectedCountryId: state.selectedCountry?.code ?? null,
              onChanged: (value) => model.selectCountry(value),
            );
          },
        );
      },
    );
  }
}

class SelectCountryBottom extends StatelessWidget {
  const SelectCountryBottom({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<SelectCountryViewModel>();
    final buttonState = context
        .select((SelectCountryViewModel value) => value.state.buttonState);
    return ConfirmButton(
      state: buttonState,
      text: 'Continue',
      onPressed: (context) => model.onButtonPressed(context),
      bottom: 0,
      left: 32,
      right: 32,
    );
  }
}
