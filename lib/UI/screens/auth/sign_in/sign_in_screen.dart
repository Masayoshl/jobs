import 'package:flutter/material.dart';
import 'package:jobs/UI/screens/auth/widgets/auth_form.dart';
import 'package:jobs/UI/view_models/sign_in/sign_in_view_model.dart';
import 'package:jobs/UI/screens/auth/sign_in/widgets/forgot_password.dart';
import 'package:jobs/UI/screens/auth/widgets/login_prompt.dart';
import 'package:jobs/UI/screens/auth/widgets/screen_title.dart';
import 'package:jobs/UI/screens/auth/widgets/social_buttons.dart';
import 'package:jobs/UI/widgets/confirm_button.dart';
import 'package:jobs/UI/widgets/custom_checkbox.dart';
import 'package:jobs/UI/widgets/screen_builder/screen_builder.dart';
import 'package:jobs/UI/widgets/text_field/custom_text_field.dart';
import 'package:jobs/UI/widgets/text_field/password_text_field.dart';
import 'package:jobs/gen/assets.gen.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<SignInViewModel>();

    return ScreenBuilder(
      content: Column(
        children: [
          const ScreenTitle(text: 'Sign in'),
          const SignInForm(),
          ForgotPassword(onTap: () => model.navToForgotPasswordScreen(context)),
          const SocialLoginButtons(),
        ],
      ),
      footer: const NavTextWidget(),
    );
  }
}

class SignInForm extends StatelessWidget {
  const SignInForm({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return const SignForm(children: [
      EmailWidget(),
      PasswordWidget(),
      CheckBoxWidget(),
      AuthButton(),
    ]);
  }
}

class EmailWidget extends StatelessWidget {
  const EmailWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.read<SignInViewModel>();
    final errorText = context
        .select((SignInViewModel value) => value.state.email.errorMessage);
    final hasError =
        context.select((SignInViewModel value) => value.state.email.hasError);
    return CustomTextField(
      hintText: 'Email',
      prefixIcon: Assets.icons.mailIcon,
      onChanged: model.changeEmail,
      errorText: errorText,
      error: hasError,
    );
  }
}

class PasswordWidget extends StatelessWidget {
  const PasswordWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.read<SignInViewModel>();
    final errorText = context
        .select((SignInViewModel value) => value.state.password.errorMessage);
    final hasError = context
        .select((SignInViewModel value) => value.state.password.hasError);

    return PasswordTextField(
      hintText: 'Password',
      prefixIcon: Assets.icons.unlockIcon,
      //ffixIcon: Assets.icons.hideIcon,
      onChanged: model.changePassword,
      errorText: errorText,
      error: hasError,
    );
  }
}

class CheckBoxWidget extends StatelessWidget {
  const CheckBoxWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.read<SignInViewModel>();
    final isChecked =
        context.select((SignInViewModel value) => value.state.keepIn);
    return CustomCheckbox(
      text: 'Keep me signed in',
      onTap: model.toggleKeepIn,
      isChecked: isChecked,
    );
  }
}

class AuthButton extends StatelessWidget {
  const AuthButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.read<SignInViewModel>();
    final buttonState =
        context.select((SignInViewModel value) => value.state.buttonState);

    return ConfirmButton(
      state: buttonState,
      text: 'Sign In',
      onPressed: (_) => model.onAuthButtonPressed(context),
    );
  }
}

class NavTextWidget extends StatelessWidget {
  const NavTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.read<SignInViewModel>();
    return LoginPrompt(
      promptText: 'Don\'t have an account ?',
      navigationText: ' Sign up',
      onTap: () => model.navToSignUpScreen(context),
    );
  }
}
