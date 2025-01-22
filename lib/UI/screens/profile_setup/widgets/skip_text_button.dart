import 'package:flutter/material.dart';
import 'package:jobs/UI/theme/theme.dart';

class SkipTextButton extends StatelessWidget {
  const SkipTextButton({
    super.key,
    required this.onPressed,
  });
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        'Skip For Now',
        style: AppTextStyles.textXXLSemibold.copyWith(color: purple400),
      ),
    );
  }
}
