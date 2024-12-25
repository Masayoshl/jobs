import 'package:flutter/material.dart';
import 'package:jobs/UI/theme/custom_themes/text_field_theme.dart';

part 'text_theme.dart';
part 'colors.dart';

class CustomAppTheme {
  CustomAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: 'JosefinSans',
    primaryColor: primaryColor,
    colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
    scaffoldBackgroundColor: Colors.white,
    inputDecorationTheme: CustomTextFieldTheme.lightInputDecorationTheme,
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        //backgroundColor: MaterialStateProperty.all<Color>(primarycolor),
        foregroundColor: const WidgetStatePropertyAll<Color>(Colors.white),
        shadowColor: const WidgetStatePropertyAll<Color>(
          Color.fromRGBO(107, 166, 255, 0.53),
        ),
        elevation: const WidgetStatePropertyAll<double>(3),
        shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(128),
          ),
        ),
      ),
    ),
    textTheme: const TextTheme(
      displaySmall: AppTextStyles.headlineXL,
      headlineLarge: AppTextStyles.headlineL,
      headlineMedium: AppTextStyles.headlineM,
      headlineSmall: AppTextStyles.headlineS,
      titleLarge: AppTextStyles.textXXLSemibold,
      titleMedium: AppTextStyles.textXLSemibold,
      bodyLarge: AppTextStyles.textL,
      bodyMedium: AppTextStyles.textM,
      bodySmall: AppTextStyles.textS,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: primaryColor,
    ),
    //textSelectionTheme: const TextSelectionThemeData(cursorColor: primaryColor),
    appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'JosefinSans',
    primaryColor: primaryColor,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
  );
}
