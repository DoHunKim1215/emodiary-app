import 'package:emodiary/viewModel/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../model/e_emotion.dart';

class HomeUnderCard extends StatefulWidget {
  final HomeViewModel viewModel;
  const HomeUnderCard({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  State<HomeUnderCard> createState() => _HomeUnderCardState();
}

class _HomeUnderCardState extends State<HomeUnderCard> {
  late final HomeViewModel _viewModel;
  late final String _name;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _viewModel = widget.viewModel;
    _name = "형준";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      decoration: const BoxDecoration(
        color: Color(0xFFE8DCFF),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 80, left: 20, right: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 220,
              height: 110,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat('yyyy년 MM월 dd일').format(_viewModel.todayDate),
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    "이번 달의 $_name님의 감정은",
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Text(
                    "\"${_viewModel.emotionScore.keys.reduce((a, b) => _viewModel.emotionScore[a]!.value > _viewModel.emotionScore[b]!.value ? a : b).valueStr}\"",
                    style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
            const Spacer(),
            _EmotionEmojiSvg(
              emotion: _viewModel.emotionScore.keys.reduce((a, b) =>
                  _viewModel.emotionScore[a]!.value >
                          _viewModel.emotionScore[b]!.value
                      ? a
                      : b),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmotionEmojiSvg extends StatelessWidget {
  final EEmotion emotion;
  const _EmotionEmojiSvg({
    Key? key,
    required this.emotion,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (emotion) {
      case EEmotion.BAD:
        return SvgPicture.asset(
          "assets/icons/emotion-home-bad.svg",
          width: 100,
          height: 100,
        );
      case EEmotion.SOSO:
        return SvgPicture.asset(
          "assets/icons/emotion-home-soso.svg",
          width: 100,
          height: 100,
        );
      case EEmotion.GOOD:
        return SvgPicture.asset(
          "assets/icons/emotion-home-good.svg",
          width: 100,
          height: 100,
        );
      case EEmotion.NONE:
        return SvgPicture.asset(
          "assets/icons/emotion-home-none.svg",
          width: 100,
          height: 100,
        );
      default:
        throw Exception('Oh no');
    }
  }
}
