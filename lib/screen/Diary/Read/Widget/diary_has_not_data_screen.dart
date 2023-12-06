import 'package:emodiary/widget/Writing/diary_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiaryHasNotDataScreen extends StatelessWidget {
  final void Function() onPressRetry;

  const DiaryHasNotDataScreen({
    super.key,
    required this.onPressRetry,
  });

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/icons/not-found-icon.png",
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.width * 0.5,
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              "일기 정보를 받아올 수 없습니다.",
              style: TextStyle(
                color: Color(0xFF656D78),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextButton.icon(
              onPressed: onPressRetry,
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFFF5F7FA),
                splashFactory: NoSplash.splashFactory,
                padding: const EdgeInsets.all(10.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              icon: const Icon(
                Icons.refresh,
                size: 21,
              ),
              label: const Text(
                "재시도",
                style: TextStyle(
                  color: Color(0xFF787A93),
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
