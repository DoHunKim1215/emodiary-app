import 'package:flutter/material.dart';

class DiaryWritingSaveBackCard extends StatelessWidget {
  const DiaryWritingSaveBackCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 40.0,
      height: 338,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: const Color(0xFFFFE76A),
      ),
    );
  }
}
