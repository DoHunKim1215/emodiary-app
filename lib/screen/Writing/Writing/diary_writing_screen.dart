import 'package:emodiary/screen/Writing/Writing/Widget/diary_title_field.dart';
import 'package:emodiary/screen/Writing/Writing/Widget/diary_writing_back_card.dart';
import 'package:emodiary/screen/Writing/Writing/Widget/diary_writing_card.dart';
import 'package:emodiary/viewModel/Writing/diary_writing_view_model.dart';
import 'package:emodiary/widget/base/common_bottom_button.dart';
import 'package:emodiary/widget/Writing/diary_writing_appbar.dart';
import 'package:emodiary/widget/Writing/diary_confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiaryWritingScreen extends StatefulWidget {
  const DiaryWritingScreen({super.key});

  @override
  State<DiaryWritingScreen> createState() => _DiaryWritingScreenState();
}

class _DiaryWritingScreenState extends State<DiaryWritingScreen> {
  final DiaryWritingViewModel vm = Get.put(
    DiaryWritingViewModel(),
    permanent: true,
  );

  void refresh(String _) {
    setState(() {});
  }

  void onTapBack() {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: const Color.fromRGBO(98, 98, 114, 0.4),
      builder: (BuildContext context) {
        return DiaryConfirmDialog(
          question: "일기를 그만 작성하시겠습니까?",
          cancel: "취소",
          confirm: "그만쓰기",
          cancelAction: () {
            Get.back();
          },
          confirmAction: () {
            Get.back();
            Get.delete<DiaryWritingViewModel>(force: true);
            Get.offAllNamed("/");
          },
        );
      },
    );
  }

  void onTapSend() {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: const Color.fromRGBO(98, 98, 114, 0.4),
      builder: (BuildContext context) {
        return DiaryConfirmDialog(
          question: "일기를 전송하시겠습니까?",
          cancel: "취소하기",
          confirm: "전송하기",
          cancelAction: () {
            Get.back();
          },
          confirmAction: () {
            Get.toNamed("/writing/loading");
          },
        );
      },
    );
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
            child: DiaryWritingAppBar(
              title: '2023.11.19',
              onPressedLeading: onTapBack,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              children: [
                DiaryTitleField(viewModel: vm),
                const SizedBox(
                  height: 20.0,
                ),
                Expanded(
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        right: 0,
                        top: 40,
                        child: DiaryWritingBackCard(
                          viewModel: vm,
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        bottom: 64,
                        child: DiaryWritingCard(
                          viewModel: vm,
                          refresh: refresh,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CommonBottomButton(
                        text: "그림 일기를 받아볼게요!",
                        disabledText: "일기를 작성하면 그림을 볼 수 있어요!",
                        onPressed:
                            vm.canSendTitleAndContent() ? onTapSend : null,
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
