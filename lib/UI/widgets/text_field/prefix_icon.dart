import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PrefixIcon extends StatelessWidget {
  const PrefixIcon({
    super.key,
    required this.iconPath,
    required Color iconColor,
  }) : _iconColor = iconColor;

  final String iconPath;
  final Color _iconColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30).copyWith(right: 16),
      child: SvgPicture.asset(
        iconPath,
        colorFilter: ColorFilter.mode(_iconColor, BlendMode.srcIn),
        fit: BoxFit.none,
      ),
    );
  }
}
