import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:jobs/UI/theme/theme.dart';

class ForgotPassword extends StatelessWidget {
  final void Function() onTap;

  const ForgotPassword({
    super.key,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 41, top: 20),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Forgot Password?',
              style:
                  AppTextStyles.textXXLSemibold.copyWith(color: grayColor100),
              recognizer: TapGestureRecognizer()..onTap = () => onTap(),
            ),
          ],
        ),
      ),
    );
  }
}
