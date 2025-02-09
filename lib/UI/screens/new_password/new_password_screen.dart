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
        footer: ButtonWidget());
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

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.read<NewPasswordViewModel>();
    final buttonState =
        context.select((NewPasswordViewModel value) => value.state.buttonState);

    return ConfirmButton(
      state: buttonState,
      bottom: 0,
      text: 'Continue',
      onPressed: (context) => model.onButtonPressed(context),
    );
  }
}
