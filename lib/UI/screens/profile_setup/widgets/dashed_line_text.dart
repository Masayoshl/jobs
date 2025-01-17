import 'package:flutter/material.dart';
import 'package:jobs/UI/theme/theme.dart';

class DashedLineText extends StatelessWidget {
  final String title;

  const DashedLineText({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style:
              AppTextStyles.displayTextSemibold.copyWith(color: Colors.black),
          textAlign: TextAlign.start,
        ),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          width: double.maxFinite,
          child: CustomPaint(
            painter: DashedLinePainter(),
          ),
        ),
      ],
    );
  }
}

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 9, dashSpace = 5, startX = 0;
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
