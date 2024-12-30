import 'package:flutter/material.dart';
import 'package:jobs/UI/screens/auth/widgets/widgets.dart';
import 'package:jobs/UI/view_models/sign_up/sign_up_view_model.dart';
import 'package:jobs/gen/assets.gen.dart';
import 'package:provider/provider.dart';
import '../../../theme/theme.dart';
import '../../../widgets/screen_builder/screen_builder.dart';
import '../../../widgets/widgets.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenBuilder(
      bodyWidget: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScreenTitle(text: 'Sign up'),
          _SignUpForm(),
          SizedBox(height: 38),
          SocialLoginButtons(),
        ],
      ),
      bottomWidget: _NavTextWidget(),
    );
  }
}

class _SignUpForm extends StatelessWidget {
  const _SignUpForm();

  @override
  Widget build(BuildContext context) {
    return const SignForm(children: [
      _NameWidget(),
      _EmailWidget(),
      _PasswordWidget(),
      _KeepInWidget(),
      _RegistrationButton(),
    ]);
  }
}

class _NameWidget extends StatelessWidget {
  const _NameWidget();

  @override
  Widget build(BuildContext context) {
    final model = context.read<SignUpViewModel>();
    final errorText =
        context.select((SignUpViewModel value) => value.state.nameErrorMessage);
    final isHavePasswordError =
        context.select((SignUpViewModel value) => value.state.isNameHaveError);
    return CustomTextField(
      hintText: 'Name',
      prefixIcon: Assets.icons.mailIcon,
      onChanged: model.changeName,
      errorText: errorText,
      error: isHavePasswordError,
    );
  }
}

class _EmailWidget extends StatelessWidget {
  const _EmailWidget();

  @override
  Widget build(BuildContext context) {
    final model = context.read<SignUpViewModel>();
    final errorText = context
        .select((SignUpViewModel value) => value.state.emailErrorMessage);
    final isEmailHaveError =
        context.select((SignUpViewModel value) => value.state.isEmailHaveError);
    return CustomTextField(
      hintText: 'Email',
      prefixIcon: Assets.icons.mailIcon,
      onChanged: model.changeEmail,
      errorText: errorText,
      error: isEmailHaveError,
    );
  }
}

class _PasswordWidget extends StatelessWidget {
  const _PasswordWidget();

  @override
  Widget build(BuildContext context) {
    final model = context.read<SignUpViewModel>();
    final errorText = context
        .select((SignUpViewModel value) => value.state.passwordErrorMessage);
    final isPasswordHaveError = context
        .select((SignUpViewModel value) => value.state.isPasswordHaveError);
    return PasswordTextField(
      hintText: 'Password',
      prefixIcon: Assets.icons.unlockIcon,
      onChanged: model.changePassword,
      errorText: errorText,
      error: isPasswordHaveError,
    );
  }
}

class _KeepInWidget extends StatelessWidget {
  const _KeepInWidget();

  @override
  Widget build(BuildContext context) {
    final model = context.read<SignUpViewModel>();
    final isChecked =
        context.select((SignUpViewModel value) => value.state.keepIn);
    return CustomCheckbox(
      text: 'Remember Me',
      onTap: model.changeCheckBox,
      isChecked: isChecked,
    );
  }
}

class _RegistrationButton extends StatelessWidget {
  const _RegistrationButton();

  @override
  Widget build(BuildContext context) {
    final model = context.read<SignUpViewModel>();
    final authButtonState =
        context.select((SignUpViewModel value) => value.state.buttonState);
    final onPressed = authButtonState == ButtonState.canSubmit
        ? model.onAuthButtonPressed
        : null;
    final indicator = authButtonState == ButtonState.inProcess
        ? const CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 2,
          )
        : null;
    return ConfirmButton(
      indicator: indicator,
      text: 'Sign Up',
      onPressed: onPressed == null ? () {} : () => onPressed.call(context),
    );
  }
}

class _NavTextWidget extends StatelessWidget {
  const _NavTextWidget();

  @override
  Widget build(BuildContext context) {
    final model = context.read<SignUpViewModel>();
    return LoginPrompt(
        promptText: 'Already have an account ?',
        navigationText: ' Sign in',
        navigationTextStyle:
            AppTextStyles.textXXLSemibold.copyWith(color: purple700),
        onTap: () => model.navToSignInScreen(context));
  }
}
