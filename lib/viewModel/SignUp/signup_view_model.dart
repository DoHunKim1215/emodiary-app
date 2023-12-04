import 'package:emodiary/provider/SignUp/signup_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpViewModel extends GetxController {
  final SignUpProvider signUpProvider = SignUpProvider();

  RxBool isLoading = false.obs;
  RxString serialID = "".obs;
  RxString password = "".obs;
  RxString nickname = "".obs;
  RxString phoneNumber = "".obs;

  void setSerialID(String newNickname) {
    serialID.value = newNickname;
  }

  void setPassword(String newPassword) {
    password.value = newPassword;
  }

  void setNickname(String newNickname) {
    nickname.value = newNickname;
  }

  void setPhoneNumber(String newPhoneNumber) {
    phoneNumber.value = newPhoneNumber;
  }

  void startLoading() {
    isLoading.value = true;
  }

  void endLoading() {
    isLoading.value = false;
  }

  Future<void> signUp() async {
    startLoading();

    final isSuccess = await signUpProvider.signUp(
      serialID.value,
      password.value,
      nickname.value,
      phoneNumber.value,
    );

    endLoading();

    if (isSuccess) {
      Get.offAllNamed("/");
    } else {
      Get.snackbar(
        '회원가입에 실패했습니다.',
        '알 수 없는 문제로 회원가입에 실패했습니다.',
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        duration: const Duration(milliseconds: 1500),
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFFF5F5F9),
        colorText: Colors.black,
      );
      Get.offAllNamed("/entry");
    }
  }
}
