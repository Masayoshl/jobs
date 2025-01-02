import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jobs/UI/router/main_router.dart';

class ProfileSetupViewModel {
  void navToAccountTypeScreeen(BuildContext context) {
    Navigator.of(context).pushNamed(MainRouterNames.accountType);
  }

  void navToMainScreen(BuildContext context) {
    //Todo Измменить путь после создания мейн пейджа
    SystemSound.play(SystemSoundType.click);
    Navigator.of(context).pushReplacementNamed(MainRouterNames.signUp);
  }
}
