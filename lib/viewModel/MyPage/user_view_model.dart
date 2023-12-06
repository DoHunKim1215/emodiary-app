import 'package:dio/dio.dart';
import 'package:emodiary/model/User/user_model.dart';
import 'package:emodiary/provider/User/user_provider.dart';
import 'package:emodiary/provider/Auth/auth_provider.dart';
import 'package:get/get.dart';

class UserViewModel extends GetxController {
  final UserProvider userProvider = UserProvider();
  final AuthProvider authProvider = AuthProvider();

  Rxn<UserModel> userModel = Rxn<UserModel>(null);

  Future<void> getUserInfo() async {
    try {
      userModel.value = await userProvider.getUserInfo();
    } on DioException catch (_) {
      userModel.value = null;
    } finally {
      userModel.refresh();
    }
  }

  Future<bool> signOut() async {
    final isSuccess = await authProvider.signOut();
    return isSuccess;
  }
}
