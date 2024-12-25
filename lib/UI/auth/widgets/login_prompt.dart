import 'package:flutter/material.dart';
import 'package:jobs/UI/theme/theme.dart';

class LoginPrompt extends StatelessWidget {
  const LoginPrompt({
    required this.onTap,
    required this.promptText,
    required this.navigationText,
    this.navigationTextStyle,
    super.key,
  });
  final VoidCallback onTap;
  final String promptText;
  final String navigationText;
  final TextStyle? navigationTextStyle;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          promptText,
          style: AppTextStyles.textXXLRegular.copyWith(color: grayColor25),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            navigationText,
            style: navigationTextStyle ??
                AppTextStyles.textXXLSemibold.copyWith(color: primaryColor),
          ),
        ),
      ],
    );
  }
}
