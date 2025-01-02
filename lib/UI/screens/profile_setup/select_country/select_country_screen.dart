import 'package:flutter/material.dart';

import 'package:jobs/UI/widgets/confirm_button.dart';
import 'package:jobs/UI/widgets/custom_header.dart';
import 'package:jobs/UI/widgets/screen_builder/screen_builder.dart';

class SelectCountryScreen extends StatelessWidget {
  const SelectCountryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenBuilder(
      appBarWidget: CustomHeader(text: 'Setup Your Profile'),
      bodyWidget: SelectCountryBody(),
      bottomWidget: SelectCountryBottom(),
    );
  }
}

class SelectCountryBody extends StatelessWidget {
  const SelectCountryBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 200,
        ),
      ],
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
      onPressed: () {},
      bottom: 0,
      left: 32,
      right: 32,
    );
  }
}
