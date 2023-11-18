import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiaryWritingViewModel extends GetxController {
  static const int titleMaxLength = 40;
  static const int contentMaxLength = 1000;

  late TextEditingController _titleEditingController;
  late TextEditingController _contentEditingController;

  TextEditingController get titleCtrl => _titleEditingController;
  TextEditingController get contentCtrl => _contentEditingController;

  void initTextController() {
    _titleEditingController = TextEditingController();
    _contentEditingController = TextEditingController();
  }

  void disposeTextController() {
    _titleEditingController.dispose();
    _contentEditingController.dispose();
  }

  bool canSend() {
    return _titleEditingController.text.isNotEmpty &&
        _contentEditingController.text.isNotEmpty;
  }
}
