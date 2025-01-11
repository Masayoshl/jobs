import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jobs/UI/screens/profile_setup/select_country/select_country_view_model.dart';
import 'package:jobs/UI/screens/profile_setup/select_country/widgets/country_tile.dart';
import 'package:jobs/UI/screens/profile_setup/select_country/widgets/search_bar.dart';
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
    final model = context.read<SelectCountryViewModel>();
    // return CustomSearchBar(
    //   onChanged: model.onSearchQueryChanged,
    // );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SearchBar(
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
        shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
        trailing: <Widget>[
          Tooltip(
            message: 'Seach by voice',
            child: IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                fit: BoxFit.none,
                Assets.icons.microphoneIcon,
                colorFilter:
                    const ColorFilter.mode(primaryColor, BlendMode.srcIn),
              ),
            ),
          )
        ],
        onChanged: model.onSearchQueryChanged,
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
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.errorMessage!),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => model.loadCountries(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
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
    //final model = context.read<SelectCountryViewModel>();
    return ConfirmButton(
      //state: model.state.buttonState,
      text: 'Continue',
      onPressed: (_) {},
      bottom: 0,
      left: 32,
      right: 32,
    );
  }
}
