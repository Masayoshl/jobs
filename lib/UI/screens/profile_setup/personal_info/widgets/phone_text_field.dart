import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:jobs/UI/theme/theme.dart';
import 'package:jobs/UI/widgets/text_field/base_text_field.dart';
import 'package:jobs/UI/widgets/text_field/prefix_icon.dart';

class PhoneTextField extends BaseTextField {
  final void Function(String)? onCountryChanged;
  final void Function(String)? onCompleted;
  final String initialCountryCode;

  const PhoneTextField({
    super.key,
    required super.hintText,
    super.prefixIcon,
    required super.error,
    this.initialCountryCode = '',
    super.bottom,
    super.top,
    super.left,
    super.right,
    super.onChanged,
    super.errorText,
    super.width,
    super.height,
    super.isEnabled = true,
    this.onCountryChanged,
    this.onCompleted,
  });

  @override
  State<PhoneTextField> createState() => _PhoneTextFieldState();
}

class _PhoneTextFieldState extends BaseTextFieldState<PhoneTextField> {
  @override
  InputDecoration buildInputDecoration(PrefixIcon prefixIcon) {
    return InputDecoration(
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
    );
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
  Widget buildTextField(PrefixIcon prefixIcon) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0),
      child: IntlPhoneField(
        initialCountryCode: widget.initialCountryCode,
        focusNode: focusNode,
        enabled: widget.isEnabled,
        disableLengthCheck: true,
        showDropdownIcon: false,
        style: AppTextStyles.textXLSemibold,
        decoration: buildInputDecoration(prefixIcon),
        onChanged: (phone) {
          if (widget.onChanged != null) {
            widget.onChanged!(phone.completeNumber);
          }
        },
        onCountryChanged: (country) {
          if (widget.onCountryChanged != null) {
            widget.onCountryChanged!(country.code);
          }
        },
        onSubmitted: widget.onCompleted,
      ),
    );
  }
}
