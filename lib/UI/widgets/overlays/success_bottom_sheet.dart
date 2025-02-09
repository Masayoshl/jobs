import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jobs/UI/theme/theme.dart';
import 'package:jobs/UI/widgets/confirm_button.dart';
import 'package:jobs/gen/assets.gen.dart';

class SuccessBottomSheet extends StatelessWidget {
  final String message;
  final String? title;
  final String? buttonText;
  final Function(BuildContext) onPressedAction;

  const SuccessBottomSheet({
    super.key,
    required this.message,
    required this.onPressedAction,
    this.title,
    this.buttonText,
  });

  static void show({
    required BuildContext context,
    required String message,
    required Function(BuildContext) onPressedAction,
    String? title,
    String? buttonText,
  }) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (context) => SuccessBottomSheet(
        message: message,
        onPressedAction: onPressedAction,
        title: title,
        buttonText: buttonText,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            Assets.images.createPasswordCongratImage,
            width: 300,
            height: 200,
          ),
          const SizedBox(height: 6),
          Text(
            title ?? 'Congratulations !!',
            style: AppTextStyles.headlineXLMobileBold,
          ),
          const SizedBox(height: 20),
          Text(
            message,
            textAlign: TextAlign.center,
            style: AppTextStyles.textXLMedium.copyWith(color: grayColor100),
          ),
          ConfirmButton(
            backgroundColor: purple400,
            top: 24,
            bottom: 8,
            left: 32,
            right: 32,
            onPressed: onPressedAction,
            text: buttonText ?? 'Continue',
          )
        ],
      ),
    );
  }
}
