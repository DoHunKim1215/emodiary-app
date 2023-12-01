import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../model/e_emotion.dart';
import '../../../viewModel/home/home_view_model.dart';
import 'package:flutter/foundation.dart' as foundation;

class EmotionChartCard extends StatefulWidget {
  final HomeViewModel viewModel;
  const EmotionChartCard({Key? key, required this.viewModel}) : super(key: key);

  @override
  State<EmotionChartCard> createState() => _EmotionChartCardState();
}

class _EmotionChartCardState extends State<EmotionChartCard> {
  late final HomeViewModel _viewModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _viewModel = widget.viewModel;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 200, left: 20, right: 20),
      height:
          foundation.defaultTargetPlatform == foundation.TargetPlatform.android
              ? 465
              : 510,
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
        padding:
            const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
        child: Obx(
          () => _viewModel.isLoadingEmotionScore
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
                    const SizedBox(height: 35),
                    _EmotionPieChart(viewModel: _viewModel),
                    const SizedBox(height: 45),
                    Container(
                      width: double.infinity,
                      height: 2,
                      color: Colors.grey[300],
                    ),
                    // 양쪽 정렬
                    const Spacer(),
                    Center(
                      child: Text(
                        _viewModel.emotionScore.keys
                            .reduce((a, b) =>
                                _viewModel.emotionScore[a]!.value >
                                        _viewModel.emotionScore[b]!.value
                                    ? a
                                    : b)
                            .oneCommentStr,
                        style: const TextStyle(
                            fontSize: 15, color: Color(0xFF434A54)),
                      ),
                    ),
                    Center(
                      child: Text(
                        _viewModel.emotionScore.keys
                            .reduce((a, b) =>
                                _viewModel.emotionScore[a]!.value >
                                        _viewModel.emotionScore[b]!.value
                                    ? a
                                    : b)
                            .twoCommentStr,
                        style: const TextStyle(
                            fontSize: 15, color: Color(0xFF434A54)),
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}

class _EmotionPieChart extends StatefulWidget {
  final HomeViewModel viewModel;
  const _EmotionPieChart({Key? key, required this.viewModel}) : super(key: key);

  @override
  State<_EmotionPieChart> createState() => _EmotionPieChartState();
}

class _EmotionPieChartState extends State<_EmotionPieChart> {
  late final HomeViewModel _viewModel;
  late int touchedIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _viewModel = widget.viewModel;
    touchedIndex = -1;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: AspectRatio(
        aspectRatio: 1,
        child: PieChart(
          PieChartData(
              pieTouchData: PieTouchData(
                touchCallback: (FlTouchEvent event, pieTouchResponse) {
                  setState(() {
                    if (!event.isInterestedForInteractions ||
                        pieTouchResponse == null ||
                        pieTouchResponse.touchedSection == null) {
                      touchedIndex = -1;
                      return;
                    }
                    touchedIndex =
                        pieTouchResponse.touchedSection!.touchedSectionIndex;
                  });
                },
              ),
              borderData: FlBorderData(
                show: false,
              ),
              sectionsSpace: 0,
              centerSpaceRadius: 0,
              sections: showingSections(_viewModel.emotionScore)),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections(Map<EEmotion, RxInt> emotionScore) {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final radius = isTouched ? 140.0 : 130.0;
      final widgetSize = isTouched ? 45.0 : 40.0;

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xFFA0D468),
            value: _viewModel.emotionScore[EEmotion.GOOD]!.toDouble(),
            showTitle: false,
            radius: radius,
            badgeWidget: _Badge(
              'assets/icons/emotion-good.svg',
              size: widgetSize,
              borderColor: Colors.grey,
            ),
            badgePositionPercentageOffset: .98,
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xFFFFCE54),
            value: _viewModel.emotionScore[EEmotion.SOSO]!.toDouble(),
            showTitle: false,
            radius: radius,
            badgeWidget: _Badge(
              'assets/icons/emotion-soso.svg',
              size: widgetSize,
              borderColor: Colors.grey,
            ),
            badgePositionPercentageOffset: .98,
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xFFED5565),
            value: _viewModel.emotionScore[EEmotion.BAD]!.toDouble(),
            showTitle: false,
            radius: radius,
            badgeWidget: _Badge(
              'assets/icons/emotion-bad.svg',
              size: widgetSize,
              borderColor: Colors.grey,
            ),
            badgePositionPercentageOffset: .98,
          );
        case 3:
          return PieChartSectionData(
            color: Colors.grey[400],
            value: _viewModel.emotionScore[EEmotion.NONE]!.toDouble(),
            showTitle: false,
            radius: radius,
            badgeWidget: _Badge(
              'assets/icons/emotion-none.svg',
              size: widgetSize,
              borderColor: Colors.grey,
            ),
            badgePositionPercentageOffset: .98,
          );
        default:
          throw Exception('Oh no');
      }
    });
  }
}

class _Badge extends StatelessWidget {
  const _Badge(
    this.svgAsset, {
    required this.size,
    required this.borderColor,
  });
  final String svgAsset;
  final double size;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 1,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(.5),
            offset: const Offset(0, 1),
            blurRadius: 1,
            spreadRadius: 1,
          ),
        ],
      ),
      padding: EdgeInsets.all(size * .1),
      child: Center(
        child: SvgPicture.asset(
          svgAsset,
          height: size * .8,
          width: size * .8,
        ),
      ),
    );
  }
}
