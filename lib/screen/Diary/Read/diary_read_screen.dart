import 'package:emodiary/screen/Diary/Read/Widget/diary_has_data_screen.dart';
import 'package:emodiary/screen/Diary/Read/Widget/diary_has_not_data_screen.dart';
import 'package:emodiary/screen/Diary/Read/Widget/diary_loading_screen.dart';
import 'package:emodiary/viewModel/Diary/diary_read_view_model.dart';
import 'package:emodiary/widget/Writing/diary_confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiaryReadScreen extends StatefulWidget {
  const DiaryReadScreen({super.key});

  @override
  State<DiaryReadScreen> createState() => _DiaryReadScreenState();
}

class _DiaryReadScreenState extends State<DiaryReadScreen> {
  final DiaryReadViewModel diaryReadViewModel = Get.put(DiaryReadViewModel());

  int id = -1;
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
                '일기를 삭제하는데 실패했습니다.',
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

  void getDiary(int id) {
    setState(() {
      isLoading = true;
    });

    diaryReadViewModel.getDiary(id).then((_) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();

    if (Get.arguments == null) {
      Get.back();
    } else {
      setState(() {
        id = Get.arguments["id"];
      });
      getDiary(id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: isLoading
            ? const DiaryLoadingScreen()
            : diaryReadViewModel.diaryModel.value == null
                ? DiaryHasNotDataScreen(onPressRetry: () {
                    getDiary(id);
                  })
                : DiaryHasDataScreen(
                    diaryReadViewModel: diaryReadViewModel,
                  ),
      ),
    );
  }
}
