import 'package:flutter/material.dart';
import 'package:jobs/UI/forgot_password/view_model/one_time_password_view_model/one_time_password_view_model.dart';
import 'package:jobs/UI/router/main_router.dart';
import 'package:jobs/UI/theme/theme.dart';
import 'package:jobs/UI/widgets/confirm_button.dart';
import 'package:jobs/UI/widgets/custom_header.dart';
import 'package:jobs/UI/widgets/screen_builder/screen_builder.dart';
import 'package:jobs/domain/enums/button_state.dart';
import 'package:provider/provider.dart';

import '../widgets/widgets.dart';

class OneTimePasswordScreen extends StatelessWidget {
  const OneTimePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenBuilder(
      appBarWidget: CustomHeader(text: 'Forgot Password'),
      bodyWidget:
          Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        DigitCodeTextWidget(),
        DescriptiveTextWidget(),
        ContactValueTextWidget(),
        CodeFormWidget(),
        OTPTimer(),
        ChangeContactWidget(),
      ]),
      bottomWidget: ButtonWidget(),
    );
  }
}

class CodeFormWidget extends StatelessWidget {
  const CodeFormWidget({
    super.key,
  });
//ToDO
  @override
  Widget build(BuildContext context) {
    final model = context.read<OneTimePasswordViewModel>();
    final errorText = context.select(
        (OneTimePasswordViewModel value) => value.state.codeErrorMessage);
    final isHaveError = context.select(
        (OneTimePasswordViewModel value) => value.state.isCodeHaveError);
    return OTPTextField(
      onChanged: model.onChangeCode,
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
    final onPressed =
        buttonState == ButtonState.canSubmit ? model.onButtonPressed : null;
    final indicator = buttonState == ButtonState.inProcess
        ? const CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 2,
          )
        : null;
    return ConfirmButton(
      indicator: indicator,
      text: 'Continue',
      onPressed: onPressed == null ? () {} : () => onPressed.call(context),
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
        style: AppTextStyles.textXXLBold.copyWith(color: primaryColor),
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
        color: primaryColor,
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
          color: primaryColor,
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
              color: primaryColor,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
