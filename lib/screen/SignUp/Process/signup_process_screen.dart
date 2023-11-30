import 'package:emodiary/util/enum/signup_process.dart';
import 'package:emodiary/util/function/log_on_dev.dart';
import 'package:emodiary/viewModel/SignUp/signup_view_model.dart';
import 'package:emodiary/widget/SignUp/animated_indexed_stack.dart';
import 'package:emodiary/widget/SignUp/signup_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpProcessScreen extends StatelessWidget {
  final SignUpViewModel loginViewModel = Get.put(SignUpViewModel());

  SignUpProcessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: false,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: SignUpAppBar(
              onPressed: () {
                logOnDev("BACK!");
              },
            ),
          ),
          body: Obx(
            () => Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 20,
                  ),
                  child: LinearProgressIndicator(
                    value: loginViewModel.getProgressPercent(),
                    color: const Color(0xFF7541EF),
                    backgroundColor: const Color(0xFFE6E9ED),
                    minHeight: 2,
                  ),
                ),
                Expanded(
                  child: AnimatedIndexedStack(
                    index: loginViewModel.currentIndex.value,
                    children: List.generate(
                      ESignUpProcess.values.length,
                      (index) {
                        return loginViewModel.currentIndex.value == index
                            ? loginViewModel.getCurrentScreen()
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
