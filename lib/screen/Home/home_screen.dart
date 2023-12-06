import 'package:emodiary/screen/Home/Widget/home_under_card.dart';
import 'package:emodiary/viewModel/MyPage/user_view_model.dart';
import 'package:emodiary/viewModel/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../provider/home/home_provider.dart';
import '../../repository/home/home_repository.dart';
import 'Widget/home_diary_card.dart';
import 'Widget/emotion_chart_card.dart';
import 'Widget/home_notice_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeViewModel viewModel = Get.put(
      HomeViewModel(
        repository: HomeRepository(
          homeProvider: Get.put(HomeProvider()),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                HomeUnderCard(viewModel: viewModel),
                EmotionChartCard(viewModel: viewModel),
                HomeNoticeCard(viewModel: viewModel),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                children: [
                  Flexible(
                    child: HomeDiaryCard(
                      title: "오늘",
                      viewModel: viewModel,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: HomeDiaryCard(
                      title: "어제",
                      viewModel: viewModel,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 100,
            )
          ],
        ),
      ),
    );
  }
}
