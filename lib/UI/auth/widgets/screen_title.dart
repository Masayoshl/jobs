import 'package:flutter/material.dart';

class ScreenTitle extends StatelessWidget {
  const ScreenTitle({
    required this.text,
    super.key,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 32),
      child: Text(
        text,
        style: const TextStyle(
            fontFamily: 'JosefinSans',
            fontWeight: FontWeight.w600,
            fontSize: 40,
            color: Colors.black),
        textAlign: TextAlign.center,
      ),
    );
  }
}
