import 'package:dio/dio.dart';
import 'package:emodiary/provider/Base/base_connect.dart';
import 'package:intl/intl.dart';

import '../../util/function/log_on_dev.dart';
import '../Base/http_util.dart';

class DiaryCalendarProvider {
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

  Future<List<dynamic>> getDiariesByWhichDate(DateTime whichDate) async {
    try {
      final response = await authDio.get(
        "/diaries",
        queryParameters: {
          "whichDate": DateFormat("yyyy-MM-dd").format(whichDate),
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
