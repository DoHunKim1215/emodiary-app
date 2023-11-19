import 'package:emodiary/screen/Diary/Saved/Widget/diary_writing_save_back_card.dart';
import 'package:emodiary/screen/Diary/Saved/Widget/diary_writing_save_card.dart';
import 'package:emodiary/viewModel/Diary/Writing/diary_writing_view_model.dart';
import 'package:emodiary/widget/Diary/diary_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DiaryWritingSaveScreen extends StatelessWidget {
  final DiaryWritingViewModel vm = Get.find<DiaryWritingViewModel>();

  DiaryWritingSaveScreen({super.key});

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
              title: '나의 하루 그림일기',
              onPressed: () {
                Get.delete<DiaryWritingViewModel>(force: true);
                Get.offAllNamed("/");
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "오늘 하루",
                            style: TextStyle(
                              color: Color(0xFF7541EF),
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "를 그림으로 저장했어요!",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          const DiaryWritingSaveBackCard(),
                          DiaryWritingSaveCard(
                            viewModel: vm,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  style: IconButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                    highlightColor: Colors.transparent,
                  ),
                  onPressed: () {
                    vm.flipCard();
                  },
                  icon: SvgPicture.asset(
                    "assets/icons/rotate-button-icon.svg",
                    width: 60,
                    height: 60,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
