import 'package:emodiary/screen/SignUp/Identify/signup_identify_screen.dart';
import 'package:emodiary/screen/SignUp/InputId/signup_input_id_screen.dart';
import 'package:emodiary/screen/SignUp/InputPassword/signup_input_password_screen.dart';
import 'package:emodiary/screen/SignUp/Terms/signup_terms_screen.dart';
import 'package:emodiary/viewModel/SignUp/signup_route_view_model.dart';
import 'package:emodiary/viewModel/SignUp/signup_view_model.dart';
import 'package:emodiary/widget/SignUp/animated_indexed_stack.dart';
import 'package:emodiary/widget/base/leading_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpProcessScreen extends StatelessWidget {
  final SignUpRouteViewModel signUpRouteViewModel =
      Get.put(SignUpRouteViewModel());
  final SignUpViewModel signUpViewModel = Get.put(SignUpViewModel());

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
                onPressed: signUpViewModel.isLoading.value
                    ? null
                    : signUpRouteViewModel.getOnPressBack(),
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
                    children: [
                      signUpRouteViewModel.currentIndex.value == 0
                          ? SignUpTermsScreen(
                              gotoNext: signUpRouteViewModel.gotoIdentify,
                            )
                          : Container(),
                      signUpRouteViewModel.currentIndex.value == 1
                          ? SignUpIdentifyScreen(
                              gotoNext: signUpRouteViewModel.gotoInputId,
                              viewModel: signUpViewModel,
                            )
                          : Container(),
                      signUpRouteViewModel.currentIndex.value == 2
                          ? SignUpInputIdScreen(
                              gotoNext: signUpRouteViewModel.gotoInputPassword,
                              viewModel: signUpViewModel,
                            )
                          : Container(),
                      signUpRouteViewModel.currentIndex.value == 3
                          ? SignUpInputPasswordScreen(
                              viewModel: signUpViewModel,
                            )
                          : Container(),
                    ],
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
