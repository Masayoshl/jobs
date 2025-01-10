import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jobs/UI/screens/profile_setup/select_country/select_country_view_model.dart';
import 'package:jobs/UI/screens/profile_setup/select_country/widgets/country_tile.dart';
import 'package:jobs/UI/theme/theme.dart';

import 'package:jobs/UI/widgets/confirm_button.dart';
import 'package:jobs/UI/widgets/custom_header.dart';
import 'package:jobs/UI/widgets/screen_builder/screen_builder.dart';
import 'package:jobs/domain/entity/country.dart';
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
      searchField: SearchBar(),
      content: SelectCountryBody(),
      footer: SelectCountryBottom(),
    );
  }
}

class SelectCountryBody extends StatelessWidget {
  const SelectCountryBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SelectCountryViewModel>(
      builder: (context, viewModel, _) {
        final state = viewModel.state;

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
                    onPressed: () => viewModel.loadCountries(),
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
              onChanged: (value) => viewModel.selectCountry(value),
            );
          },
        );
      },
    );
  }
}

// class _SelectCountryBodyState extends State<SelectCountryBody> {
//   // @override
//   // Widget build(BuildContext context) {
//   //   final model = context.read<SelectCountryViewModel>();
//   //   final state = model.state;
//   //   if (model.state.isLoading) {
//   //     return const SliverFillRemaining(
//   //       child: Center(
//   //           child: CircularProgressIndicator(
//   //         strokeWidth: 3,
//   //       )),
//   //     );
//   //   }
//   //   return SliverList.builder(
//   //     itemCount: state.allCountries.length,
//   //     itemBuilder: (context, index) {
//   //       final country = state.allCountries[index];
//   //       return CountryTile(
//   //         country: country,
//   //         //selectedCountryId: state.selectedCountry!.code,
//   //       );
//   //     },
//   //   );
//   // }

// }

class CountryList extends StatelessWidget {
  final List<Country> countries;
  final String? selectedValue;
  final ValueChanged<Country>? onChanged;

  const CountryList({
    super.key,
    required this.countries,
    this.selectedValue,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.shrink();
  }
}

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
      //state: ButtonState.disabled,
      text: 'Continue',
      onPressed: (_) {},
      bottom: 0,
      left: 32,
      right: 32,
    );
  }
}
