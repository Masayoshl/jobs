import 'package:flutter/material.dart';
import 'package:jobs/UI/theme/theme.dart';

class ConfirmButton extends StatelessWidget {
  const ConfirmButton({
    required this.onPressed,
    required this.text,
    this.bottom,
    this.top,
    this.left,
    this.right,
    this.width,
    this.height,
    this.buttonColor,
    this.indicator,
    super.key,
  });
  final String text;
  final VoidCallback onPressed;
  final double? bottom;
  final double? top;
  final double? left;
  final double? right;
  final double? width;
  final double? height;
  final Color? buttonColor;
  final Widget? indicator;
  @override
  Widget build(BuildContext context) {
    final child = indicator ??
        Text(
          text,
          style: AppTextStyles.textXLSemibold.copyWith(color: Colors.white),
        );
    final color = buttonColor ?? primaryColor;
    return Container(
      margin: EdgeInsets.only(
          left: left ?? 18,
          right: right ?? 18,
          bottom: bottom ?? 32,
          top: top ?? 32),
      width: width ?? 360,
      height: height ?? 60,
      decoration: BoxDecoration(
        //color: color ?? primarycolor,
        borderRadius: BorderRadius.circular(128),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: FilledButton(
          style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(color)),
          onPressed: onPressed,
          child: child),
    );
  }
}
