import 'package:flutter/material.dart';
import 'package:jobs/domain/factories/screen_factory.dart';

abstract class MainRouterNames {
  static const loader = '/';
  static const sigIn = '/sign_in';
  static const signUp = '/sign_in/sign_up';
  static const forgotPassword = '/sign_in/forgot_password';
  static const oneTimePassword = '/sign_in/forgot_password/one_time_password';
  static const createPassword =
      '/sign_in/forgot_password/one_time_password/create_password';
  static const profileSetup = '/sign_in/sign_up/profile_setup';
  static const accountType = '/sign_in/sign_up/profile_setup/account_type';
  static const selectCountry =
      '/sign_in/sign_up/profile_setup/account_type/select_country';
  static const personalInfo =
      '/sign_in/sign_up/profile_setup/account_type/select_country/personal_info';
  static const companyInfo =
      '/sign_in/sign_up/profile_setup/account_type/select_country/company_info';
  static const industry =
      '/sign_in/sign_up/profile_setup/account_type/select_country/company_info/industry';
}

class MainRouter {
  static final _screenFactory = ScreenFactory();

  //! Юзать если нужно поверсатать один екран =>
  final home = _screenFactory.makeAccountType();

  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainRouterNames.loader:
        return PageRouteBuilder(
            pageBuilder: (_, animation1, animation2) =>
                _screenFactory.makeLoader(),
            transitionDuration: Duration.zero);
      case MainRouterNames.sigIn:
        return PageRouteBuilder(
            pageBuilder: (_, animation1, animation2) =>
                _screenFactory.makeSignIn(),
            transitionDuration: Duration.zero);
      case MainRouterNames.signUp:
        return MaterialPageRoute(
          builder: (_) => _screenFactory.makeSignUp(),
        );
      case MainRouterNames.forgotPassword:
        return MaterialPageRoute(
          builder: (_) => _screenFactory.makeForgotPassword(),
        );
      case MainRouterNames.oneTimePassword:
        return MaterialPageRoute(
          builder: (_) => _screenFactory.makeOneTimePassword(),
        );
      case MainRouterNames.createPassword:
        return MaterialPageRoute(
          builder: (_) => _screenFactory.makeNewPassword(),
        );
      case MainRouterNames.profileSetup:
        return MaterialPageRoute(
          builder: (_) => _screenFactory.makeProfileSetup(),
        );
      case MainRouterNames.accountType:
        return MaterialPageRoute(
          builder: (_) => _screenFactory.makeAccountType(),
        );
      case MainRouterNames.selectCountry:
        return MaterialPageRoute(
          builder: (_) => _screenFactory.makeSelectCountry(),
        );
      case MainRouterNames.personalInfo:
        final initialCountryCode =
            (settings.arguments as Map<String, dynamic>)['countryCode'];
        return MaterialPageRoute(
          builder: (_) => _screenFactory.makePersonalInfo(initialCountryCode),
        );
      case MainRouterNames.companyInfo:
        final initialCountryCode =
            (settings.arguments as Map<String, dynamic>)['countryCode'];
        return MaterialPageRoute(
          builder: (_) => _screenFactory.makeCompanyInfo(initialCountryCode),
        );
      case MainRouterNames.industry:
        final selectedIndustry =
            (settings.arguments as Map<String, dynamic>)['selectedIndustry'];
        return MaterialPageRoute(
          builder: (_) => _screenFactory.makeIndustry(selectedIndustry),
          fullscreenDialog: true,
        );
      default:
        const widget = Text('Navigation Error!!!');
        return MaterialPageRoute(builder: (context) => widget);
    }
  }
}
