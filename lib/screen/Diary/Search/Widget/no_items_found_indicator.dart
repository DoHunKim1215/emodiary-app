import 'package:flutter/material.dart';

class NoItemsFoundIndicator extends StatelessWidget {
  const NoItemsFoundIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/icons/not-found-icon.png",
            width: MediaQuery.of(context).size.width / 2,
          ),
          const SizedBox(
            height: 32,
          ),
          const Text(
            "아직 작성된 일기가 없습니다.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Color(0xFF656D78),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
