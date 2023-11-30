import 'package:flutter/material.dart';

class NoSplashIconButton extends StatelessWidget {
  final void Function() onPressed;
  final Widget icon;

  const NoSplashIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      style: IconButton.styleFrom(
        splashFactory: NoSplash.splashFactory,
      ),
      onPressed: onPressed,
      icon: icon,
    );
  }
}
