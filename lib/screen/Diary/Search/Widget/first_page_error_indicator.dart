import 'package:flutter/material.dart';

class FirstPageErrorIndicator extends StatelessWidget {
  final void Function() onTryAgain;

  const FirstPageErrorIndicator({
    super.key,
    required this.onTryAgain,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/icons/failure.png",
            width: MediaQuery.of(context).size.width / 2,
          ),
          const SizedBox(
            height: 32,
          ),
          const Text(
            "일기 목록을 불러오는데\n실패했습니다.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Color(0xFF656D78),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 32,
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
