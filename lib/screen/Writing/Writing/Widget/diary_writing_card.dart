import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:emodiary/viewModel/Writing/diary_writing_view_model.dart';

class DiaryWritingCard extends StatelessWidget {
  final DiaryWritingViewModel viewModel;
  final void Function(String) refresh;

  const DiaryWritingCard({
    super.key,
    required this.viewModel,
    required this.refresh,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 70.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          width: 2.0,
          color: const Color(0xFFF1F0F5),
        ),
        gradient: const LinearGradient(
          begin: Alignment(1, 1),
          end: Alignment(0, 0),
          colors: <Color>[
            Color.fromRGBO(242, 235, 253, 0.3),
            Color.fromRGBO(241, 240, 245, 0.3),
          ],
          tileMode: TileMode.mirror,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 22.5,
            sigmaY: 22.5,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 18.0,
              horizontal: 22.0,
            ),
            child: SizedBox(
              height: 440,
              child: Stack(
                children: [
                  for (int i = 0; i < 10; i++)
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(
                        top: 8 + (i + 1) * 40,
                      ),
                      height: 2,
                      color: const Color(0xFFF1F0F5),
                    ),
                  TextField(
                    controller: viewModel.contentCtrl,
                    keyboardType: TextInputType.multiline,
                    maxLines: 10,
                    maxLength: DiaryWritingViewModel.contentMaxLength,
                    style: const TextStyle(
                      color: Color(0xFF434A54),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      height: 2.5,
                    ),
                    cursorColor: const Color(0xFF787A93),
                    decoration: const InputDecoration(
                      counterText: "",
                      hintText:
                          '오늘의 하루는 어떠셨나요?\n오늘 느낀 감정, 생각 모두 다 좋아요!\n생각나는대로 다 작성해보세요.',
                      hintStyle: TextStyle(
                        color: Color(0xFF787A93),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        height: 2.5,
                      ),
                      isDense: true,
                      border: InputBorder.none,
                    ),
                    onChanged: refresh,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
