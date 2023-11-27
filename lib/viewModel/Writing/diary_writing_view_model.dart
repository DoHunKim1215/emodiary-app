import 'package:emodiary/provider/Writing/diary_writing_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiaryWritingViewModel extends GetxController {
  /* Title */
  static const int titleMaxLength = 40;

  late TextEditingController _titleEditingController;
  TextEditingController get titleCtrl => _titleEditingController;

  /* Content */
  static const int contentMaxLength = 1000;

  late TextEditingController _contentEditingController;
  TextEditingController get contentCtrl => _contentEditingController;

  /* Pictures */
  RxList<String> pictures = RxList<String>([]);
  RxnInt selectedPictureIdx = RxnInt(null);

  /* Providers */
  final DiaryWritingProvider diaryWritingProvider = DiaryWritingProvider();

  @override
  void onInit() {
    super.onInit();
    _titleEditingController = TextEditingController();
    _contentEditingController = TextEditingController();
  }

  @override
  void onClose() {
    _titleEditingController.dispose();
    _contentEditingController.dispose();
    super.onClose();
  }

  bool canSendTitleAndContent() {
    return _titleEditingController.text.isNotEmpty &&
        _contentEditingController.text.isNotEmpty;
  }

  int? getSelectedPicture() {
    return selectedPictureIdx.value;
  }

  void setPictures(List<String> base64Pictures) {
    pictures.value = base64Pictures;
    pictures.refresh();
  }

  void setSelectedPicture(int selected) {
    if (selected < 0 || 3 < selected) {
      return;
    }

    selectedPictureIdx.value = selected;
  }

  bool isSelected() {
    return selectedPictureIdx.value != null;
  }
}
