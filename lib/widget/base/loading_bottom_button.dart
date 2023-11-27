import 'package:flutter/material.dart';

class LoadingBottomButton extends StatelessWidget {
  const LoadingBottomButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: null,
      style: TextButton.styleFrom(
        backgroundColor: const Color(0xFFF5F7FA),
        splashFactory: NoSplash.splashFactory,
        padding: const EdgeInsets.symmetric(
          vertical: 18.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: const SizedBox(
        height: 18,
        width: 18,
        child: CircularProgressIndicator(
          color: Color(0xFFAAB2BD),
        ),
      ),
    );
  }
}
