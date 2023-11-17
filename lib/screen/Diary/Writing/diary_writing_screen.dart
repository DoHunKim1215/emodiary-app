import 'dart:ui';

import 'package:emodiary/widget/Diary/diary_appbat.dart';
import 'package:flutter/material.dart';

class DiaryWritingScreen extends StatelessWidget {
  const DiaryWritingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: false,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: DiaryAppBar(
              title: '2023.06',
              onPressed: () {},
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              children: [
                const TextField(
                  decoration: InputDecoration(
                    hintText: '일기 제목을 입력해주세요',
                    hintStyle: TextStyle(
                      color: Color(0xFF787A93),
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFFFD66C),
                        width: 3.0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        left: 0,
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 22.5, sigmaY: 22.5),
                          child: Container(
                            width: MediaQuery.of(context).size.width - 70.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              border: Border.all(
                                width: 2.0,
                                color: const Color(0xFFF1F0F5),
                              ),
                              gradient: const LinearGradient(
                                begin: Alignment(1, 1),
                                end: Alignment(0, 0),
                                colors: <Color>[
                                  Color.fromRGBO(242, 235, 253, 0.3),
                                  Color.fromRGBO(241, 240, 245, 0.3),
                                ],
                                tileMode: TileMode.mirror,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          width: MediaQuery.of(context).size.width - 70.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: const Color(0xFFFFE76A),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
