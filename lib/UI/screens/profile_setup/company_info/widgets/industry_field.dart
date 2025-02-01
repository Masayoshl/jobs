import 'package:flutter/material.dart';
import 'package:jobs/UI/router/main_router.dart';
import 'package:jobs/UI/theme/theme.dart';
import 'package:jobs/UI/widgets/text_field/base_text_field.dart';
import 'package:jobs/UI/widgets/text_field/prefix_icon.dart';
import 'package:jobs/domain/entity/industry.dart';

class IndustryField extends BaseTextField {
  const IndustryField({
    super.key,
    required super.error,
    super.errorText,
    required super.hintText,
    required super.prefixIcon,
    super.onChanged,
    super.isEnabled = true,
  });

  @override
  State<IndustryField> createState() => _IndustryFieldState();
}

class _IndustryFieldState extends BaseTextFieldState<IndustryField> {
  Industry? selectedIndustry;
  final TextEditingController _controller = TextEditingController();
  void changeIndustry(BuildContext context) async {
    final result = await Navigator.of(context).pushNamed(
        MainRouterNames.industry,
        arguments: {'selectedIndustry': selectedIndustry}) as Industry?;
    selectedIndustry = result;
    _controller.text = selectedIndustry?.title ?? '';

    widget.onChanged?.call(_controller.text);

    focusNode.unfocus();
  }

  @override
  InputDecoration buildInputDecoration(PrefixIcon? prefixIcon) {
    return InputDecoration(
      border: InputBorder.none,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      prefixIcon: prefixIcon,
      hintText: widget.hintText,
      suffixIcon: Padding(
        padding: const EdgeInsets.only(right: 16),
        child: IconButton(
          onPressed: () => changeIndustry(context),
          icon: const Icon(
            Icons.keyboard_arrow_right_outlined,
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
  Widget buildTextField(PrefixIcon? prefixIcon) {
    return TextFormField(
      focusNode: focusNode,
      controller: _controller,
      style: AppTextStyles.textXLSemibold,
      enabled: widget.isEnabled,
      readOnly: true,
      decoration: buildInputDecoration(prefixIcon),
      onTap: () => changeIndustry(context),
    );
  }
}
