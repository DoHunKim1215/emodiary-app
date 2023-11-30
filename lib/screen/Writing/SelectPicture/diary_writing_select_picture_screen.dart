import 'package:emodiary/screen/Writing/SelectPicture/Widget/picture_box.dart';
import 'package:emodiary/widget/base/common_bottom_button.dart';
import 'package:emodiary/viewModel/Writing/diary_writing_view_model.dart';
import 'package:emodiary/widget/Writing/diary_writing_appbar.dart';
import 'package:emodiary/widget/base/loading_bottom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:emodiary/widget/Writing/diary_confirm_dialog.dart';

class DiaryWritingSelectPictureScreen extends StatefulWidget {
  const DiaryWritingSelectPictureScreen({super.key});

  @override
  State<DiaryWritingSelectPictureScreen> createState() =>
      _DiaryWritingSelectPictureScreenState();
}

class _DiaryWritingSelectPictureScreenState
    extends State<DiaryWritingSelectPictureScreen> {
  final DiaryWritingViewModel vm = Get.find<DiaryWritingViewModel>();
  bool isLoading = false;

  void onTapBack() {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: const Color.fromRGBO(98, 98, 114, 0.4),
      builder: (BuildContext context) {
        return DiaryConfirmDialog(
          question: "일기 작성을 그만 하시겠습니까?",
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
    setState(() {
      isLoading = true;
    });

    vm.diaryWritingProvider
        .createDiary(
      vm.titleCtrl.text,
      vm.contentCtrl.text,
      vm.pictures[vm.getSelectedPicture()!],
    )
        .then((value) {
      setState(() {
        isLoading = false;
      });

      Get.toNamed("/writing/save");
    }).onError((error, stackTrace) {
      setState(() {
        isLoading = false;
      });

      Get.snackbar(
        '🥲 일기를 저장하는데 실패했습니다.',
        '일기 내용이 적거나 의미가 분명하지 않으면 감정을 파악하기 힘들어요',
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        duration: const Duration(milliseconds: 1500),
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFFF5F5F9),
        colorText: Colors.black,
      );

      Get.delete<DiaryWritingViewModel>(force: true);
      Get.toNamed("/");
    });
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
              title: '나의 하루 그림일기',
              onPressedLeading: isLoading ? null : onTapBack,
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
                      vm.pictures.length < 4
                          ? const Text(
                              "그림을 받아오는데 실패했어요...",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                height: 1.625,
                              ),
                            )
                          : const Column(
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
                                pictureNumber: 0,
                                viewModel: vm,
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              PictureBox(
                                pictureNumber: 1,
                                viewModel: vm,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Row(
                            children: [
                              PictureBox(
                                pictureNumber: 2,
                                viewModel: vm,
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              PictureBox(
                                pictureNumber: 3,
                                viewModel: vm,
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Obx(
                        () => isLoading
                            ? const LoadingBottomButton()
                            : CommonBottomButton(
                                disabledText: vm.pictures.length >= 4
                                    ? "오늘 하루와 어울리는 그림은 무엇인가요?"
                                    : "일기를 생성할 수 없어요...",
                                text: "이 그림으로 저장할래요!",
                                onPressed:
                                    vm.pictures.length >= 4 && vm.isSelected()
                                        ? onTapSend
                                        : null,
                              ),
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
