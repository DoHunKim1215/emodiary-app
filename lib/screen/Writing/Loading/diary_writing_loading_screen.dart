import 'package:emodiary/screen/Writing/Loading/Widget/diary_writing_loading_text.dart';
import 'package:emodiary/util/function/log_on_dev.dart';
import 'package:emodiary/viewModel/Writing/Writing/diary_writing_view_model.dart';
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

    vm.diaryWritingProvider.getPictures().then((pictures) {
      vm.setPictures(pictures);
      Get.toNamed("/writing/select");
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
