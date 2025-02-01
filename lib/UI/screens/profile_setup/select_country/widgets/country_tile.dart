import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:jobs/UI/theme/theme.dart';
import 'package:jobs/UI/widgets/selectable_tile/selectable_tile.dart';
import 'package:jobs/domain/entity/country.dart';

class CountryTile extends SelectableTile {
  final Country country;
  final ValueChanged<Country>? onChanged;

  CountryTile({
    super.key,
    required this.country,
    String? selectedCountryId,
    this.onChanged,
  }) : super(
          id: country.code,
          selectedId: selectedCountryId,
          onTap: onChanged != null ? () => onChanged(country) : null,
        );

  @override
  Widget buildLeadingWidget(bool isSelected) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: SvgPicture.asset(
          country.flag4x3,
          width: 46,
          height: 46,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  @override
  Widget buildTitleWidget(bool isSelected) {
    return Text(
      country.name,
      style: AppTextStyles.textXLSemibold,
    );
  }
}
