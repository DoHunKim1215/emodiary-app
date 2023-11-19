import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DiaryWritingLoadingScreen extends StatefulWidget {
  const DiaryWritingLoadingScreen({super.key});

  @override
  State<DiaryWritingLoadingScreen> createState() =>
      _DiaryWritingLoadingScreenState();
}

class _DiaryWritingLoadingScreenState extends State<DiaryWritingLoadingScreen> {
  late Timer _titleTimer;
  bool _titleToggle = false;

  @override
  void initState() {
    super.initState();

    _titleTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _titleToggle = !_titleToggle;
      });

      if (_.tick == 3) {
        Get.toNamed("/writing/select");
      }
    });
  }

  @override
  void dispose() {
    _titleTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: false,
          body: Stack(
            fit: StackFit.expand,
            alignment: AlignmentDirectional.topCenter,
            children: [
              Positioned(
                bottom: 0,
                child: Image.asset(
                  "assets/images/illustration.png",
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height / 5,
                child: AnimatedOpacity(
                  opacity: _titleToggle ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 500),
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
              ),
              Positioned(
                top: MediaQuery.of(context).size.height / 5,
                child: AnimatedOpacity(
                  opacity: _titleToggle ? 0.0 : 1.0,
                  duration: const Duration(milliseconds: 500),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
