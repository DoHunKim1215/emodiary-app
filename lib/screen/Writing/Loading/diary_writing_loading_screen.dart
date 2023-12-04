import 'package:emodiary/screen/Writing/Loading/Widget/diary_writing_loading_text.dart';
import 'package:emodiary/viewModel/Writing/diary_writing_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiaryWritingLoadingScreen extends StatefulWidget {
  const DiaryWritingLoadingScreen({super.key});

  @override
  State<DiaryWritingLoadingScreen> createState() =>
      _DiaryWritingLoadingScreenState();
}

class _DiaryWritingLoadingScreenState extends State<DiaryWritingLoadingScreen> {
  final DiaryWritingViewModel vm = Get.find<DiaryWritingViewModel>();

  @override
  void initState() {
    super.initState();

    vm.getPictures().then(
      (pictures) {
        Get.toNamed("/writing/select");
      },
    ).onError(
      (error, stackTrace) {
        Get.back();
        Get.snackbar(
          '그림을 불러오는데 실패했습니다',
          '일기 내용이 적거나 의미가 분명하지 않으면 감정을 파악하기 힘들어요',
          margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          duration: const Duration(milliseconds: 1500),
          snackPosition: SnackPosition.TOP,
          backgroundColor: const Color(0xFFF5F5F9),
          colorText: Colors.black,
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
                child: const DiaryWritingLoadingText(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
