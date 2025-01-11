import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jobs/UI/theme/theme.dart';
import 'package:jobs/gen/assets.gen.dart';

class CustomSearchBar extends StatelessWidget {
  final void Function(String) onChanged;
  const CustomSearchBar({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(15);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Material(
        elevation: 2.0,
        borderRadius: borderRadius,
        child: TextField(
          decoration: InputDecoration(
            constraints: const BoxConstraints(
                minHeight: 65, maxHeight: 65, maxWidth: 400, minWidth: 400),
            border: OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: const BorderSide(color: Colors.white),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: const BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: const BorderSide(color: Colors.white),
            ),
            hintText: 'Search',
            hintStyle: AppTextStyles.textXLRegular.copyWith(color: grayColor25),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SvgPicture.asset(
                Assets.icons.searchIcon,
                fit: BoxFit.none,
              ),
            ),
            suffixIcon: IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                fit: BoxFit.none,
                Assets.icons.microphoneIcon,
                colorFilter:
                    const ColorFilter.mode(primaryColor500, BlendMode.srcIn),
              ),
            ),
          ),
          onChanged: (query) => onChanged(query),
        ),
      ),
    );
  }
}
