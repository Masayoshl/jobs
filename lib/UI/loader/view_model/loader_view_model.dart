import 'package:flutter/material.dart';
import 'package:jobs/UI/router/main_router.dart';
import 'package:jobs/domain/servises/auth_service.dart';

class LoaderViewModel {
  final BuildContext context;
  final _authService = AuthService();

  LoaderViewModel(this.context) {
    setup();
  }

  void setup() async {
    final isAuth = await _authService.isAuth();
    final nextScreen =
        isAuth ? MainRouterNames.createPassword : MainRouterNames.sigIn;

    Navigator.of(context).pushReplacementNamed(nextScreen);
  }
}
