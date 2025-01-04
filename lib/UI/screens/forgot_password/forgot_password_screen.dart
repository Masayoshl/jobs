import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:jobs/UI/view_models/forgot_password/forgot_password_view_model.dart';
import 'package:jobs/UI/theme/theme.dart';
import 'package:jobs/UI/widgets/confirm_button.dart';
import 'package:jobs/UI/widgets/custom_header.dart';
import 'package:jobs/UI/widgets/screen_builder/screen_builder.dart';
import 'package:jobs/UI/widgets/text_field/custom_text_field.dart';

import 'package:jobs/gen/assets.gen.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return const ScreenBuilder(
      header: CustomHeader(text: 'Forgot Password'),
      content: Column(children: [
        _ImageWidget(),
        AccountRestoreTextWidget(),
        _EmailWidget(),
      ]),
      footer: ButtonWidget(),
    );
  }
}

class _ImageWidget extends StatelessWidget {
  const _ImageWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 45),
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          SvgPicture.asset(
              width: 300, height: 300, Assets.images.forgotPasswordImage),
          const Text('Unlock Account',
              style: AppTextStyles.headlineXLMobileSemiBold),
        ],
      ),
    );
  }
}

class AccountRestoreTextWidget extends StatelessWidget {
  const AccountRestoreTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 27),
      child: Text(
          'Enter your email address and we will restore access to your account.',
          style: AppTextStyles.textXXLSemibold.copyWith(color: grayColor100)),
    );
  }
}

class _EmailWidget extends StatelessWidget {
  const _EmailWidget();

  @override
  Widget build(BuildContext context) {
    final model = context.read<ForgotPasswordViewModel>();
    final errorText = context.select(
        (ForgotPasswordViewModel value) => value.state.email.errorMessage);
    final isHaveEmailError = context
        .select((ForgotPasswordViewModel value) => value.state.email.hasError);
    return Padding(
      padding: const EdgeInsets.only(bottom: 74, top: 34),
      child: CustomTextField(
        hintText: 'Email',
        prefixIcon: Assets.icons.mailIcon,
        onChanged: model.changeEmail,
        errorText: errorText,
        error: isHaveEmailError,
      ),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.read<ForgotPasswordViewModel>();
    final buttonState = context
        .select((ForgotPasswordViewModel value) => value.state.buttonState);

    return ConfirmButton(
      state: buttonState,
      text: 'Continue',
      onPressed: (context) => model.onButtonPressed(context),
      bottom: 0,
    );
  }
}
