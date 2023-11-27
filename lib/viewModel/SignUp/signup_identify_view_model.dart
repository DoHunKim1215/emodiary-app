import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpIdentifyViewModel extends GetxController {
  static const int nickNameMaxLength = 20;
  static const int telMaxLength = 1000;

  late TextEditingController _nickNameEditingController;
  late TextEditingController _telEditingController;

  TextEditingController get nickNameCtrl => _nickNameEditingController;
  TextEditingController get telCtrl => _telEditingController;

  @override
  void onInit() {
    super.onInit();
    initTextController();
  }

  @override
  void onClose() {
    disposeTextController();
    super.onClose();
  }

  void initTextController() {
    _nickNameEditingController = TextEditingController();
    _telEditingController = TextEditingController();
  }

  void disposeTextController() {
    _nickNameEditingController.dispose();
    _telEditingController.dispose();
  }

  bool canSend() {
    return _nickNameEditingController.text.isNotEmpty &&
        _telEditingController.text.isNotEmpty;
  }
}
