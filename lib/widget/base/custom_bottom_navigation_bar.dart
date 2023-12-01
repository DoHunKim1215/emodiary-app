import 'package:emodiary/viewModel/Root/root_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CustomBottomNavigationBar extends GetView<RootViewModel> {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Get.find<RootViewModel>();

    return Obx(() => Theme(
          data: ThemeData(
            highlightColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory,
          ),
          child: BottomAppBar(
            elevation: 0,
            shape: const CircularNotchedRectangle(),
            notchMargin: 7.0,
            clipBehavior: Clip.antiAlias,
            child: BottomNavigationBar(
              elevation: 0,
              currentIndex: viewModel.selectedIndex,
              onTap: viewModel.changeIndex,

              // 아이템의 색상
              unselectedItemColor: Colors.grey[400],
              selectedItemColor: const Color(0xFF7541EF),

              // 탭 애니메이션 변경 (fixed: 없음)
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,

              // Bar에 보여질 요소. icon과 label로 구성.
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      'assets/icons/house.svg',
                      height: 24,
                      colorFilter: viewModel.selectedIndex == 0
                          ? const ColorFilter.mode(
                              Color(0xFF7541EF), BlendMode.srcATop)
                          : ColorFilter.mode(
                              Colors.grey[400]!, BlendMode.srcATop),
                    ),
                    label: "홈"),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      'assets/icons/user.svg',
                      height: 30,
                      colorFilter: controller.selectedIndex == 1
                          ? const ColorFilter.mode(
                              Color(0xFF7541EF), BlendMode.srcATop)
                          : ColorFilter.mode(
                              Colors.grey[400]!, BlendMode.srcATop),
                    ),
                    label: "내정보"),
              ],
            ),
          ),
        ));
  }
}
