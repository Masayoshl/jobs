import 'package:flutter/material.dart';
import 'package:jobs/UI/screens/auth/sign_in/sign_in_screen.dart';
import 'package:jobs/UI/screens/auth/sign_up/sign_up_screen.dart';
import 'package:jobs/UI/screens/profile_setup/account_type/account_type_screen.dart';
import 'package:jobs/UI/screens/profile_setup/account_type/account_type_view_model.dart';
import 'package:jobs/UI/screens/profile_setup/company_info/company_info_screen.dart';
import 'package:jobs/UI/screens/profile_setup/company_info/company_info_view_model.dart';
import 'package:jobs/UI/screens/profile_setup/industry/industry_screen.dart';
import 'package:jobs/UI/screens/profile_setup/industry/industry_view_model.dart';
import 'package:jobs/UI/screens/profile_setup/personal_info/personal_info_screen.dart';
import 'package:jobs/UI/screens/profile_setup/personal_info/personal_info_view_model.dart';
import 'package:jobs/UI/screens/profile_setup/profile_photo/profile_photo_screen.dart';
import 'package:jobs/UI/screens/profile_setup/profile_photo/profile_photo_view_model.dart';
import 'package:jobs/UI/screens/profile_setup/profile_setup_screen.dart';
import 'package:jobs/UI/screens/profile_setup/profile_setup_view_model.dart';
import 'package:jobs/UI/screens/profile_setup/select_country/select_country_screen.dart';
import 'package:jobs/UI/screens/profile_setup/select_country/select_country_view_model.dart';
import 'package:jobs/UI/view_models/sign_in/sign_in_view_model.dart';
import 'package:jobs/UI/view_models/sign_up/sign_up_view_model.dart';
import 'package:jobs/UI/screens/forgot_password/forgot_password_screen.dart';
import 'package:jobs/UI/screens/one_time_password/one_time_password_screen.dart';
import 'package:jobs/UI/view_models/forgot_password/forgot_password_view_model.dart';
import 'package:jobs/UI/view_models/one_time_password/one_time_password_view_model.dart';
import 'package:jobs/UI/screens/loader/loader_screen.dart';
import 'package:jobs/UI/view_models/loader/loader_view_model.dart';
import 'package:jobs/UI/screens/new_password/new_password_screen.dart';
import 'package:jobs/UI/view_models/new_password/new_password_view_model.dart';
import 'package:jobs/domain/entity/industry.dart';
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

  Widget makeProfileSetup() {
    return Provider(
      create: (_) => ProfileSetupViewModel(),
      child: const ProfileSetupScreen(),
    );
  }

  Widget makeAccountType() {
    return ChangeNotifierProvider(
      create: (_) => AccountTypeViewModel(),
      child: const AccountTypeScreen(),
    );
  }

  Widget makeSelectCountry() {
    return ChangeNotifierProvider(
      create: (_) => SelectCountryViewModel(),
      child: const SelectCountryScreen(),
    );
  }

  Widget makePersonalInfo(String initialCountryCode) {
    return ChangeNotifierProvider(
      create: (_) => PersonalInfoViewModel(initialCountryCode.toUpperCase()),
      child: const PersonalInfoScreen(),
    );
  }

  Widget makeCompanyInfo(String initialCountryCode) {
    return ChangeNotifierProvider(
      create: (_) => CompanyInfoViewModel(initialCountryCode.toUpperCase()),
      child: const CompanyInfoScreen(),
    );
  }

  Widget makeIndustry(Industry? selectedIndustry) {
    return ChangeNotifierProvider(
      create: (_) => IndustryViewModel(selectedIndustry),
      child: const IndustryScreen(),
    );
  }

  Widget makeProfilePhoto() {
    return ChangeNotifierProvider(
      create: (_) => ProfilePhotoViewModel(),
      child: const ProfilePhotoScreen(),
    );
  }
}
