import 'package:flutter/material.dart';
import 'package:jobs/UI/theme/theme.dart';
import 'package:jobs/UI/widgets/text_field/base_text_field.dart';

import 'prefix_icon.dart';

class PasswordTextField extends BaseTextField {
  const PasswordTextField({
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
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends BaseTextFieldState<PasswordTextField> {
  bool _isObscured = true;

  void _togglePasswordVisibility() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  @override
  InputDecoration buildInputDecoration(PrefixIcon? prefixIcon) {
    final suffixIcon = _SuffixIcon(
      isSelected: !_isObscured,
      iconColor: _isObscured ? grayColor25 : super.iconColor,
      onPressed: _togglePasswordVisibility,
    );

    final decoration = InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(128),
        borderSide: const BorderSide(color: Colors.white),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(128),
        borderSide: const BorderSide(color: Colors.white),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(128),
        borderSide: const BorderSide(color: Colors.white),
      ),
      hintText: widget.hintText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
    );
    return decoration;
  }

  @override
  BoxDecoration buildBoxDecoration(List<BoxShadow> borderColor) {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(128),
      boxShadow: borderColor,
    );
  }

  @override
  Widget buildTextField(PrefixIcon? prefixIcon) {
    return TextField(
      style: AppTextStyles.textXLSemibold,
      focusNode: focusNode,
      enabled: widget.isEnabled,
      obscuringCharacter: '*',
      obscureText: _isObscured,
      decoration: buildInputDecoration(prefixIcon),
      onChanged: widget.onChanged,
      textInputAction: TextInputAction.done,
    );
  }
}

class _SuffixIcon extends StatelessWidget {
  final bool isSelected;
  final Color iconColor;
  final VoidCallback onPressed;

  const _SuffixIcon({
    required this.isSelected,
    required this.iconColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: IconButton(
        icon: Icon(
          Icons.visibility_off_outlined,
          size: 32,
          color: iconColor,
        ),
        selectedIcon: Icon(
          Icons.visibility_outlined,
          size: 32,
          color: iconColor,
        ),
        isSelected: isSelected,
        onPressed: onPressed,
      ),
    );
  }
}
