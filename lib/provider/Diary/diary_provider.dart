import 'package:dio/dio.dart';
import 'package:emodiary/model/Diary/diary_model.dart';

import '../../model/Diary/diary_search_item_model.dart';
import '../Base/http_util.dart';

class DiaryProvider {
  static final authDio = HttpUtil().authDio;

  Future<DiaryModel> getDiary(int id) async {
    try {
      final response = await authDio.get('/diaries/$id');
      return DiaryModel.fromJson(response.data["data"] as Map<String, dynamic>);
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
      await authDio.put('/diaries/$id', data: requestBody);
      return Future.value();
    } on Exception catch (e) {
      return Future.error(e);
    }
  }

  Future deleteDiary(int id) async {
    try {
      await authDio.delete('/diaries/$id');
      return Future.value();
    } on Exception catch (e) {
      return Future.error(e);
    }
  }

  Future<List<DiarySearchItemModel>> searchDiaries(
    String keyword,
    int pageSize,
    int pageNumber,
  ) async {
    try {
      final response = await authDio.get(
        "/diaries/search?token=$keyword&size=$pageSize&page=$pageNumber",
      );
      final jsonList = response.data["data"]["diaries"];

      return List.generate(
        jsonList.length,
        (index) => DiarySearchItemModel.fromJson(
          jsonList[index] as Map<String, dynamic>,
        ),
      );
    } on DioException catch (_) {
      return [];
    }
  }
}
