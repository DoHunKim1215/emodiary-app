import 'dart:async';

import 'package:emodiary/widget/Writing/title_linear_fade_curve.dart';
import 'package:flutter/material.dart';

class DiaryWritingLoadingText extends StatefulWidget {
  const DiaryWritingLoadingText({super.key});

  @override
  State<DiaryWritingLoadingText> createState() =>
      _DiaryWritingLoadingTextState();
}

class _DiaryWritingLoadingTextState extends State<DiaryWritingLoadingText> {
  late Timer _titleTimer;
  bool _titleToggle = false;

  @override
  void initState() {
    super.initState();

    _titleTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      setState(() {
        _titleToggle = !_titleToggle;
      });
    });
  }

  @override
  void dispose() {
    _titleTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        AnimatedOpacity(
          opacity: _titleToggle ? 0.0 : 1.0,
          curve: TitleLinearFadeCurve(isFadeOut: _titleToggle),
          duration: const Duration(seconds: 1),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "슥삭슥삭",
                style: TextStyle(
                  color: Color(0xFF7541EF),
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  height: 2.4375,
                ),
              ),
            ],
          ),
        ),
        AnimatedOpacity(
          opacity: _titleToggle ? 1.0 : 0.0,
          curve: TitleLinearFadeCurve(isFadeOut: !_titleToggle),
          duration: const Duration(seconds: 1),
          child: const Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "오늘의 추억",
                    style: TextStyle(
                      color: Color(0xFF7541EF),
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      height: 1.625,
                    ),
                  ),
                  Text(
                    "을",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      height: 1.625,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "그림",
                    style: TextStyle(
                      color: Color(0xFF7541EF),
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      height: 1.625,
                    ),
                  ),
                  Text(
                    "으로 그리고 있어요",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      height: 1.625,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
