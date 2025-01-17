import 'package:flutter/material.dart';
import 'package:jobs/UI/theme/theme.dart';
import 'package:jobs/UI/widgets/text_field/base_text_field.dart';
import 'package:jobs/UI/widgets/text_field/prefix_icon.dart';

enum Gender {
  Male('Male'),
  Female('Female'),
  Secret('Prefer not to answer');

  const Gender(this.label);
  final String label;
}

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
  Gender? selectedGender;

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
              ...Gender.values.map((Gender gender) {
                final isSelected = gender == selectedGender;
                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedGender = gender;
                    });
                    if (widget.onChanged != null) {
                      widget.onChanged!(gender.label);
                    }
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
    );
  }

  @override
  InputDecoration buildInputDecoration(PrefixIcon prefixIcon) {
    return const InputDecoration(
      border: InputBorder.none,
      contentPadding: EdgeInsets.zero,
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
    return InkWell(
      onTap: widget.isEnabled ? () => _showGenderPicker(context) : null,
      child: Container(
        padding: const EdgeInsets.only(right: 16),
        child: Row(
          children: [
            prefixIcon,
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                selectedGender?.label ?? widget.hintText,
                style: AppTextStyles.textXLSemibold.copyWith(
                  color: selectedGender != null ? Colors.black : grayColor25,
                ),
              ),
            ),
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: grayColor25,
              size: 32,
            ),
          ],
        ),
      ),
    );
  }
}
