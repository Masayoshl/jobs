import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon({
    super.key,
    required this.iconPath,
    this.iconColor,
    this.boxFit = BoxFit.contain,
    this.size,
  }) : assert(
          size == null || boxFit == BoxFit.contain,
          'BoxFit cannot be modified when size is specified',
        );

  final String iconPath;
  final Color? iconColor;
  final double? size;
  final BoxFit boxFit;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      iconPath,
      width: size,
      height: size,
      colorFilter: iconColor != null
          ? ColorFilter.mode(iconColor!, BlendMode.srcIn)
          : null,
      fit: boxFit,
    );
  }
}
