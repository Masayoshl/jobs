import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jobs/gen/assets.gen.dart';

import '../theme/theme.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({
    required this.text,
    this.onPressed,
    super.key,
  });
  final String text;
  final void Function(BuildContext)? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        right: 16,
        top: 20,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              if (onPressed != null) {
                onPressed!(context);
              } else {
                Navigator.of(context).pop();
              }
            },
            child: SvgPicture.asset(
              Assets.icons.arrowLeftMDIcon,
              colorFilter:
                  const ColorFilter.mode(Colors.black, BlendMode.srcIn),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 16),
            child: Text(
              text,
              style: AppTextStyles.headlineXLMobileNavHeader,
            ),
          )
        ],
      ),
    );
  }
}
