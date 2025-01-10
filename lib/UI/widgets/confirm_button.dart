import 'package:flutter/material.dart';
import 'package:jobs/UI/common/button_state.dart';
import 'package:jobs/UI/theme/theme.dart';

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

  @override
  Widget build(BuildContext context) {
    final isEnabled = state?.isEnabled ?? true;
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
        isEnabled ? (backgroundColor ?? primaryColor) : primaryColor300;

    return Container(
      margin: EdgeInsets.only(
          left: left ?? 18,
          right: right ?? 18,
          bottom: bottom ?? 32,
          top: top ?? 32),
      width: width ?? 360,
      height: height ?? 60,
      decoration: BoxDecoration(
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
          onPressed: isEnabled ? () => onPressed(context) : null,
          child: child),
    );
  }
}
