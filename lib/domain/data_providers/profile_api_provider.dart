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

  Future<void> setAccountInfo(String sessionToken) async {
    await Future.delayed(const Duration(seconds: 1));
    debugPrint('Success set info. token:$sessionToken');
  }

  Future<void> setAccountImage(String sessionToken, String path) async {
    await Future.delayed(const Duration(seconds: 2));
    debugPrint('Success set info. token:$sessionToken, file:$path');
  }
}
