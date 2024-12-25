import 'package:flutter/material.dart';

import 'package:jobs/UI/theme/theme.dart';

class ForgotPassword extends StatelessWidget {
  final void Function()? onTap;

  const ForgotPassword({
    super.key,
    this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 51, top: 20),
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          'Forgot Password?',
          textAlign: TextAlign.center,
          style: AppTextStyles.textXXLSemibold.copyWith(color: grayColor100),
        ),
      ),
    );
  }
}
