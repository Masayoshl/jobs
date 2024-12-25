import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jobs/UI/theme/theme.dart';
import 'package:jobs/gen/assets.gen.dart';

class CustomCheckbox extends StatefulWidget {
  final String text;
  final double? left;
  final bool isChecked;
  final void Function() onTap;
  const CustomCheckbox({
    Key? key,
    required this.text,
    required this.isChecked,
    required this.onTap,
    this.left,
  }) : super(key: key);

  @override
  State<CustomCheckbox> createState() {
    return _CustomCheckboxState();
  }
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  void _toggleCheckBox() {
    setState(() {
      widget.onTap();
      SystemSound.play(SystemSoundType.click);
    });
  }

  @override
  Widget build(BuildContext context) {
    final icon = widget.isChecked
        ? Assets.checkbox.ticksquareSelected
        : Assets.checkbox.ticksquareEmpty;
    return GestureDetector(
      onTap: _toggleCheckBox,
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: widget.left ?? 32),
            child: SvgPicture.asset(icon),
          ),
          const SizedBox(
            width: 12,
          ),
          Text(
            widget.text,
            style: AppTextStyles.textXLMedium.copyWith(
              color: grayColor25,
            ),
          ),
        ],
      ),
    );
  }
}
