import 'package:dio/dio.dart';
import 'package:emodiary/model/Diary/shared_diary_model.dart';
import 'package:emodiary/provider/Base/http_util.dart';

class SharedDiaryProvider {
  static final authDio = HttpUtil().authDio;

  Future<SharedDiaryModel> shareDiary(int diaryID) async {
    final requestBody = <String, dynamic>{
      "diary_id": diaryID,
      "accessible_time": "01:00",
    };

    try {
      final response = await authDio.post("/shared-diaries", data: requestBody);
      return SharedDiaryModel.fromJson(
        response.data["data"] as Map<String, dynamic>,
      );
    } on DioException catch (_) {
      rethrow;
    }
  }
}
