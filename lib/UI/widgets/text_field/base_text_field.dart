import 'package:flutter/material.dart';
import 'package:jobs/UI/theme/theme.dart';
import 'package:jobs/UI/widgets/text_field/prefix_icon.dart';

abstract class _TextFieldColor {
  static const _errorColor = errorColor700;
  static const _focusedColor = primaryColor300;
  static const _defaultColor = grayColor25;

  static final defaultBorder = BoxShadow(
    color: _defaultColor.withValues(alpha: 0.4),
    spreadRadius: 1,
    blurRadius: 1,
    blurStyle: BlurStyle.normal,
    offset: const Offset(0, 2),
  );

  static const focusSolidBorder = BoxShadow(
    color: _focusedColor,
    spreadRadius: 0.3,
    blurRadius: 0,
    blurStyle: BlurStyle.solid,
    offset: Offset(0, 3),
  );

  static const errorSolidBorder = BoxShadow(
    color: _errorColor,
    spreadRadius: 0.3,
    blurRadius: 0,
    blurStyle: BlurStyle.solid,
    offset: Offset(0, 2),
  );

  static List<BoxShadow> getBorderColor(bool isError, FocusNode focusNode) {
    if (isError) {
      return [defaultBorder, errorSolidBorder];
    }
    return focusNode.hasFocus
        ? [defaultBorder, focusSolidBorder]
        : [defaultBorder];
  }

  static Color getIconColor(bool isError, FocusNode focusNode, bool isEnabled) {
    if (!isEnabled) return _defaultColor;
    if (isError) return _errorColor;
    return focusNode.hasFocus ? _focusedColor : _defaultColor;
  }
}

abstract class BaseTextField extends StatefulWidget {
  final String hintText;
  final String prefixIcon;
  final double? bottom;
  final double? top;
  final double? left;
  final double? right;
  final String? errorText;
  final bool error;
  final void Function(String)? onChanged;
  final double? width;
  final double? height;
  final bool isEnabled;

  const BaseTextField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    required this.error,
    this.bottom,
    this.top,
    this.left,
    this.right,
    this.onChanged,
    this.errorText,
    this.width = 360,
    this.height = 74,
    this.isEnabled = true,
  });
}

abstract class BaseTextFieldState<T extends BaseTextField> extends State<T> {
  final _focusNode = FocusNode();
  late Color _iconColor;
  FocusNode get focusNode => _focusNode;
  Color get iconColor => _iconColor;

  @override
  void initState() {
    super.initState();
    _iconColor = _TextFieldColor.getIconColor(
        widget.error, _focusNode, widget.isEnabled);
    _focusNode.addListener(() {
      setState(() {
        _iconColor = _TextFieldColor.getIconColor(
            widget.error, _focusNode, widget.isEnabled);
      });
    });
  }

  @override
  void didUpdateWidget(covariant T oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.error != widget.error ||
        oldWidget.isEnabled != widget.isEnabled) {
      setState(() {
        _iconColor = _TextFieldColor.getIconColor(
            widget.error, _focusNode, widget.isEnabled);
      });
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  InputDecoration buildInputDecoration(PrefixIcon prefixIcon);

  BoxDecoration buildBoxDecoration(List<BoxShadow> borderColor);

  @override
  Widget build(BuildContext context) {
    final borderColor =
        _TextFieldColor.getBorderColor(widget.error, _focusNode);
    final prefixIcon =
        PrefixIcon(iconPath: widget.prefixIcon, iconColor: _iconColor);
    final themeData = Theme.of(context).copyWith(
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: _iconColor,
        selectionColor: _iconColor.withValues(alpha: 0.2),
        selectionHandleColor: _iconColor,
      ),
    );
    return Theme(
      data: themeData,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            margin: EdgeInsets.only(
              left: widget.left ?? 18,
              right: widget.right ?? 18,
              bottom: widget.error ? widget.bottom ?? 4 : 20,
            ),
            width: widget.width,
            height: widget.height,
            decoration: buildBoxDecoration(borderColor),
            child: Center(
              child: buildTextField(prefixIcon),
            ),
          ),
          _ErrorWidget(
            isError: widget.error,
            errorText: widget.errorText,
          ),
          const SizedBox(
            height: 4,
          )
        ],
      ),
    );
  }

  Widget buildTextField(PrefixIcon prefixIcon);
}

class _ErrorWidget extends StatelessWidget {
  final bool isError;
  final String? errorText;

  const _ErrorWidget({required this.isError, this.errorText});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      tween: Tween<double>(
        begin: 0.0,
        end: (isError && errorText != null) ? 1.0 : 0.0,
      ),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Container(
            height: value * 20, // Регулируем высоту контейнера
            padding: const EdgeInsets.only(left: 32),
            child: Text(
              errorText ?? '',
              style: AppTextStyles.textM.copyWith(color: errorColor700),
            ),
          ),
        );
      },
    );
  }
}
