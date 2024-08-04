import 'package:flutter/material.dart';

import '../styles/index.dart';

class RippleEffectButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPress;
  const RippleEffectButton({required this.child, this.onPress, super.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned.fill(
            child: Theme(
          data: ThemeData(splashColor: AppColors.primaryColor.withAlpha(70)),
          child: Material(
            color: Colors.transparent,
            child: InkWell(onTap: onPress, child: Container()),
          ),
        ))
      ],
    );
  }
}
