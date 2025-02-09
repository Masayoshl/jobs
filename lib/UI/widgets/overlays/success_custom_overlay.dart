import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jobs/UI/theme/theme.dart';
import 'package:jobs/UI/widgets/widgets.dart';
import 'package:jobs/gen/assets.gen.dart';

class CongratOverlay extends StatefulWidget {
  const CongratOverlay({
    super.key,
  });

  @override
  State<CongratOverlay> createState() => _CongratOverlayState();
}

class _CongratOverlayState extends State<CongratOverlay> {
  final _controller = OverlayPortalController();
  @override
  Widget build(BuildContext context) {
    return OverlayPortal(
      controller: _controller,
      overlayChildBuilder: (context) {
        return Positioned(
          top: 203,
          bottom: 144,
          left: 47,
          right: 47,
          child: BackdropFilter(
            filter: ImageFilter.blur(
                sigmaX: 4, sigmaY: 4, tileMode: TileMode.mirror),
            child: Container(
              width: 334,
              height: 501,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    spreadRadius: 1,
                    blurRadius: 1,
                    blurStyle: BlurStyle.normal,
                    offset: const Offset(0, 2),
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      Assets.images.createPasswordCongratImage,
                      width: 318,
                      height: 225,
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    const Text('Congratulations !!',
                        style: AppTextStyles.headlineXLMobileBold),
                    const SizedBox(
                      height: 20,
                    ),
                    Text('New Password has been generated successfully',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.textXLMedium
                            .copyWith(color: grayColor100)),
                    ConfirmButton(
                      backgroundColor: purple400,
                      width: 260,
                      height: 60,
                      left: 55,
                      right: 55,
                      top: 24,
                      bottom: 50,
                      onPressed: (_) {},
                      text: 'Continue',
                    )
                  ]),
            ),
          ),
        );
      },
      child: ConfirmButton(
        text: 'Continue',
        onPressed: (_) {},
        top: 10,
        bottom: 16,
        left: 32,
        right: 32,
      ),
    );
  }
}
