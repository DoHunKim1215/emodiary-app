import 'package:emodiary/viewModel/home/home_view_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../../../model/e_emotion.dart';

class EmotionPieChart extends StatefulWidget {
  final HomeViewModel viewModel;
  const EmotionPieChart({Key? key, required this.viewModel}) : super(key: key);

  @override
  State<EmotionPieChart> createState() => _EmotionPieChartState();
}

class _EmotionPieChartState extends State<EmotionPieChart> {
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
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final radius = isTouched ? 145.0 : 135.0;
      final widgetSize = isTouched ? 45.0 : 40.0;

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xFFA0D468),
            value: emotionScore[EEmotion.GOOD]!.toDouble(),
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
            value: emotionScore[EEmotion.SOSO]!.toDouble(),
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
            value: emotionScore[EEmotion.BAD]!.toDouble(),
            showTitle: false,
            radius: radius,
            badgeWidget: _Badge(
              'assets/icons/emotion-bad.svg',
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
