import 'package:flutter/material.dart';

class ThinBottomButton extends StatelessWidget {
  final void Function() onPressed;
  final String text;
  final bool isReversed;

  const ThinBottomButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.isReversed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: isReversed ? Colors.white : const Color(0xFF7541EF),
        foregroundColor: const Color(0xFF7541EF),
        splashFactory: NoSplash.splashFactory,
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
        ),
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Color(0xFF7541EF),
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(6.0),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isReversed ? const Color(0xFF7541EF) : Colors.white,
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
          height: 1.44,
        ),
      ),
    );
  }
}
