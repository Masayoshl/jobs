import 'package:flutter/material.dart';
import 'package:jobs/UI/screens/profile_setup/industry/industry_view_model.dart';
import 'package:jobs/UI/screens/profile_setup/industry/widgets/industry_tile.dart';
import 'package:jobs/UI/screens/profile_setup/select_country/widgets/search_by_voice_bar.dart';
import 'package:jobs/UI/theme/theme.dart';
import 'package:jobs/UI/widgets/screen_builder/screen_builder.dart';
import 'package:jobs/UI/widgets/widgets.dart';
import 'package:provider/provider.dart';

class IndustryScreen extends StatelessWidget {
  const IndustryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenBuilder(
      useSliverContent: true,
      overridePhysics: AlwaysScrollableScrollPhysics(),
      header: CustomHeader(
        text: 'Industry',
      ),
      searchField: Search(),
      content: IndustryBody(),
      footer: IndustryBottom(),
    );
  }
}

class Search extends StatelessWidget {
  const Search({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.read<IndustryViewModel>();
    // ignore: unused_local_variable
    final isListening = context.select(
        (IndustryViewModel model) => model.voiceSearchController.isListening);
    return SearchByVoiceField(
      voiceController: model.voiceSearchController,
      searchController: model.state.searchController,
      onSearchQueryChanged: model.onSearchQueryChanged,
    );
  }
}

class IndustryBody extends StatelessWidget {
  const IndustryBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<IndustryViewModel>(
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
                  onPressed: () => model.setIndustries(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }
        if (state.filteredIndustries.isEmpty) {
          return const SliverFillRemaining(
            child: EmptySearchState(),
          );
        }
        return SliverList.builder(
          itemCount: state.filteredIndustries.length,
          itemBuilder: (context, index) {
            final industry = state.filteredIndustries[index];
            final selectedIndustry = state.selectedIndustry?.id.toString();
            return IndustryTile(
              industry: industry,
              selectedIndustryId: selectedIndustry,
              onChanged: ((value) => model.selectedIndustry(value)),
            );
          },
        );
      },
    );
  }
}

class IndustryBottom extends StatelessWidget {
  const IndustryBottom({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<IndustryViewModel>();
    final buttonState =
        context.select((IndustryViewModel value) => value.state.buttonState);
    return ConfirmButton(
      state: buttonState,
      text: 'Save',
      onPressed: (context) => model.onButtonPressed(context),
      bottom: 0,
      left: 32,
      right: 32,
    );
  }
}
