import 'package:flutter/material.dart';
import 'package:jobs/UI/theme/theme.dart';

enum AuthFormType { signIn, signUp }

class AuthForm extends StatelessWidget {
  final List<Widget> children;
  final double width;

  const AuthForm({
    super.key,
    required this.children,
    this.width = 400,
  });

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: neutralColor300,
    );
    return Container(
      decoration: decoration,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      width: width,
      child: Column(
        children: [
          const SizedBox(height: 22),
          ...children,
        ],
      ),
    );
  }
}
