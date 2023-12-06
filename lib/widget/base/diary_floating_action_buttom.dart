import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../viewModel/Root/root_view_model.dart';

class DiaryFloatingActionButton extends StatelessWidget {
  static const duration = Duration(milliseconds: 180);

  const DiaryFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Get.find<RootViewModel>();

    return Obx(
      () => Stack(
        children: [
          IgnorePointer(
            ignoring: !viewModel.isExpanded,
            child: InkWell(
              onTap: () {
                viewModel.onClickFloatingActionButton();
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                color: viewModel.isExpanded
                    ? Colors.black.withOpacity(0.5)
                    : Colors.transparent,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IgnorePointer(
                  ignoring: !viewModel.isExpanded,
                  child: AnimatedOpacity(
                    opacity: viewModel.isExpanded ? 1 : 0,
                    duration: duration,
                    child: Container(
                      width: 140,
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                      margin: const EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _floatItem('/writing', '일기 쓰기',
                              'assets/icons/diary-writing.svg'),
                          Container(
                            width: double.infinity,
                            height: 1,
                            color: const Color(0xFFE9E9EE),
                          ),
                          _floatItem("/diary/search", '일기 검색',
                              'assets/icons/diary-search.svg'),
                          Container(
                            width: double.infinity,
                            height: 1,
                            color: const Color(0xFFE9E9EE),
                          ),
                          _floatItem("/diary/calendar", '일기 달력',
                              'assets/icons/diary-calendar.svg'),
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    viewModel.onClickFloatingActionButton();
                  },
                  child: AnimatedContainer(
                    margin: const EdgeInsets.only(bottom: 35),
                    duration: duration,
                    height: 60,
                    width: 60,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: const Color(0xFF7541EF),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: viewModel.isExpanded
                        ? const AnimatedRotation(
                            duration: duration,
                            turns: 0.125,
                            child: Icon(Icons.add, color: Colors.white),
                          )
                        : SvgPicture.asset(
                            'assets/icons/diary.svg',
                            width: 24,
                            height: 24,
                            colorFilter: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

_floatItem(String type, String title, String imagePath) {
  return InkWell(
    onTap: () {
      Get.toNamed(type);
    },
    child: Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
      child: Row(
        children: [
          SvgPicture.asset(
            imagePath,
            width: 24,
            height: 24,
          ),
          SizedBox.fromSize(size: const Size(20, 0)),
          Text(title),
        ],
      ),
    ),
  );
}
