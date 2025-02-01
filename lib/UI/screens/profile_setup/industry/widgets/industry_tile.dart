import 'package:flutter/material.dart';
import 'package:jobs/UI/theme/theme.dart';
import 'package:jobs/UI/widgets/selectable_tile/selectable_tile.dart';
import 'package:jobs/domain/entity/industry.dart';

class IndustryTile extends SelectableTile {
  final Industry industry;
  final ValueChanged<Industry>? onChanged;

  IndustryTile({
    super.key,
    required this.industry,
    String? selectedIndustryId,
    this.onChanged,
  }) : super(
          id: industry.id.toString(),
          selectedId: selectedIndustryId,
          onTap: onChanged != null ? () => onChanged(industry) : null,
        );

  @override
  Widget buildLeadingWidget(bool isSelected) {
    return const SizedBox.shrink();
  }

  @override
  Widget buildTitleWidget(bool isSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        industry.title,
        style: AppTextStyles.textXLSemibold,
      ),
    );
  }
}
