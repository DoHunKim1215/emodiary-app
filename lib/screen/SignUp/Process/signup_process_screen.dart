import 'package:emodiary/util/enum/signup_process.dart';
import 'package:emodiary/viewModel/SignUp/signup_route_view_model.dart';
import 'package:emodiary/widget/SignUp/animated_indexed_stack.dart';
import 'package:emodiary/widget/base/leading_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpProcessScreen extends StatelessWidget {
  final SignUpRouteViewModel signUpRouteViewModel =
      Get.put(SignUpRouteViewModel());

  SignUpProcessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Obx(
        () => SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: false,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: LeadingAppBar(
                title: "회원가입",
                onPressed: signUpRouteViewModel.getOnPressBack(),
              ),
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 20,
                  ),
                  child: LinearProgressIndicator(
                    value: signUpRouteViewModel.getProgressPercent(),
                    color: const Color(0xFF7541EF),
                    backgroundColor: const Color(0xFFE6E9ED),
                    minHeight: 2,
                  ),
                ),
                Expanded(
                  child: AnimatedIndexedStack(
                    index: signUpRouteViewModel.currentIndex.value,
                    children: List.generate(
                      ESignUpProcess.values.length,
                      (index) {
                        return signUpRouteViewModel.currentIndex.value == index
                            ? signUpRouteViewModel.getCurrentScreen()
                            : Container();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
