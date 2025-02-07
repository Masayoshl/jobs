import 'package:flutter/material.dart';
import 'package:jobs/UI/widgets/custom_icon.dart';

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
        padding: const EdgeInsets.only(left: 30, right: 16),
        child: CustomIcon(
          iconPath: iconPath,
          iconColor: _iconColor,
          boxFit: BoxFit.none,
        ));
  }
}
