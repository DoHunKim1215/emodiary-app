import 'package:emodiary/screen/Home/Widget/home_under_card.dart';
import 'package:emodiary/viewModel/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../repository/home/home_repository.dart';
import 'Widget/home_diary_card.dart';
import 'Widget/emotion_chart_card.dart';
import 'Widget/home_notice_card.dart';

class HomeScreen extends StatelessWidget {
  final HomeViewModel _viewModel =
      Get.put(HomeViewModel(repository: HomeRepository()));

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                HomeUnderCard(viewModel: _viewModel),
                EmotionChartCard(viewModel: _viewModel),
                HomeNoticeCard(viewModel: _viewModel),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                children: [
                  Flexible(
                    child: HomeDiaryCard(
                      title: "오늘",
                      imageUrl:
                          "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: HomeDiaryCard(
                      title: "어제",
                      imageUrl: "",
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
