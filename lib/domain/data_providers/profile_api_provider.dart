import 'package:flutter/material.dart';

class ProfileApiProvider {
  Future<void> setAccountType(String sessionToken) async {
    await Future.delayed(const Duration(seconds: 1));
    debugPrint('Success set type. token:$sessionToken');
  }

  Future<void> setAccountCountry(String sessionToken) async {
    await Future.delayed(const Duration(seconds: 1));
    debugPrint('Success set country. token:$sessionToken');
  }
}
