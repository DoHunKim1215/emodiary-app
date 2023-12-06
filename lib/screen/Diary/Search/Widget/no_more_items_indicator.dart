import 'package:flutter/material.dart';

class NoMoreItemsIndicator extends StatelessWidget {
  const NoMoreItemsIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 0.0),
      child: Column(
        children: [
          Text(
            "더 이상 볼러올 일기가 없습니다.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.0,
              color: Color(0xFF656D78),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
