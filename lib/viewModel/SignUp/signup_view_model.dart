import 'package:emodiary/screen/SignUp/Identify/signup_identify_screen.dart';
import 'package:emodiary/screen/SignUp/InputId/signup_input_id_screen.dart';
import 'package:emodiary/screen/SignUp/InputPassword/signup_input_password_screen.dart';
import 'package:emodiary/screen/SignUp/Terms/signup_terms_screen.dart';
import 'package:emodiary/util/enum/signup_process.dart';
import 'package:emodiary/util/function/log_on_dev.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpViewModel extends GetxController {
  RxInt currentIndex = 0.obs;

  double getProgressPercent() {
    switch (currentIndex.value) {
      case 0:
        return 0.25;
      case 1:
        return 0.5;
      case 2:
        return 0.75;
      case 3:
        return 1.0;
      default:
        assert(false, "🚨 [Assertion Error] Invalid Login Screen Index Value.");
    }
    return 0.0;
  }

  Widget getCurrentScreen() {
    switch (currentIndex.value) {
      case 0:
        return SignUpTermsScreen(onTapNext: gotoIdentify);
      case 1:
        return SignUpIdentifyScreen(onTapNext: gotoInputId);
      case 2:
        return SignUpInputIdScreen(onTapNext: gotoInputPassword);
      case 3:
        return SignUpInputPasswordScreen(onTapNext: gotoHome);
      default:
        assert(false, "🚨 [Assertion Error] Invalid Login Screen Index Value.");
    }
    return Container();
  }

  void Function() getOnPressBack() {
    switch (currentIndex.value) {
      case 0:
        return Get.back;
      case 1:
        return gotoTerms;
      case 2:
        return gotoIdentify;
      case 3:
        return gotoInputPassword;
      default:
        assert(false, "🚨 [Assertion Error] Invalid Login Screen Index Value.");
    }
    return () {};
  }

  void gotoTerms() {
    currentIndex.value = ESignUpProcess.terms.index;
  }

  void gotoIdentify() {
    currentIndex.value = ESignUpProcess.identify.index;
  }

  void gotoInputId() {
    currentIndex.value = ESignUpProcess.inputId.index;
  }

  void gotoInputPassword() {
    currentIndex.value = ESignUpProcess.inputPassword.index;
  }

  void gotoHome() {
    Get.offAllNamed("/");
  }
}
