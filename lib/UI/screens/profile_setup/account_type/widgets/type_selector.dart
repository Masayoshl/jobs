import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jobs/UI/theme/theme.dart';

abstract interface class TypeSelectorEnum {
  String get title;
  String get subtitle;
  String get icon;
}

class TypeSelector<T extends TypeSelectorEnum> extends StatelessWidget {
  final Function(T) onSelected;
  final T selectedType;
  final List<T> values;

  const TypeSelector({
    super.key,
    required this.onSelected,
    required this.selectedType,
    required this.values,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: values
          .map((type) => TypeSelectorItem(
                title: type.title,
                subTitle: type.subtitle,
                isSelected: selectedType == type,
                icon: type.icon,
                onTap: () {
                  onSelected(type);
                },
              ))
          .toList(),
    );
  }
}

class TypeSelectorItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final String icon;
  final String subTitle;
  final VoidCallback onTap;

  const TypeSelectorItem({
    Key? key,
    required this.title,
    required this.isSelected,
    required this.icon,
    required this.subTitle,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
        border: isSelected
            ? Border.all(color: purple400, width: 1)
            : Border.all(color: grayColor50, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 0),
          )
        ]);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 173,
        height: 269,
        decoration: decoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 60, bottom: 8),
              child: SvgPicture.asset(
                icon,
                width: 100,
                height: 100,
              ),
            ),
            Text(
              title,
              style: AppTextStyles.textXXLSemibold,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Text(
                subTitle,
                textAlign: TextAlign.center,
                style: AppTextStyles.textM
                    .copyWith(color: grayColor25, fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
