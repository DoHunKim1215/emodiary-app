import 'package:dio/dio.dart';
import 'package:emodiary/provider/Base/http_util.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';

class DiaryWritingProvider {
  static final authDio = HttpUtil().authDio;

  Future<String> tokenize(String content) async {
    final requestBody = <String, dynamic>{
      "content": content,
    };

    try {
      final response = await authDio.post(
        '/diaries/tokenize',
        data: requestBody,
      );

      return response.data["data"] as String;
    } on Exception catch (e) {
      return Future.error(e);
    }
  }

  Future<List<String>> getPictures(String prompt) async {
    final requestBody = <String, dynamic>{
      "prompt": prompt,
      "negative_prompt": "sleeping cat, dog, human, ugly face, cropped",
      "width": 384,
      "height": 384,
      "image_format": "png",
      "return_type": "base64_string",
      "samples": 4,
    };

    final headers = <String, String>{
      'Authorization': "KakaoAK ${dotenv.env['KARLO_REST_API_KEY']}",
      'Content-Type': 'application/json',
    };

    try {
      final dio = Dio();
      final response = await dio.post(
        'https://api.kakaobrain.com/v2/inference/karlo/t2i',
        data: requestBody,
        options: Options(headers: headers),
      );

      if (response.data == null) {
        return [];
      }

      final images = response.data["images"] as List<dynamic>;

      return List.generate(
        images.length,
        (index) => images[index]["image"] as String,
      );
    } on Exception catch (e) {
      return [];
    }
  }

  Future createDiary(
    String title,
    DateTime createdDate,
    String content,
    String base64Image,
  ) async {
    final requestBody = {
      "which_date": DateFormat("yyyy-MM-dd").format(createdDate),
      "title": title,
      "content": content,
      "image_base64": base64Image,
    };

    try {
      await authDio.post('/diaries', data: requestBody);
      return Future.value(null);
    } on Exception catch (e) {
      return Future.error(e);
    }
  }
}
