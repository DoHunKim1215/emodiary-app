import 'package:dio/dio.dart';
import 'package:emodiary/provider/base/base_connect.dart';
import 'package:emodiary/util/function/log_on_dev.dart';
import 'package:intl/intl.dart';

import '../Base/http_util.dart';

class HomeProvider {
  static final Dio authDio = HttpUtil().authDio;

  Future<List<dynamic>> getDiariesByStartDateAndEndDate(
      DateTime startDate, DateTime endDate) async {
    try {
      final response = await authDio.get(
        "/diaries",
        queryParameters: {
          "startDate": DateFormat("yyyy-MM-dd").format(startDate),
          "endDate": DateFormat("yyyy-MM-dd").format(endDate),
        },
      );

      if (response.statusCode == 200) {
        return response.data["data"];
      } else {
        return throw Exception(
            "API 요청이 실패했습니다. - ${response.data["error"]["code"]} ${response.data["error"]["message"]}");
      }
    } catch (e) {
      logOnDev("오류 발생: $e");
      rethrow; // 현재 예외를 다시 던져서 상위 호출자에게 전달
    }
  }

  Future<Map<String, dynamic>> getContinuousDiaryCount() async {
    try {
      final response = await authDio.get(
        "/diaries/continuous-count",
      );

      if (response.statusCode == 200) {
        return response.data["data"];
      } else {
        return throw Exception(
            "API 요청이 실패했습니다. - ${response.data["error"]["code"]} ${response.data["error"]["message"]}");
      }
    } catch (e) {
      logOnDev("오류 발생: $e");
      rethrow; // 현재 예외를 다시 던져서 상위 호출자에게 전달
    }
  }

  Future<List<dynamic>> getEmotionScore(
      DateTime startDate, DateTime endDate) async {
    try {
      final response = await authDio.get(
        "/diaries/emotion-scores",
        queryParameters: {
          "startDate": DateFormat("yyyy-MM-dd").format(startDate),
          "endDate": DateFormat("yyyy-MM-dd").format(endDate),
        },
      );

      if (response.statusCode == 200) {
        return response.data["data"];
      } else {
        return throw Exception(
            "API 요청이 실패했습니다. - ${response.data["error"]["code"]} ${response.data["error"]["message"]}");
      }
    } catch (e) {
      logOnDev("오류 발생: $e");
      rethrow; // 현재 예외를 다시 던져서 상위 호출자에게 전달
    }
  }
}
