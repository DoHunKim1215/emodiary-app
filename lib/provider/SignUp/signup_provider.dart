import 'package:dio/dio.dart';
import 'package:emodiary/provider/Base/http_util.dart';

class SignUpProvider {
  static final Dio dio = HttpUtil().dio;
  static final Dio authDio = HttpUtil().authDio;

  static Future<void> signIn(String serialID, String password) async {
    var formData = FormData.fromMap({
      "serial_id": serialID,
      "password": password,
    });

    try {
      final response = await dio.post("/auth/sign-in", data: formData);

      response.data["data"][""]
    } on DioException catch (error) {}
  }
}
