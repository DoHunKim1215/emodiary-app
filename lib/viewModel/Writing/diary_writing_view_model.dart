import 'package:emodiary/provider/Writing/diary_writing_provider.dart';
import 'package:emodiary/util/function/log_on_dev.dart';
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

  /* Created Date */
  Rx<DateTime> createdDate = DateTime.now().obs;

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

  Future<void> getPictures() async {
    try {
      final prompt =
          await diaryWritingProvider.tokenize(_contentEditingController.text);

      logOnDev("🏞️ Processed Prompt : $prompt");

      final pictures = await diaryWritingProvider.getPictures(prompt);

      this.pictures.value = pictures;
      this.pictures.refresh();

      return Future.value();
    } on Exception catch (e) {
      return Future.error(e);
    }
  }

  void setSelectedPicture(int selected) {
    if (selected < 0 || 3 < selected) {
      return;
    }

    selectedPictureIdx.value = selected;
  }

  void setCreatedDate(DateTime createdDate) {
    this.createdDate.value = DateTime(
      createdDate.year,
      createdDate.month,
      createdDate.day,
    );
  }

  bool isSelected() {
    return selectedPictureIdx.value != null;
  }
}
