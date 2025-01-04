import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jobs/UI/theme/theme.dart';

class CountryTile extends StatelessWidget {
  final String countryId;
  final String countryName;
  final String flagAsset;
  final String? selectedCountryId;
  final ValueChanged<String?>? onChanged;

  const CountryTile({
    super.key,
    required this.countryId,
    required this.countryName,
    required this.flagAsset,
    required this.selectedCountryId,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = countryId == selectedCountryId;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: isSelected ? primaryColor : neutralColor600,
          width: 1.5,
        ),
      ),
      clipBehavior: Clip.hardEdge, // Важно для InkWell эффекта
      child: Ink(
        child: InkWell(
          onTap: () => onChanged?.call(countryId),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                const SizedBox(width: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SvgPicture.asset(
                    flagAsset,
                    width: 46,
                    height: 46,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    countryName,
                    style: AppTextStyles.textXLSemibold,
                  ),
                ),
                Radio<String>(
                  value: countryId,
                  groupValue: selectedCountryId,
                  onChanged: onChanged,
                  activeColor: primaryColor,
                  fillColor: WidgetStateProperty.all<Color>(primaryColor),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: const VisualDensity(
                    horizontal: VisualDensity.minimumDensity,
                    vertical: VisualDensity.minimumDensity,
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
