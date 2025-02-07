import 'package:flutter/material.dart';
import 'package:jobs/UI/theme/theme.dart';
import 'package:jobs/UI/widgets/text_field/base_text_field.dart';
import 'package:jobs/UI/widgets/text_field/prefix_icon.dart';

class DescriptionTextField extends BaseTextField {
  const DescriptionTextField({
    super.key,
    required super.hintText,
    super.prefixIcon,
    required super.error,
    super.bottom,
    super.top,
    super.left,
    super.right,
    super.onChanged,
    super.errorText,
    super.width,
    super.height = 124,
    super.isEnabled,
    super.isCentered = false,
  });

  @override
  State<DescriptionTextField> createState() => _CustomTextFieldState();
}

const _borderRadius = 30.0;

class _CustomTextFieldState extends BaseTextFieldState<DescriptionTextField> {
  @override
  InputDecoration buildInputDecoration(PrefixIcon? prefixIcon) {
    final decoration = InputDecoration(
      contentPadding: const EdgeInsets.all(16),
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
      maxLines: 30,
      minLines: 1,
      decoration: buildInputDecoration(prefixIcon),
      onChanged: widget.onChanged,
      textInputAction: TextInputAction.done,
    );
  }
}
