import 'package:todos/presentation/styles/index.dart';
import 'package:flutter/material.dart';

class ErrorMessageWidget extends StatelessWidget {
  final String error;
  final TextStyle? style;

  const ErrorMessageWidget(
    this.error, {
    this.style,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      error,
      maxLines: 10,
      style: style ?? labelSmall.copyWith(color: Colors.red),
    );
  }
}
