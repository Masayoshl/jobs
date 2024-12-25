import 'package:flutter/material.dart';
import 'package:jobs/UI/theme/theme.dart';

class CustomTextFieldTheme {
  CustomTextFieldTheme._();
  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    hintStyle: AppTextStyles.textXLSemibold.copyWith(color: grayColor25),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(128),
      borderSide: const BorderSide(color: Colors.white),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(128),
      borderSide: const BorderSide(color: Colors.white),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(128),
      borderSide: const BorderSide(color: Colors.white),
    ),
  );

  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    hintStyle: AppTextStyles.textXLSemibold.copyWith(color: grayColor25),
    border: const OutlineInputBorder(
      // Обычная граница поля ввода

      borderSide: BorderSide(color: Colors.white),
    ),
    enabledBorder: const OutlineInputBorder(
      // Граница в неактивном состоянии

      borderSide: BorderSide(color: Colors.white),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
    focusColor: primaryColor300,
  );
}
