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
    super.maxLength,
    super.showCounter,
  });

  @override
  State<PhoneTextField> createState() => _PhoneTextFieldState();
}

class _PhoneTextFieldState extends BaseTextFieldState<PhoneTextField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    setState(() {});
    // Если есть ограничение по длине и текст превышает его
    if (widget.maxLength != null &&
        _controller.text.length > widget.maxLength!) {
      // Обрезаем текст до максимальной длины
      _controller.text = _controller.text.substring(0, widget.maxLength);
      // Возвращаем курсор в конец текста
      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length),
      );
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  int? getCurrentLength() => _controller.text.length;

  @override
  InputDecoration buildInputDecoration(PrefixIcon? prefixIcon) {
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
  Widget buildTextField(PrefixIcon? prefixIcon) {
    return Padding(
      padding: const EdgeInsets.only(left: 28.0),
      child: IntlPhoneField(
        controller: _controller,
        focusNode: focusNode,
        disableLengthCheck: true,
        showDropdownIcon: false,
        decoration: buildInputDecoration(prefixIcon),
        enabled: widget.isEnabled,
        initialCountryCode: widget.initialCountryCode,
        style: AppTextStyles.textXLSemibold,
        dropdownTextStyle: AppTextStyles.textXLSemibold,
        onChanged: (phone) {
          if (widget.onChanged != null) {
            widget.onChanged!(phone.number);
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
