import 'package:flutter/material.dart';

import 'package:jobs/UI/screens/profile_setup/profile_photo/profile_photo_view_model.dart';
import 'package:jobs/UI/screens/profile_setup/profile_photo/widgets/profile_avatar_frame.dart';
import 'package:jobs/UI/theme/theme.dart';
import 'package:jobs/UI/widgets/widgets.dart';
import 'package:jobs/gen/assets.gen.dart';
import 'package:provider/provider.dart';

class ProfilePhotoScreen extends StatelessWidget {
  const ProfilePhotoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenBuilder(
      useSliverContent: true,
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
    return Consumer<ProfilePhotoViewModel>(
      builder: (context, model, _) {
        final state = model.state;
        if (state.isGalleryLoading || state.isCameraLoading) {
          return const SliverFillRemaining(
            child: Center(child: CircularProgressIndicator()),
          );
        } else {}
        return SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverList(
            delegate: SliverChildListDelegate(const [
              StepProgressIndicator(
                totalSteps: 5,
                currentStep: 4,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                child: Text(
                  'Let’s Finish Setup by Adding Your Profile Photo.',
                  style: AppTextStyles.displayTextSemibold,
                ),
              ),
              ProfilePhoto(),
              CameraButton(),
              GalleryButton(),
            ]),
          ),
        );
      },
    );
  }
}

class ProfilePhoto extends StatelessWidget {
  const ProfilePhoto({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.read<ProfilePhotoViewModel>();
    final file =
        context.select((ProfilePhotoViewModel model) => model.state.file);

    return ProfileAvatarFrame(
      file: file,
      onTap: () => model.onImagePressed(),
    );
  }
}

class CameraButton extends StatelessWidget {
  const CameraButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.read<ProfilePhotoViewModel>();
    final buttonState = context
        .select((ProfilePhotoViewModel model) => model.state.cameraButtonState);
    return ConfirmButton(
      state: buttonState,
      onPressed: (_) => model.onCameraButtonPressed(),
      text: 'Camera',
      iconPath: Assets.icons.cameraIcon,
      width: 167,
      height: 52,
      left: 100,
      right: 100,
      bottom: 24,
    );
  }
}

class GalleryButton extends StatelessWidget {
  const GalleryButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.read<ProfilePhotoViewModel>();
    final buttonState = context.select(
        (ProfilePhotoViewModel model) => model.state.galleryButtonState);
    return ConfirmButton(
      state: buttonState,
      onPressed: (_) => model.onGalleryButtonPressed(),
      text: 'Choose From Gallary',
      iconPath: Assets.icons.gallaryIcon,
      width: 276,
      height: 52,
      top: 0,
      left: 62,
      right: 62,
    );
  }
}

class ProfilePhotoBottom extends StatelessWidget {
  const ProfilePhotoBottom({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<ProfilePhotoViewModel>();
    final buttonState = context.select(
        (ProfilePhotoViewModel model) => model.state.primaryButtonState);
    return ConfirmButton(
      state: buttonState,
      text: 'Continue',
      onPressed: (context) => model.onPrimaryButtonPressed(context),
      top: 10,
      bottom: 16,
      left: 32,
      right: 32,
    );
  }
}
