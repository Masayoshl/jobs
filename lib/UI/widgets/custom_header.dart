import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jobs/gen/assets.gen.dart';

import '../theme/theme.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({
    required this.text,
    super.key,
  });
  final String text;
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
              Navigator.pop(context);
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

  // @override
  // Widget build(BuildContext context) {
  //   return Container(
  //       margin: const EdgeInsets.only(left: 16),
  //       child: Text(
  //         text,
  //         style: AppTextStyles.headlineXLMobileNavHeader,
  //       ));
  // }
}
