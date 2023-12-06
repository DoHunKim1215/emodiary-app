import 'package:flutter/material.dart';

class NewPageErrorIndicator extends StatelessWidget {
  final void Function() onTryAgain;

  const NewPageErrorIndicator({
    super.key,
    required this.onTryAgain,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 0.0),
      child: Column(
        children: [
          const Text(
            "다음 일기를 불러오는데 실패했습니다.\n다시 시도하려면 탭하세요.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.0,
              color: Color(0xFF656D78),
              fontWeight: FontWeight.w500,
            ),
          ),
          TextButton.icon(
            onPressed: onTryAgain,
            style: TextButton.styleFrom(
              backgroundColor: const Color(0xFFF5F7FA),
              splashFactory: NoSplash.splashFactory,
              padding: const EdgeInsets.all(10.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            icon: const Icon(
              Icons.refresh,
              size: 21,
            ),
            label: const Text(
              "다시 불러오기",
              style: TextStyle(
                color: Color(0xFF787A93),
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
