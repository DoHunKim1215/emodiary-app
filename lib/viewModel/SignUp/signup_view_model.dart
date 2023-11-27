import 'package:emodiary/screen/SignUp/Terms/signup_terms_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpViewModel extends GetxController {
  RxInt currentIndex = 0.obs;

  double getProgressPercent() {
    switch (currentIndex.value) {
      case 0:
        return 0.5;
      default:
        assert(false, "🚨 [Assertion Error] Invalid Login Screen Index Value.");
    }
    return 0.0;
  }

  Widget getCurrentScreen() {
    switch (currentIndex.value) {
      case 0:
        return SignUpTermsScreen();
      default:
        assert(false, "🚨 [Assertion Error] Invalid Login Screen Index Value.");
    }
    return Container();
  }
}
