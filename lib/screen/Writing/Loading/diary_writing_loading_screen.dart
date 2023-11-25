import 'package:emodiary/screen/Writing/Loading/Widget/diary_writing_loading_text.dart';
import 'package:flutter/material.dart';

class DiaryWritingLoadingScreen extends StatefulWidget {
  const DiaryWritingLoadingScreen({super.key});

  @override
  State<DiaryWritingLoadingScreen> createState() =>
      _DiaryWritingLoadingScreenState();
}

class _DiaryWritingLoadingScreenState extends State<DiaryWritingLoadingScreen> {
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
