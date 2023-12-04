import 'dart:io';

import 'package:dio/dio.dart';
import 'package:emodiary/provider/Base/http_util.dart';
import 'package:emodiary/util/enum/secure_token_key.dart';
import 'package:emodiary/util/function/log_on_dev.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SignUpProvider {
  static final Dio dio = HttpUtil().dio;
  static final Dio authDio = HttpUtil().authDio;

  Future<bool> signIn(String serialID, String password) async {
    final formData = FormData.fromMap({
      "serial_id": serialID,
      "password": password,
    });

    try {
      final response = await dio.post("/auth/sign-in", data: formData);

      final accessToken = response.data["data"][AuthToken.accessToken.jsonKey];
      final refreshToken =
          response.data["data"][AuthToken.refreshToken.jsonKey];

      const secureStorage = FlutterSecureStorage();
      await secureStorage.deleteAll();
      await secureStorage.write(
        key: AuthToken.accessToken.key,
        value: accessToken,
      );
      await secureStorage.write(
        key: AuthToken.refreshToken.key,
        value: refreshToken,
      );

      logOnDev("🔑 [Sign-in Successes] New Token Set");
      logOnDev("🔑 Access Token : $accessToken");
      logOnDev("🔑 Refresh Token : $refreshToken");

      return true;
    } on DioException catch (_) {
      return false;
    } on PlatformException catch (error) {
      logOnDev("🚨 [Flutter Secure Storage Error] Message : ${error.message}");
      return false;
    }
  }

  Future<bool> signUp(
    String serialID,
    String password,
    String nickname,
    String phoneNumber,
  ) async {
    final requestBody = <String, dynamic>{
      "serial_id": serialID,
      "password": password,
      "nickname": nickname,
      "phone_number": phoneNumber,
    };

    try {
      await dio.post("/auth/sign-up", data: requestBody);
      return true;
    } on DioException catch (_) {
      return false;
    }
  }

  Future<bool> signOut() async {
    try {
      await authDio.post("/auth/sign-out");

      const secureStorage = FlutterSecureStorage();
      await secureStorage.deleteAll();

      return true;
    } on DioException catch (_) {
      return false;
    } on PlatformException catch (error) {
      logOnDev("🚨 [Flutter Secure Storage Error] Message : ${error.message}");
      return false;
    }
  }

  Future<bool> refresh(String refreshToken) async {
    try {
      final response = await dio.post("/auth/reissue",
          options: Options(headers: {
            HttpHeaders.authorizationHeader: 'Bearer $refreshToken',
            HttpHeaders.userAgentHeader: null,
          }));

      final newAccessToken = response.data["data"][AuthToken.accessToken.key];
      final newRefreshToken = response.data["data"][AuthToken.refreshToken.key];

      const secureStorage = FlutterSecureStorage();
      await secureStorage.deleteAll();
      await secureStorage.write(
        key: AuthToken.accessToken.key,
        value: newAccessToken,
      );
      await secureStorage.write(
        key: AuthToken.refreshToken.key,
        value: newRefreshToken,
      );

      return true;
    } on DioException catch (_) {
      return false;
    }
  }
}
