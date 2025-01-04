import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jobs/UI/view_models/new_password/new_password_view_model.dart';
import 'package:jobs/UI/theme/theme.dart';
import 'package:jobs/UI/widgets/confirm_button.dart';
import 'package:jobs/UI/widgets/custom_checkbox.dart';
import 'package:jobs/UI/widgets/custom_header.dart';
import 'package:jobs/UI/widgets/screen_builder/screen_builder.dart';
import 'package:jobs/UI/widgets/text_field/password_text_field.dart';
import 'package:jobs/gen/assets.gen.dart';
import 'package:provider/provider.dart';

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenBuilder(
        header: CustomHeader(
          text: 'Create Password',
        ),
        content: Column(
          children: [
            ImageWidget(),
            NewPasswordForm(),
          ],
        ),
        footer: CongratOverlay());
  }
}

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 45),
      child: SvgPicture.asset(
        Assets.images.createPasswordImage,
        width: 250,
        height: 250,
      ),
    );
  }
}

class NewPasswordForm extends StatelessWidget {
  const NewPasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 36),
      width: 400,
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CreatePasswordTextWdget(),
          PasswordWidget(),
          ConfirmPasswordWidget(),
          CheckBoxWidget(),
        ],
      ),
    );
  }
}

class CreatePasswordTextWdget extends StatelessWidget {
  const CreatePasswordTextWdget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 28, left: 16),
      child: Text('Create Your New Password',
          style: AppTextStyles.textXXLMedium.copyWith(
            color: grayColor100,
          )),
    );
  }
}

class CheckBoxWidget extends StatelessWidget {
  const CheckBoxWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.read<NewPasswordViewModel>();
    final isChecked =
        context.select((NewPasswordViewModel value) => value.state.keepIn);
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: CustomCheckbox(
        text: 'Remember me',
        isChecked: isChecked,
        onTap: model.toggleKeepIn,
        left: 32,
      ),
    );
  }
}

class ConfirmPasswordWidget extends StatelessWidget {
  const ConfirmPasswordWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.read<NewPasswordViewModel>();
    final errorText = context.select((NewPasswordViewModel value) =>
        value.state.password.confirmErrorMessage);
    final isHavePasswordError = context.select(
        (NewPasswordViewModel value) => value.state.password.hasConfirmError);
    return PasswordTextField(
      hintText: 'Confirm Password',
      prefixIcon: Assets.icons.unlockIcon,
      onChanged: model.changeConfirmPassword,
      errorText: errorText,
      error: isHavePasswordError,
      left: 16,
      right: 16,
    );
  }
}

class PasswordWidget extends StatelessWidget {
  const PasswordWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.read<NewPasswordViewModel>();
    final errorText = context.select(
        (NewPasswordViewModel value) => value.state.password.errorMessage);
    final isHavePasswordError = context
        .select((NewPasswordViewModel value) => value.state.password.hasError);
    return PasswordTextField(
      hintText: 'Password',
      prefixIcon: Assets.icons.unlockIcon,
      onChanged: model.changePassword,
      errorText: errorText,
      error: isHavePasswordError,
      left: 16,
      right: 16,
    );
  }
}

class CongratOverlay extends StatefulWidget {
  const CongratOverlay({
    super.key,
  });

  @override
  State<CongratOverlay> createState() => _CongratOverlayState();
}

class _CongratOverlayState extends State<CongratOverlay> {
  final _controller = OverlayPortalController();
  @override
  Widget build(BuildContext context) {
    final model = context.read<NewPasswordViewModel>();
    return OverlayPortal(
      controller: _controller,
      overlayChildBuilder: (context) {
        return Positioned(
          top: 203,
          bottom: 144,
          left: 47,
          right: 47,
          child: BackdropFilter(
            filter: ImageFilter.blur(
                sigmaX: 4, sigmaY: 4, tileMode: TileMode.mirror),
            child: Container(
              width: 334,
              height: 501,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    spreadRadius: 1,
                    blurRadius: 1,
                    blurStyle: BlurStyle.normal,
                    offset: const Offset(0, 2),
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      Assets.images.createPasswordCongratImage,
                      width: 318,
                      height: 225,
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    const Text('Congratulations !!',
                        style: AppTextStyles.headlineXLMobileBold),
                    const SizedBox(
                      height: 20,
                    ),
                    Text('New Password has been generated successfully',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.textXLMedium
                            .copyWith(color: grayColor100)),
                    ConfirmButton(
                      backgroundColor: purple400,
                      width: 260,
                      height: 60,
                      left: 55,
                      right: 55,
                      top: 24,
                      bottom: 50,
                      onPressed: (context) =>
                          model.navToAboutUserScreen(context),
                      text: 'Continue',
                    )
                  ]),
            ),
          ),
        );
      },
      child: ButtonWidget(controller: _controller),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required OverlayPortalController controller,
  }) : _controller = controller;

  final OverlayPortalController _controller;

  @override
  Widget build(BuildContext context) {
    final model = context.read<NewPasswordViewModel>();
    final buttonState =
        context.select((NewPasswordViewModel value) => value.state.buttonState);

    return ConfirmButton(
      state: buttonState,
      bottom: 0,
      text: 'Continue',
      onPressed: (_) => model.onButtonPressed(_controller),
    );
  }
}
