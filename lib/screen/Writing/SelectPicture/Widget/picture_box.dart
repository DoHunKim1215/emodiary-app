import 'dart:convert';

import 'package:emodiary/viewModel/Writing/diary_writing_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class PictureBox extends StatelessWidget {
  final int pictureNumber;
  final DiaryWritingViewModel viewModel;

  const PictureBox({
    super.key,
    required this.pictureNumber,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GestureDetector(
        onTap: () {
          viewModel.setSelectedPicture(pictureNumber);
        },
        child: Obx(
          () => Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                width: 2.0,
                color: viewModel.getSelectedPicture() == pictureNumber
                    ? const Color(0xFF7541EF)
                    : const Color(0xFFCCD1D9),
              ),
            ),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.memory(
                    base64Decode(viewModel.pictures[pictureNumber]),
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: SvgPicture.asset(
                    "assets/icons/uncheck-icon.svg",
                    width: 30,
                    height: 30,
                  ),
                ),
                Positioned(
                  top: 15,
                  right: 15,
                  child: viewModel.getSelectedPicture() == pictureNumber
                      ? SvgPicture.asset(
                          "assets/icons/check.svg",
                          width: 24,
                          height: 24,
                        )
                      : Container(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
