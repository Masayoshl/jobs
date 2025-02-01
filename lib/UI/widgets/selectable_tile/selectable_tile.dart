import 'package:flutter/material.dart';
import 'package:jobs/UI/theme/theme.dart';

abstract class SelectableTile extends StatelessWidget {
  final String id;
  final String? selectedId;
  final VoidCallback? onTap;
  final Color selectedColor;
  final Color unselectedColor;

  const SelectableTile({
    super.key,
    required this.id,
    this.selectedId,
    this.onTap,
    this.selectedColor = primaryColor500,
    this.unselectedColor = neutralColor600,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = id == selectedId;
    final borderRadius = BorderRadius.circular(15);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        border: Border.all(
          color: isSelected ? selectedColor : unselectedColor,
          width: 1.5,
        ),
      ),
      child: Ink(
        child: InkWell(
          borderRadius: borderRadius,
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                const SizedBox(width: 16),
                buildLeadingWidget(isSelected),
                const SizedBox(width: 12),
                Expanded(
                  child: buildTitleWidget(isSelected),
                ),
                buildTrailingRadio(isSelected),
                const SizedBox(width: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLeadingWidget(bool isSelected);

  Widget buildTitleWidget(bool isSelected);

  Widget buildTrailingRadio(bool isSelected) {
    return IgnorePointer(
      ignoring: true,
      child: Radio<String>(
        onChanged: null,
        value: id,
        groupValue: selectedId,
        activeColor: primaryColor500,
        fillColor: WidgetStateProperty.all<Color>(primaryColor500),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: const VisualDensity(
          horizontal: VisualDensity.minimumDensity,
          vertical: VisualDensity.minimumDensity,
        ),
      ),
    );
  }
}
