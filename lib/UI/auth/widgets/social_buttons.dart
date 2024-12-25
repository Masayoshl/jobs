import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jobs/UI/theme/theme.dart';
import 'package:jobs/gen/assets.gen.dart';

class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 51),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '------    Continue with    ------',
            style: AppTextStyles.textXXLRegular.copyWith(color: grayColor25),
          ),
          const SizedBox(
            height: 9,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                  child: Container(
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x21000000),
                              spreadRadius: -7,
                              blurRadius: 14,
                              blurStyle: BlurStyle.normal,
                              offset: Offset.zero,
                            ),
                          ]),
                      child: SvgPicture.asset(Assets.icons.faceBookIcon))),
              GestureDetector(
                  child: Container(
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x21000000),
                              spreadRadius: -7,
                              blurRadius: 14,
                              blurStyle: BlurStyle.normal,
                              offset: Offset.zero,
                            ),
                          ]),
                      child: SvgPicture.asset(Assets.icons.googleIcon))),
              GestureDetector(
                  child: Container(
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x21000000),
                              spreadRadius: -7,
                              blurRadius: 14,
                              blurStyle: BlurStyle.normal,
                              offset: Offset.zero,
                            ),
                          ]),
                      child: SvgPicture.asset(Assets.icons.twitterIcon)))
            ],
          ),
        ],
      ),
    );
  }
}
