import 'package:flutter/material.dart';

class DiaryWritingBottomButton extends StatelessWidget {
  final void Function()? onPressed;

  const DiaryWritingBottomButton({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final disabled = onPressed == null;

    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor:
            disabled ? const Color(0xFFF5F7FA) : const Color(0xFF7541EF),
        splashFactory: NoSplash.splashFactory,
        padding: const EdgeInsets.symmetric(
          vertical: 18.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: Text(
        disabled ? "일기를 작성하면 그림을 볼 수 있어요!" : "그림 일기를 받아볼게요!",
        style: TextStyle(
          color: disabled ? const Color(0xFFAAB2BD) : const Color(0xFFFFFFFF),
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
          height: 1,
        ),
      ),
    );
  }
}
