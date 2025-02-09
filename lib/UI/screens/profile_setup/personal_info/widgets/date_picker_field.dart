import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jobs/UI/theme/theme.dart';
import 'package:jobs/UI/widgets/text_field/base_text_field.dart';
import 'package:jobs/UI/widgets/text_field/prefix_icon.dart';

class DatePickerField extends BaseTextField {
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final String? selectedDateFormat;

  const DatePickerField({
    super.key,
    required super.error,
    required super.hintText,
    required super.prefixIcon,
    super.errorText,
    super.onChanged,
    super.isEnabled = true,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.selectedDateFormat,
  });

  @override
  State<DatePickerField> createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends BaseTextFieldState<DatePickerField> {
  DateTime? selectedDate;
  final TextEditingController _dateController = TextEditingController();

  void _showDatePicker() async {
    if (!widget.isEnabled) return;

    final DateTime now = DateTime.now();
    final DateTime initialDate = widget.initialDate ?? now;
    final DateTime firstDate = widget.firstDate ?? DateTime(1900);
    final DateTime lastDate = widget.lastDate ?? DateTime(2100);

    final DateTime? picked = await showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: primaryColor500,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: DatePickerDialog(
            initialDate: selectedDate ?? initialDate,
            firstDate: firstDate,
            lastDate: lastDate,
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
          ),
          child: ScaleTransition(
            scale: CurvedAnimation(
              parent: animation,
              curve: Curves.easeOut,
            ),
            child: child,
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black54,
    );

    setState(() {
      selectedDate = picked;
      _dateController.text = picked != null ? _formatDate(picked) : '';
      focusNode.unfocus();
    });

    if (widget.onChanged != null) {
      widget.onChanged!(picked != null ? _formatDate(picked) : '');
    }
  }

  String _formatDate(DateTime date) {
    if (widget.selectedDateFormat != null) {
      return DateFormat(widget.selectedDateFormat).format(date);
    }
    return DateFormat('dd.MM.yyyy').format(date);
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  InputDecoration buildInputDecoration(PrefixIcon? prefixIcon) {
    return InputDecoration(
      border: InputBorder.none,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      prefixIcon: prefixIcon,
      hintText: widget.hintText,
      hintStyle: AppTextStyles.textXLSemibold.copyWith(color: grayColor25),
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
    return TextFormField(
      controller: _dateController,
      focusNode: focusNode,
      style: AppTextStyles.textXLSemibold,
      enabled: widget.isEnabled,
      readOnly: true,
      decoration: buildInputDecoration(prefixIcon),
      onTap: _showDatePicker,
    );
  }
}
