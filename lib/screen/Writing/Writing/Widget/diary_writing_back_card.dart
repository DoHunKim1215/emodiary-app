import 'package:emodiary/viewModel/Writing/diary_writing_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DiaryWritingBackCard extends StatelessWidget {
  final DiaryWritingViewModel viewModel;

  const DiaryWritingBackCard({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 70.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: const Color(0xFFFFE76A),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 20.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${viewModel.contentCtrl.text.length}/${DiaryWritingViewModel.contentMaxLength}",
                  style: const TextStyle(
                    color: Color(0xFF434A54),
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/txt-button-icon.svg",
                      width: 40,
                      height: 40,
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Stack(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/color-button-icon.svg",
                          width: 40,
                          height: 40,
                        ),
                        Positioned(
                          top: 7,
                          right: 7,
                          child: Image.asset(
                            "assets/icons/color-palette-icon.png",
                            width: 26,
                            height: 26,
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
