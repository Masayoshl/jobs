import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jobs/UI/theme/theme.dart';
import 'package:jobs/gen/assets.gen.dart';

class ProfileAvatarFrame extends StatelessWidget {
  static const double imageRadius = 108.0;
  static const double frameRadius = 128.0;

  const ProfileAvatarFrame({
    this.file,
    super.key,
    this.onTap,
  });
  final String? file;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    Widget imageWidget;

    if (file != null) {
      imageWidget = ClipRRect(
        borderRadius: BorderRadius.circular(imageRadius),
        child: Image.file(
          File(file!),
          width: frameRadius * 2,
          height: frameRadius * 2,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) =>
              const DefaultProfileImage(),
        ),
      );
    } else {
      imageWidget = ClipRRect(
        borderRadius: BorderRadius.circular(imageRadius),
        child: const DefaultProfileImage(),
      );
    }

    return Material(
      borderOnForeground: true,
      borderRadius: BorderRadius.circular(frameRadius),
      color: Colors.transparent,
      elevation: 8,
      child: Ink(
        decoration: BoxDecoration(
          color: primaryColor25,
          borderRadius: BorderRadius.circular(frameRadius),
        ),
        child: InkWell(
          splashColor: primaryColor500.withValues(alpha: 0.6),
          highlightColor: primaryColor500.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(frameRadius),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(frameRadius - imageRadius),
            child: CircleAvatar(
              backgroundColor: primaryColor50,
              radius: imageRadius,
              child: imageWidget,
            ),
          ),
        ),
      ),
    );
  }
}

class DefaultProfileImage extends StatelessWidget {
  const DefaultProfileImage({
    super.key,
    this.width = ProfileAvatarFrame.frameRadius * 2,
    this.height = ProfileAvatarFrame.frameRadius * 2,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      Assets.images.defaultProfileImage.path,
      width: width,
      height: height,
      fit: BoxFit.cover,
    );
  }
}
