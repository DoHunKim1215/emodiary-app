import 'package:emodiary/screen/MyPage/MyPage/mypage_screen.dart';
import 'package:emodiary/viewModel/MyPage/user_view_model.dart';
import 'package:emodiary/viewModel/Root/root_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widget/base/custom_bottom_navigation_bar.dart';
import '../widget/base/diary_floating_action_button.dart';
import 'Home/home_screen.dart';

class RootScreen extends StatelessWidget {
  final UserViewModel userViewModel = Get.put(
    UserViewModel(),
    permanent: true,
  );

  RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RootViewModel viewModel = Get.put(RootViewModel());

    return Container(
      color: const Color(0xFFFFFFFF),
      child: SafeArea(
        child: Material(
          child: Stack(
            children: [
              Scaffold(
                backgroundColor: const Color(0xFFFFFFFF),
                body: Obx(
                  () => IndexedStack(
                    index: viewModel.selectedIndex,
                    children: [
                      const HomeScreen(),
                      MyPageScreen(userViewModel: userViewModel),
                    ],
                  ),
                ),
                floatingActionButton: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    width: 60,
                    height: 60,
                    color: Colors.transparent,
                  ),
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerDocked,
                extendBody: true,
                bottomNavigationBar: const CustomBottomNavigationBar(),
              ),
              const DiaryFloatingActionButton(),
            ],
          ),
        ),
      ),
    );
  }
}
