import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jobs/UI/theme/theme.dart';
import 'package:jobs/gen/assets.gen.dart';

class CustomRadioButton extends StatelessWidget {
  final String phone;
  final String email;
  final String selectedType; // 'sms' или 'email'
  final ValueChanged<String> onSelected;

  const CustomRadioButton({
    Key? key,
    required this.phone,
    required this.email,
    required this.selectedType,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomRadioButtonItem(
          label: 'via sms',
          value: 'sms',
          isSelected: selectedType == 'sms',
          icon: Assets.images.forgotPasswordChatImage,
          content: phone,
          onSelected: onSelected,
        ),
        CustomRadioButtonItem(
          label: 'via email',
          value: 'email',
          isSelected: selectedType == 'email',
          icon: Assets.images.forgotPasswordMailImage,
          content: email,
          onSelected: onSelected,
        ),
      ],
    );
  }
}

class CustomRadioButtonItem extends StatelessWidget {
  final String label;
  final String value;
  final bool isSelected;
  final String icon;
  final String content;
  final ValueChanged<String> onSelected;

  const CustomRadioButtonItem({
    Key? key,
    required this.label,
    required this.value,
    required this.isSelected,
    required this.icon,
    required this.content,
    required this.onSelected,
  }) : super(key: key);

  // CustomRadioButton(
  //   phone: '+6396*****92',
  //   email: 'Jor***.domain.com',
  //   selectedType: selectedType,
  //   onSelected: (type) {
  //     setState(() {
  //       selectedType = type;
  //     });
  //   },
  // ),

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onSelected(value),
      child: Container(
        width: 290,
        height: 84,
        margin: const EdgeInsets.only(bottom: 24, right: 74),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: neutralColor200,
          border: isSelected ? Border.all(color: primaryColor, width: 2) : null,
        ),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 12, right: 8),
              child: SvgPicture.asset(icon),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: AppTextStyles.textXLRegular
                      .copyWith(color: isSelected ? Colors.blue : grayColor25),
                ),
                Text(
                  content,
                  style: AppTextStyles.textXLRegular
                      .copyWith(color: isSelected ? Colors.blue : grayColor100),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
