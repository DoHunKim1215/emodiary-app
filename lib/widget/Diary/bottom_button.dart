import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;

  const BottomButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final disabled = onPressed == null;

    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: backgroundColor,
        splashFactory: NoSplash.splashFactory,
        padding: const EdgeInsets.symmetric(
          vertical: 18.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
          height: 1,
        ),
      ),
    );
  }
}
