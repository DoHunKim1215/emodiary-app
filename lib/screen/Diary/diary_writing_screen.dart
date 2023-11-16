import 'package:emodiary/widget/Diary/diary_appbat.dart';
import 'package:flutter/material.dart';

class DiaryWritingScreen extends StatelessWidget {
  const DiaryWritingScreen({super.key});

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
            child: DiaryAppBar(
              title: '2023.06',
              onPressed: () {},
            ),
          ),
          body: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
