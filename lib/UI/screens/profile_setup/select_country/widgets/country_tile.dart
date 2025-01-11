import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:jobs/UI/theme/theme.dart';
import 'package:jobs/domain/entity/country.dart';

class CountryTile extends StatelessWidget {
  final Country country;
  final String? selectedCountryId;
  final ValueChanged<Country>? onChanged;

  const CountryTile({
    super.key,
    required this.country,
    this.selectedCountryId,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = country.code == selectedCountryId;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: isSelected ? primaryColor500 : neutralColor600,
          width: 1.5,
        ),
      ),
      clipBehavior: Clip.hardEdge, // Важно для InkWell эффекта
      child: Ink(
        child: InkWell(
          onTap: () => onChanged?.call(country),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                const SizedBox(width: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SvgPicture.asset(
                    country.flag4x3,
                    width: 46,
                    height: 46,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    country.name,
                    style: AppTextStyles.textXLSemibold,
                  ),
                ),
                IgnorePointer(
                  ignoring: true,
                  child: Radio<String>(
                    value: country.code,
                    groupValue: selectedCountryId,
                    onChanged: (_) => onChanged,
                    activeColor: primaryColor500,
                    fillColor: WidgetStateProperty.all<Color>(primaryColor500),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: const VisualDensity(
                      horizontal: VisualDensity.minimumDensity,
                      vertical: VisualDensity.minimumDensity,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
