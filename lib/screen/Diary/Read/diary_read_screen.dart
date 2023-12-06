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
  late final int id;

  bool isShownPicture = true;
  bool isLoading = false;

  void getDiary(int id) {
    setState(() {
      isLoading = true;
    });

    id = Get.arguments["id"];

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
