import 'package:flutter/material.dart';
import 'package:jobs/UI/common/button_state.dart';
import 'package:jobs/UI/theme/theme.dart';
import 'package:jobs/UI/widgets/custom_icon.dart';

class ConfirmButton extends StatelessWidget {
  const ConfirmButton({
    required this.onPressed,
    required this.text,
    this.state,
    this.bottom,
    this.top,
    this.left,
    this.right,
    this.width,
    this.height,
    this.backgroundColor,
    this.iconPath,
    super.key,
  });

  final String text;

  final Function(BuildContext) onPressed;
  final ButtonStateBase? state;
  final double? bottom;
  final double? top;
  final double? left;
  final double? right;

  final double? width;
  final double? height;
  final Color? backgroundColor;
  final String? iconPath;

  @override
  Widget build(BuildContext context) {
    final isEnabled = state?.isEnabled ?? true;
    final icon = iconPath == null
        ? null
        : CustomIcon(
            iconPath: iconPath!,
            iconColor: Colors.white,
            size: 24,
          );

    final child = state?.isInProcess ?? false
        ? const CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 2,
          )
        : Text(
            text,
            style: AppTextStyles.textXLSemibold.copyWith(color: Colors.white),
          );

    final color =
        isEnabled ? (backgroundColor ?? primaryColor500) : primaryColor300;

    return Container(
      margin: EdgeInsets.only(
          left: left ?? 18,
          right: right ?? 18,
          bottom: bottom ?? 32,
          top: top ?? 32),
      constraints: BoxConstraints.tightFor(
        width: width ?? 360,
        height: height ?? 60,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(128),
      ),
      child: FilledButton.icon(
        style: ButtonStyle(
            shadowColor: const WidgetStatePropertyAll(Colors.black),
            elevation: const WidgetStatePropertyAll(8),
            backgroundColor: WidgetStateProperty.all<Color>(color)),
        onPressed: isEnabled ? () => onPressed(context) : null,
        label: child,
        icon: icon,
      ),
    );
  }
}
