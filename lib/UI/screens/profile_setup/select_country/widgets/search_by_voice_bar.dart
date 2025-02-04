import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:jobs/UI/theme/theme.dart';
import 'package:jobs/domain/controllers/voice_search_controller.dart';

import 'package:jobs/gen/assets.gen.dart';

class SearchByVoiceField extends StatelessWidget {
  final VoiceSearchController voiceController;
  final void Function(String) onSearchQueryChanged;
  final TextEditingController searchController;

  const SearchByVoiceField({
    super.key,
    required this.voiceController,
    required this.onSearchQueryChanged,
    required this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SearchBar(
        controller: searchController,
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
            message: 'Search by voice',
            child: IconButton(
              onPressed: voiceController.toggleListening,
              isSelected: voiceController.isListening,
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
        onChanged: onSearchQueryChanged,
      ),
    );
  }
}
