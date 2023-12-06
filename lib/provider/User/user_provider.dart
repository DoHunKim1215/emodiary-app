import 'package:dio/dio.dart';
import 'package:emodiary/model/User/user_model.dart';
import 'package:emodiary/provider/Base/http_util.dart';

class UserProvider {
  static final authDio = HttpUtil().authDio;

  Future<UserModel> getUserInfo() async {
    try {
      final response = await authDio.get("/users");
      return UserModel.fromJson(response.data["data"] as Map<String, dynamic>);
    } on DioException catch (_) {
      rethrow;
    }
  }
}
