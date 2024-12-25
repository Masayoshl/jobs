import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../../theme/theme.dart';

List<BoxShadow> _getShadow(Color color) {
  return [
    BoxShadow(
      color: color,
      spreadRadius: 0,
      blurRadius: 0,
      offset: const Offset(0, 3.5),
    ),
    // BoxShadow(
    //   color: color,
    //   blurStyle: BlurStyle.normal,
    //   offset: const Offset(0, -1.5),
    // ),
  ];
}

PinTheme _getTheme(Color color) {
  return PinTheme(
    padding: const EdgeInsets.only(left: 16, right: 16),
    textStyle: TextStyle(
      fontFamily: 'JosefinSans',
      fontWeight: FontWeight.w600,
      fontSize: 22,
      letterSpacing: 0,
      height: 1.0,
      color: color,
    ),
    width: 59,
    height: 62,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(7),
        boxShadow: _getShadow(color)),
  );
}

class OTPTextField extends StatelessWidget {
  final bool isHaveError;
  final String? errorText;
  final void Function(String)? onChanged;
  const OTPTextField(
      {super.key,
      required this.isHaveError,
      required this.onChanged,
      this.errorText});

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      padding: const EdgeInsets.only(left: 16, right: 16),
      textStyle: const TextStyle(
        fontFamily: 'JosefinSans',
        fontWeight: FontWeight.w600,
        fontSize: 22,
        letterSpacing: 0,
        height: 1.0,
        color: primaryColor,
      ),
      width: 59,
      height: 62,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(7),
        boxShadow: _getShadow(
          const Color(0xffEBEBEB),
        ),
      ),
    );

    final errorPinTheme = _getTheme(errorColor700);

    final focusedPinTheme = _getTheme(primaryColor300);

    return Container(
      margin: const EdgeInsets.only(top: 39, bottom: 28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(7),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(60, 86, 217, 0.03),
            //rgba(60, 85, 217, 0.03)
            spreadRadius: 9,
            blurRadius: 12,
            offset: Offset(0, 20),
          ),
        ],
      ),
      child: Pinput(
        animationCurve: Curves.easeOut,
        textInputAction: TextInputAction.next,
        errorText: errorText,
        forceErrorState: isHaveError,
        errorPinTheme: errorPinTheme,
        focusedPinTheme: focusedPinTheme,
        defaultPinTheme: defaultPinTheme,
        onChanged: onChanged,
      ),
    );
  }
}
