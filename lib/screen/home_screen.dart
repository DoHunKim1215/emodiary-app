import 'package:emodiary/repository/home/home_repository.dart';
import 'package:emodiary/widget/calendar/image_calendar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../viewmodel/home/home_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeViewModel _viewModel;
  List<Color> gradientColors = [
    Colors.yellow,
    Colors.red,
  ];

  String? _selectedMonth;

  final List<String> _monthList = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    '11',
    '12',
  ];

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
      backgroundColor: const Color(0xFFF2EDFF),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 1,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                padding: const EdgeInsets.only(bottom: 10),
                child: ImageCalendar(viewModel: _viewModel)),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 40),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const Row(
                  children: [
                    SizedBox(width: 10),
                    Text(
                      '📓7일 째 연속으로 일기 작성 중',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: 10),
                    Text(
                      '홍길동',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      '님의 감정',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox.shrink(),
                    DropdownButton(
                      hint: const Text('월 선택'),
                      items: _monthList
                          .map((item) => DropdownMenuItem(child: Text(item)))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedMonth = value;
                        });
                      },
                      value: _selectedMonth,
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.5),
                    ),
                  ),
                  child: AspectRatio(
                    aspectRatio: 1.70,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 18,
                        left: 12,
                        top: 24,
                        bottom: 12,
                      ),
                      child: LineChart(mainData()),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: const Color(0xFFF2EDFF),
              height: 100,
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 1:
        text = const Text('1', style: style);
        break;
      case 10:
        text = const Text('10', style: style);
        break;
      case 20:
        text = const Text('20', style: style);
        break;
      case 30:
        text = const Text('30', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = '0';
        break;
      case 5:
        text = '5';
        break;
      case 10:
        text = '10';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    return LineChartData(
      // lineTouch시 아무런 효과도 주지 않음
      lineTouchData: const LineTouchData(
        enabled: false,
      ),
      gridData: FlGridData(
        show: false,
        drawVerticalLine: false,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Colors.white,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Colors.white,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 30,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      minX: 0,
      maxX: 30,
      minY: -1,
      maxY: 11,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(1, 2),
            FlSpot(2, 3),
            FlSpot(3, 4),
            FlSpot(4, 5),
            FlSpot(5, 10),
            FlSpot(6, 4),
            FlSpot(7, 7),
            FlSpot(8, 9),
            FlSpot(9, 1),
            FlSpot(10, 2),
            FlSpot(11, 6),
            FlSpot(12, 9),
            FlSpot(13, 4),
            FlSpot(14, 5),
            FlSpot(15, 7),
            FlSpot(16, 0),
            FlSpot(17, 1),
            FlSpot(18, 5),
            FlSpot(19, 10),
            FlSpot(20, 7),
            FlSpot(21, 9),
            FlSpot(22, 4),
            FlSpot(23, 7),
            FlSpot(24, 8),
            FlSpot(25, 2),
            FlSpot(26, 1),
            FlSpot(27, 3),
            FlSpot(28, 5),
            FlSpot(29, 6),
            FlSpot(30, 3),
          ],
          isCurved: true,
          gradient: const LinearGradient(
            colors: [
              Colors.orange,
              Colors.blue,
              Colors.orange,
            ],
          ),
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.2))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
