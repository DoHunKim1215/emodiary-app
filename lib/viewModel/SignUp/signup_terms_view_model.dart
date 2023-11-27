import 'package:get/get.dart';

class SignUpTermsViewModel extends GetxController {
  final RxList<bool> isChecked = <bool>[false, false, false].obs;

  void setAll(bool checked) {
    isChecked([
      checked,
      checked,
      checked,
    ]);
  }

  void toggleAll() {
    if (isCheckedAll()) {
      setAll(false);
    } else {
      setAll(true);
    }
  }

  void Function() toggle(int index) {
    return () => isChecked[index] = !isChecked[index];
  }

  bool isCheckedAll() {
    return isChecked[0] && isChecked[1] && isChecked[2];
  }

  bool isCheckedRequiredAll() {
    return isChecked[0] && isChecked[1];
  }
}
