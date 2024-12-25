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
}

class MainRouter {
  static final _screenFactory = ScreenFactory();

  //! Юзать если нужно поверсатать один екран => final home = _screenFactory.makeSignIn();

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
      default:
        const widget = Text('Navigation Error!!!');
        return MaterialPageRoute(builder: (context) => widget);
    }
  }
}
