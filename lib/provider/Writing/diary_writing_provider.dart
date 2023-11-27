import 'package:emodiary/util/function/log_on_dev.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class DiaryWritingProvider extends GetConnect {
  @override
  void onInit() {
    super.onInit();
    httpClient
      ..defaultContentType = "application/json"
      ..timeout = const Duration(seconds: 30)
      ..addRequestModifier<dynamic>((request) {
        logOnDev("🛫 [${request.method}] ${request.url} | START");
        return request;
      })
      ..addResponseModifier((request, Response response) {
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

  Future<List<String>> getPictures() async {
    final requestBody = <String, dynamic>{
      "prompt":
          "beautiful summer weather, refreshing breeze, vibrant flowers, lush green trees beautiful, Hand-drawn, Pastel, Warm, Colored pencils, Soft, by Oscar-Claude Monet",
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
}
