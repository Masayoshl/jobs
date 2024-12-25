import 'package:flutter/material.dart';
import 'package:jobs/UI/auth/view/sign_in_screen.dart';
import 'package:jobs/UI/auth/view/sign_up_screen.dart';
import 'package:jobs/UI/auth/view_models/sign_in_view_model/sign_in_view_model.dart';
import 'package:jobs/UI/auth/view_models/sign_up_view_model.dart';
import 'package:jobs/UI/forgot_password/view/forgot_password_screen.dart';
import 'package:jobs/UI/forgot_password/view/one_time_password_screen.dart';
import 'package:jobs/UI/forgot_password/view_model/forgot_password_view_model/forgot_password_view_model.dart';
import 'package:jobs/UI/forgot_password/view_model/one_time_password_view_model/one_time_password_view_model.dart';
import 'package:jobs/UI/loader/view/loader_screen.dart';
import 'package:jobs/UI/loader/view_model/loader_view_model.dart';
import 'package:jobs/UI/new_password/view/new_password_screen.dart';
import 'package:jobs/UI/new_password/view_model/new_password_view_model.dart';
import 'package:provider/provider.dart';

class ScreenFactory {
  Widget makeLoader() {
    return Provider(
      create: (context) => LoaderViewModel(context),
      lazy: false,
      child: const LoaderScreen(),
    );
  }

  Widget makeSignIn() {
    return ChangeNotifierProvider(
      create: (_) => SignInViewModel(),
      child: const SignInScreen(),
    );
  }

  Widget makeSignUp() {
    return ChangeNotifierProvider(
      create: (_) => SignUpViewModel(),
      child: const SignUpScreen(),
    );
  }

  Widget makeForgotPassword() {
    return ChangeNotifierProvider(
      create: (_) => ForgotPasswordViewModel(),
      child: const ForgotPasswordScreen(),
    );
  }

  Widget makeOneTimePassword() {
    return ChangeNotifierProvider(
      create: (_) => OneTimePasswordViewModel(),
      child: const OneTimePasswordScreen(),
    );
  }

  Widget makeNewPassword() {
    return ChangeNotifierProvider(
      create: (_) => NewPasswordViewModel(),
      child: const NewPasswordScreen(),
    );
  }
}
