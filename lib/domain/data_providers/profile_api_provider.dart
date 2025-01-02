import 'package:flutter/material.dart';

class ProfileApiProvider {
  void setAccountType(String sessionToken) async {
    await Future.delayed(const Duration(seconds: 1));
    debugPrint('Sucsses set type');
  }
}
