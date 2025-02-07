import 'package:flutter/material.dart';
import 'package:jobs/UI/theme/theme.dart';

import 'package:jobs/UI/widgets/screen_builder/screen_builder.dart';
import 'package:jobs/UI/widgets/widgets.dart';
import 'package:jobs/gen/assets.gen.dart';

class ProfilePhotoScreen extends StatelessWidget {
  const ProfilePhotoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenBuilder(
      useSliverContent: true,
      overridePhysics: AlwaysScrollableScrollPhysics(),
      header: CustomHeader(text: 'Setup your Profile'),
      content: ProfilePhotoBody(),
      footer: ProfilePhotoBottom(),
    );
  }
}

class ProfilePhotoBody extends StatelessWidget {
  const ProfilePhotoBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          Container(
            margin: const EdgeInsets.only(top: 30),
            height: 16,
            child: LinearProgressIndicator(
              value: 0.3,
              color: purple400,
              backgroundColor: neutralColor500,
              borderRadius: BorderRadius.circular(13),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            child: Text(
              'Let’s Finish Setup by Adding Your Profile Photo.',
              style: AppTextStyles.displayTextSemibold,
            ),
          ),
          const ProfileAvatarFrame(),
          ConfirmButton(
            onPressed: (_) {},
            text: 'Choose From Gallary',
            iconPath: Assets.icons.gallaryIcon,
            width: 276,
            height: 52,
            left: 62,
            right: 62,
          )
        ]),
      ),
    );
  }
}

class ProfileAvatarFrame extends StatelessWidget {
  const ProfileAvatarFrame({
    this.image,
    super.key,
  });
  final Image? image;
  @override
  Widget build(BuildContext context) {
    final defaultImage = CustomIcon(
      size: 128,
      iconPath: Assets.icons.userIconFilled,
      iconColor: Colors.white,
    );
    return CircleAvatar(
      backgroundColor: primaryColor25,
      radius: 128,
      child: CircleAvatar(
          backgroundColor: primaryColor50,
          radius: 107,
          child: image ?? defaultImage),
    );
  }
}

class ProfilePhotoBottom extends StatelessWidget {
  const ProfilePhotoBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return ConfirmButton(
      text: 'Continue',
      onPressed: (context) {},
      top: 10,
      bottom: 16,
      left: 32,
      right: 32,
    );
  }
}
