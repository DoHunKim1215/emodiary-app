import 'package:emodiary/widget/Writing/diary_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiaryLoadingScreen extends StatelessWidget {
  const DiaryLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: DiaryAppBar(
          title: "",
          onPressedLeading: Get.back,
          onPressedAction: null,
        ),
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
