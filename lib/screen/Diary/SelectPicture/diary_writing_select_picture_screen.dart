import 'package:emodiary/screen/Diary/SelectPicture/Widget/picture_box.dart';
import 'package:emodiary/screen/Diary/Writing/Widget/diary_writing_bottom_button.dart';
import 'package:emodiary/widget/Diary/diary_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widget/Diary/diary_confirm_dialog.dart';

class DiaryWritingSelectPictureScreen extends StatefulWidget {
  const DiaryWritingSelectPictureScreen({super.key});

  @override
  State<DiaryWritingSelectPictureScreen> createState() =>
      _DiaryWritingSelectPictureScreenState();
}

class _DiaryWritingSelectPictureScreenState
    extends State<DiaryWritingSelectPictureScreen> {
  int? _selectedPicture;

  void onTapBack() {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: const Color.fromRGBO(98, 98, 114, 0.4),
      builder: (BuildContext context) {
        return DiaryConfirmDialog(
          question: "일기를 다시 작성하시겠습니까?",
          cancel: "취소",
          confirm: "다시쓰기",
          cancelAction: () {
            Get.back();
          },
          confirmAction: () {
            Get.back();
            Get.until((Route route) => Get.currentRoute == "/writing");
          },
        );
      },
    );
  }

  void onTapSend() {
    Get.toNamed("/");
  }

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
              title: '나의 하루 그림일기',
              onPressed: onTapBack,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      /* Title Text */
                      const Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "마음에 드는 그림",
                                style: TextStyle(
                                  color: Color(0xFF7541EF),
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  height: 1.625,
                                ),
                              ),
                              Text(
                                "을 골라",
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
                                "오늘 하루를 저장해보세요!",
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
                      /* Pictures */
                      Column(
                        children: [
                          Row(
                            children: [
                              PictureBox(
                                imagePath: 'assets/images/ex1.png',
                                isSelected: _selectedPicture == 0,
                                onTap: () {
                                  setState(() {
                                    _selectedPicture = 0;
                                  });
                                },
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              PictureBox(
                                imagePath: 'assets/images/ex2.png',
                                isSelected: _selectedPicture == 1,
                                onTap: () {
                                  setState(() {
                                    _selectedPicture = 1;
                                  });
                                },
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Row(
                            children: [
                              PictureBox(
                                imagePath: 'assets/images/ex3.png',
                                isSelected: _selectedPicture == 2,
                                onTap: () {
                                  setState(() {
                                    _selectedPicture = 2;
                                  });
                                },
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              PictureBox(
                                imagePath: 'assets/images/ex4.png',
                                isSelected: _selectedPicture == 3,
                                onTap: () {
                                  setState(() {
                                    _selectedPicture = 3;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: DiaryWritingBottomButton(
                        onPressed: _selectedPicture == null ? null : onTapSend,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
