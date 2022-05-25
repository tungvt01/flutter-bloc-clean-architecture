import 'package:flutter/material.dart';
import '../styles/index.dart';

class SolidButton extends StatelessWidget {
  final Color? backgroundColor;
  final double? height;

  final TextStyle? titleStyle;
  final String title;

  final VoidCallback? onPressed;
  final double borderRadius;
  final BorderSide? borderSide;

  const SolidButton({
    required this.title,
    this.height = 44,
    this.backgroundColor,
    this.titleStyle,
    this.onPressed,
    this.borderRadius = 10,
    this.borderSide,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (onPressed != null) {
          onPressed!();
        }
      },
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            //side: borderSide ?? const BorderSide(width: 1)
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(
            backgroundColor ?? AppColors.primaryColor),
      ),
      child: SizedBox(
        height: height,
        child: Center(
          child: Text(title, style: titleStyle ?? titleMedium),
        ),
      ),
    );
  }
}
