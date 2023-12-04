import 'package:emodiary/model/Diary/diary_model.dart';
import 'package:emodiary/provider/Base/http_util.dart';

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
}
