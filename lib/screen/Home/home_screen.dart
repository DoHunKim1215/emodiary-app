import 'package:emodiary/viewModel/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../repository/home/home_repository.dart';
import 'Widget/diary_card.dart';
import 'package:flutter/foundation.dart' as foundation;

import 'Widget/emotion_pie_chart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeViewModel _viewModel;
  @override
  void initState() {
    super.initState();
    _viewModel = Get.put(
      HomeViewModel(
        repository: HomeRepository(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 300,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE8DCFF),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 50, left: 20, right: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 200,
                          height: 110,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("2023년 11월 30일",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey,
                                  )),
                              Text("이번달의 형준님 감정은",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                              Text("\"행복\"",
                                  style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                            ],
                          ),
                        ),
                        const Spacer(),
                        SvgPicture.asset(
                          "assets/icons/emotion-happy.svg",
                          width: 100,
                          height: 100,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 180, left: 20, right: 20),
                  height: foundation.defaultTargetPlatform ==
                          foundation.TargetPlatform.android
                      ? 475
                      : 505,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 2,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Obx(() => _viewModel.isLoadingEmotionScore
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Center(
                                child: Text(
                                  "7일째 일기 작성 중",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              const Center(
                                child: Text(
                                  "2023년 12월의 감정 호수",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 45),
                              EmotionPieChart(viewModel: _viewModel),
                              const SizedBox(height: 40),
                              Container(
                                width: double.infinity,
                                height: 2,
                                color: Colors.grey[300],
                              ),
                              // 양쪽 정렬
                              const Spacer(),
                              Center(
                                child: const Text(
                                  "2023년 12월은 무난하게 흘러가는 한 달이네요.",
                                  style: TextStyle(
                                      fontSize: 15, color: Color(0xFF434A54)),
                                ),
                              ),
                              Center(
                                child: const Text(
                                  "다음에는 어떤 즐거운 일이 생길까요?",
                                  style: TextStyle(
                                      fontSize: 15, color: Color(0xFF434A54)),
                                ),
                              )
                            ],
                          )),
                  ),
                ),
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
                    child: DiaryCard(
                      title: "오늘",
                      imageUrl:
                          "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: DiaryCard(
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
