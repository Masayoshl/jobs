import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jobs/UI/screens/profile_setup/profile_setup_view_model.dart';
import 'package:jobs/UI/screens/profile_setup/widgets/skip_text_button.dart';

import 'package:jobs/UI/theme/theme.dart';
import 'package:jobs/UI/widgets/confirm_button.dart';
import 'package:jobs/UI/widgets/custom_header.dart';
import 'package:jobs/UI/widgets/screen_builder/screen_builder.dart';
import 'package:jobs/gen/assets.gen.dart';
import 'package:provider/provider.dart';

class ProfileSetupScreen extends StatelessWidget {
  const ProfileSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenBuilder(
      header: CustomHeader(text: 'Setup Your Profile'),
      content: ProfileSetupBody(),
      footer: ProfileSetupBottom(),
    );
  }
}

class ProfileSetupBody extends StatelessWidget {
  const ProfileSetupBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 20, bottom: 45, left: 16, right: 16),
          child: Text(
            'Please Complete Your Profile so We can Deliver you the best Experience',
            style: AppTextStyles.textXXLRegular.copyWith(color: grayColor25),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: SvgPicture.asset(
            Assets.images.profileSetupImage,
          ),
        ),
      ],
    );
  }
}

class ProfileSetupBottom extends StatelessWidget {
  const ProfileSetupBottom({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<ProfileSetupViewModel>();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ConfirmButton(
          text: 'Continue',
          onPressed: (_) => model.navToAccountTypeScreeen(context),
          top: 10,
          bottom: 16,
          left: 32,
          right: 32,
        ),
        SkipTextButton(onPressed: () {}),
        const SizedBox(
          height: 22,
        ),
      ],
    );
  }
}
