import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jobs/UI/theme/theme.dart';
import 'package:jobs/gen/assets.gen.dart';

class EmptySearchState extends StatelessWidget {
  const EmptySearchState({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(Assets.images.notFoundImage),
          const SizedBox(
            height: 32,
          ),
          const Text(
            'No Match Found',
            style: AppTextStyles.displayTextSemibold,
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            textAlign: TextAlign.center,
            'Sorry, The Keyword you are looking for is not found. Please Try with different keyword',
            style: AppTextStyles.textXLRegular.copyWith(color: grayColor50),
          ),
        ],
      ),
    );
  }
}
