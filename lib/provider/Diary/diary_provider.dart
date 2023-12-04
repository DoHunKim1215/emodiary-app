import 'package:emodiary/model/Diary/diary_model.dart';
import 'package:emodiary/util/function/log_on_dev.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class DiaryProvider extends GetConnect {
  @override
  void onInit() {
    super.onInit();
    httpClient
      ..baseUrl = dotenv.env["REST_API_HOST"]
      ..timeout = const Duration(seconds: 5)
      ..sendUserAgent = false
      ..addRequestModifier<dynamic>((request) {
        logOnDev("🛫 [${request.method}] ${request.url} | START");
        return request;
      })
      ..addResponseModifier((request, response) {
        if (response.status.hasError) {
          logOnDev(
            "🚨 [${request.method}] ${request.url} | FAILED (${response.statusCode})",
          );
        } else {
          logOnDev(
            "🛬 [${request.method}] ${request.url} | SUCCESS (${response.statusCode})",
          );
          logOnDev(
            "🛬 [${request.method}] ${request.url} | BODY ${response.body}",
          );
        }
        return response;
      });
  }

  Future<DiaryModel> getDiary(int id) async {
    try {
      final response = await get('/diaries/$id');
      return DiaryModel.fromJson(response.body["data"] as Map<String, dynamic>);
    } on Exception catch (e) {
      return Future.error(e);
    }
  }

  Future updateDiary(
    int id,
    String newTitle,
    String newContent,
    String newBase64Image,
  ) async {
    final requestBody = <String, dynamic>{
      "image_base64": newBase64Image,
      "title": newTitle,
      "content": newContent
    };

    try {
      await put(
        '/diaries/$id',
        requestBody,
      );
      return Future.value();
    } on Exception catch (e) {
      return Future.error(e);
    }
  }

  Future deleteDiary(int id) async {
    try {
      await delete('/diaries/$id');
      return Future.value();
    } on Exception catch (e) {
      return Future.error(e);
    }
  }
}
