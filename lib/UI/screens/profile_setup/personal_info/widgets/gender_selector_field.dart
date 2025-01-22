import 'package:flutter/material.dart';
import 'package:jobs/UI/theme/theme.dart';
import 'package:jobs/UI/widgets/text_field/base_text_field.dart';
import 'package:jobs/UI/widgets/text_field/prefix_icon.dart';
import 'package:jobs/domain/entity/gender.dart';

class GenderSelector extends BaseTextField {
  const GenderSelector({
    super.key,
    required super.error,
    super.errorText,
    required super.hintText,
    required super.prefixIcon,
    super.onChanged,
    super.isEnabled = true,
  });

  @override
  State<GenderSelector> createState() => _GenderSelectorState();
}

class _GenderSelectorState extends BaseTextFieldState<GenderSelector> {
  String? selectedValue;
  final TextEditingController _controller = TextEditingController();

  void _showGenderPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: grayColor25,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              ...GenderType.values.map((GenderType gender) {
                final isSelected = gender.label == selectedValue;
                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedValue = gender.label;
                      _controller.text = gender.label;
                    });
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 24,
                    ),
                    color: isSelected ? neutralColor500 : Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          gender.label,
                          style: AppTextStyles.textXLSemibold.copyWith(
                            color: isSelected ? purple400 : Colors.black,
                          ),
                        ),
                        if (isSelected)
                          const Icon(
                            Icons.check_rounded,
                            color: purple400,
                            size: 24,
                          ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
        );
      },
    ).whenComplete(() async {
      if (widget.onChanged != null) {
        widget.onChanged!(_controller.text);

        focusNode.unfocus();
      }
    });
  }

  @override
  InputDecoration buildInputDecoration(PrefixIcon prefixIcon) {
    return InputDecoration(
      border: InputBorder.none,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      prefixIcon: prefixIcon,
      hintText: widget.hintText,
      suffixIcon: Padding(
        padding: const EdgeInsets.only(right: 16),
        child: IconButton(
          onPressed: () => _showGenderPicker(context),
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: grayColor25,
            size: 32,
          ),
        ),
      ),
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
  Widget buildTextField(PrefixIcon prefixIcon) {
    return TextFormField(
      focusNode: focusNode,
      controller: _controller,
      style: AppTextStyles.textXLSemibold,
      enabled: widget.isEnabled,
      readOnly: true,
      decoration: buildInputDecoration(prefixIcon),
      onTap: () => _showGenderPicker(context),
    );
  }
}
