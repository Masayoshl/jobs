import 'package:flutter/material.dart';
import 'package:jobs/UI/view_models/one_time_password/one_time_password_view_model.dart';
import 'package:jobs/UI/router/main_router.dart';
import 'package:jobs/UI/theme/theme.dart';
import 'package:jobs/UI/widgets/confirm_button.dart';
import 'package:jobs/UI/widgets/custom_header.dart';
import 'package:jobs/UI/widgets/screen_builder/screen_builder.dart';

import 'package:provider/provider.dart';

import 'widgets/otp_text_field.dart';

class OneTimePasswordScreen extends StatelessWidget {
  const OneTimePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenBuilder(
      header: CustomHeader(text: 'Forgot Password'),
      content: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        DigitCodeTextWidget(),
        DescriptiveTextWidget(),
        ContactValueTextWidget(),
        CodeFormWidget(),
        OTPTimer(),
        ChangeContactWidget(),
      ]),
      footer: ButtonWidget(),
    );
  }
}

class CodeFormWidget extends StatelessWidget {
  const CodeFormWidget({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final model = context.read<OneTimePasswordViewModel>();
    final errorText = context.select(
        (OneTimePasswordViewModel value) => value.state.password.errorMessage);
    final isHaveError = context.select(
        (OneTimePasswordViewModel value) => value.state.password.hasError);
    return OTPTextField(
      onChanged: model.onChangePassword,
      isHaveError: isHaveError,
      errorText: errorText,
    );
  }
}

class DescriptiveTextWidget extends StatelessWidget {
  const DescriptiveTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: TextAlign.center,
      'Please Enter the code we have sent to',
      style: AppTextStyles.textXXLRegular.copyWith(
        color: grayColor100,
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
    final model = context.read<OneTimePasswordViewModel>();
    final buttonState = context
        .select((OneTimePasswordViewModel value) => value.state.buttonState);

    return ConfirmButton(
      state: buttonState,
      text: 'Continue',
      onPressed: (context) => model.onButtonPressed(context),
      bottom: 0,
    );
  }
}

class ChangeContactWidget extends StatelessWidget {
  const ChangeContactWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Navigator.of(context).pushNamed(MainRouterNames.forgotPassword),
      child: Text(
        'Change Email',
        style: AppTextStyles.textXXLBold.copyWith(color: primaryColor500),
      ),
    );
  }
}

class ContactValueTextWidget extends StatelessWidget {
  const ContactValueTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final useremail = context.read<OneTimePasswordViewModel>().state.userEmail;
    return Text(
      useremail,
      style: AppTextStyles.textXXLSemibold.copyWith(
        color: primaryColor500,
      ),
    );
  }
}

class DigitCodeTextWidget extends StatelessWidget {
  const DigitCodeTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 169, bottom: 20),
      child: Text(
        '4 Digit Code',
        style: AppTextStyles.headlineXLMobileSemiBold
            .copyWith(color: Colors.black),
      ),
    );
  }
}

class OTPTimer extends StatelessWidget {
  const OTPTimer({super.key});

  @override
  Widget build(BuildContext context) {
    return const _OTPTimerContent();
  }
}

class _OTPTimerContent extends StatelessWidget {
  const _OTPTimerContent();

  @override
  Widget build(BuildContext context) {
    final model = context.read<OneTimePasswordViewModel>();
    final remainingTime = context.select(
      (OneTimePasswordViewModel value) => value.state.remainingTime,
    );

    return Container(
      margin: const EdgeInsets.only(bottom: 32),
      child: remainingTime == 0
          ? _ResendButton(onTap: model.resendCode)
          : _TimerText(remainingTime: remainingTime),
    );
  }
}

class _ResendButton extends StatelessWidget {
  const _ResendButton({
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        'Resend',
        style: AppTextStyles.textXXLSemibold.copyWith(
          color: primaryColor500,
        ),
      ),
    );
  }
}

class _TimerText extends StatelessWidget {
  const _TimerText({
    required this.remainingTime,
  });

  final int remainingTime;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: 'Resend OTP in ',
            style: AppTextStyles.textXLSemibold.copyWith(
              color: grayColor25,
            ),
          ),
          TextSpan(
            text: '${remainingTime}s',
            style: AppTextStyles.textXXLSemibold.copyWith(
              color: primaryColor500,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
