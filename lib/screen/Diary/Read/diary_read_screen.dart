import 'package:emodiary/screen/Diary/Read/Widget/diary_back_card.dart';
import 'package:emodiary/screen/Diary/Read/Widget/diary_card.dart';
import 'package:emodiary/viewModel/Diary/diary_read_view_model.dart';
import 'package:emodiary/widget/Writing/diary_confirm_dialog.dart';
import 'package:emodiary/widget/Writing/diary_writing_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DiaryReadScreen extends StatefulWidget {
  const DiaryReadScreen({super.key});

  @override
  State<DiaryReadScreen> createState() => _DiaryReadScreenState();
}

class _DiaryReadScreenState extends State<DiaryReadScreen> {
  final DiaryReadViewModel diaryReadViewModel = Get.put(DiaryReadViewModel());

  bool isShownPicture = true;
  bool isLoading = false;

  void flipCard() {
    setState(() {
      isShownPicture = !isShownPicture;
    });
  }

  void onTapDelete() {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: const Color.fromRGBO(98, 98, 114, 0.4),
      builder: (BuildContext context) {
        return DiaryConfirmDialog(
          question: "일기를 정말 삭제하시겠습니까?",
          cancel: "취소",
          confirm: "삭제하기",
          cancelAction: () {
            Get.back();
          },
          confirmAction: () {
            setState(() {
              isLoading = true;
            });

            diaryReadViewModel.deleteDiary(2).then((value) {
              Get.offAllNamed("/");
            }).onError((error, stackTrace) {
              Get.snackbar(
                '🥲 일기를 삭제하는데 실패했습니다.',
                '알 수 없는 이유로 일기 삭제에 실패했습니다.',
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                duration: const Duration(milliseconds: 1500),
                snackPosition: SnackPosition.TOP,
                backgroundColor: const Color(0xFFF5F5F9),
                colorText: Colors.black,
              );
              Get.offAllNamed("/");
            });
          },
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      isLoading = true;
    });

    diaryReadViewModel.getDiary(2).then((_) {
      setState(() {
        isLoading = false;
      });
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
              title: '2023년 11월 27일',
              onPressedLeading: isLoading
                  ? null
                  : () {
                      Get.offAllNamed("/");
                    },
              onPressedAction: isLoading
                  ? null
                  : () {
                      print("Action!");
                    },
            ),
          ),
          body: isLoading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          const DiaryBackCard(),
                          DiaryCard(
                            viewModel: diaryReadViewModel,
                            isShownPicture: isShownPicture,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            style: IconButton.styleFrom(
                              splashFactory: NoSplash.splashFactory,
                              highlightColor: Colors.transparent,
                            ),
                            onPressed: flipCard,
                            icon: SvgPicture.asset(
                              "assets/icons/rotate-button-icon.svg",
                              width: 60,
                              height: 60,
                            ),
                          ),
                          GestureDetector(
                            onTap: isLoading ? null : onTapDelete,
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.0),
                                color: const Color(0xFFED5565),
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  "assets/icons/bin.svg",
                                  colorFilter: const ColorFilter.mode(
                                    Color(0xFFFFABB5),
                                    BlendMode.srcIn,
                                  ),
                                  width: 34,
                                  height: 34,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
