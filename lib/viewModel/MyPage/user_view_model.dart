import 'package:dio/dio.dart';
import 'package:emodiary/model/User/user_model.dart';
import 'package:emodiary/provider/MyPage/mypage_provider.dart';
import 'package:get/get.dart';

class UserViewModel extends GetxController {
  final MyPageProvider myPageProvider = MyPageProvider();

  Rxn<UserModel> userModel = Rxn<UserModel>(null);

  Future<void> getUserInfo() async {
    try {
      userModel.value = await myPageProvider.getUserInfo();
    } on DioException catch (_) {
      userModel.value = null;
    } finally {
      userModel.refresh();
    }
  }
}
