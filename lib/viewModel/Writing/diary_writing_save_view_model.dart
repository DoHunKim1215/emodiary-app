import 'package:get/get.dart';

class DiaryWritingSaveViewModel extends GetxController {
  RxBool isShownPicture = true.obs;

  void flipCard() {
    isShownPicture.value = !isShownPicture.value;
  }

  bool getIsShownPicture() {
    return isShownPicture.value;
  }
}
