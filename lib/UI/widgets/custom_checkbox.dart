import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jobs/UI/theme/theme.dart';
import 'package:jobs/gen/assets.gen.dart';

class CustomCheckbox extends StatelessWidget {
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

  void _toggleCheckBox() {
    onTap();
    SystemSound.play(SystemSoundType.click);
  }

  @override
  Widget build(BuildContext context) {
    final icon = isChecked
        ? Assets.checkbox.ticksquareSelected
        : Assets.checkbox.ticksquareEmpty;
    return GestureDetector(
      onTap: _toggleCheckBox,
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: left ?? 32),
            child: AnimatedSwitcher(
              switchInCurve: Curves.easeOut,
              switchOutCurve: Curves.easeOut,
              duration: const Duration(milliseconds: 100),
              child: SvgPicture.asset(
                icon,
                key: ValueKey<String>(icon),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            text,
            style: AppTextStyles.textXLMedium.copyWith(
              color: grayColor25,
            ),
          ),
        ],
      ),
    );
  }
}
