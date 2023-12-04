import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class DiaryWritingProvider extends GetConnect {
  Future<String> tokenize(String content) async {
    final requestBody = <String, dynamic>{
      "content": content,
    };

    try {
      final response = await post(
        '${dotenv.env["REST_API_HOST"]}/diaries/tokenize',
        requestBody,
      );

      return response.body["data"] as String;
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
      final response = await post(
        'https://api.kakaobrain.com/v2/inference/karlo/t2i',
        requestBody,
        headers: headers,
      );

      if (response.body == null) {
        return [];
      }

      final images = response.body["images"] as List<dynamic>;

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
    String content,
    String base64Image,
  ) async {
    final requestBody = {
      "which_date": "2023-11-27",
      "title": title,
      "content": content,
      "image_base64": base64Image,
    };

    try {
      await post(
        '${dotenv.env["REST_API_HOST"]}/diaries',
        requestBody,
      );

      return Future.value(null);
    } on Exception catch (e) {
      return Future.error(e);
    }
  }
}
