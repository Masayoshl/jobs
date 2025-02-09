import 'package:flutter/material.dart';
import 'package:jobs/UI/theme/theme.dart';
import 'package:jobs/UI/widgets/text_field/base_text_field.dart';
import 'prefix_icon.dart';

class CustomTextField extends BaseTextField {
  const CustomTextField({
    super.key,
    required super.hintText,
    required super.prefixIcon,
    required super.error,
    super.bottom,
    super.top,
    super.left,
    super.right,
    super.onChanged,
    super.errorText,
    super.width,
    super.height,
    super.isEnabled,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

const _borderRadius = 128.0;

class _CustomTextFieldState extends BaseTextFieldState<CustomTextField> {
  @override
  InputDecoration buildInputDecoration(PrefixIcon? prefixIcon) {
    final decoration = InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
        borderSide: const BorderSide(color: Colors.white),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
        borderSide: const BorderSide(color: Colors.white),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
        borderSide: const BorderSide(color: Colors.white),
      ),
      hintText: widget.hintText,
      prefixIcon: prefixIcon,
    );

    return decoration;
  }

  @override
  BoxDecoration buildBoxDecoration(List<BoxShadow> borderColor) {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(_borderRadius),
      boxShadow: borderColor,
    );
  }

  @override
  Widget buildTextField(PrefixIcon? prefixIcon) {
    return TextField(
      style: AppTextStyles.textXLSemibold,
      focusNode: focusNode,
      enabled: widget.isEnabled,
      decoration: buildInputDecoration(prefixIcon),
      onChanged: widget.onChanged,
      textInputAction: TextInputAction.done,
    );
  }
}
