import 'package:emodiary/util/log_on_dev.dart';
import 'package:get/get.dart';

class DiaryWritingProvider extends GetConnect {
  @override
  void onInit() {
    super.onInit();
    httpClient
      ..baseUrl = "http://localhost:8080/"
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

  Future<Response?> getPerson(String title, String content) async {
    final String url = "/users/id";
    final Response response = await get(url);

    if (response.status.hasError) {
      logOnDev("");
      return Future.error(response.body);
    } else {
      return null;
    }
  }
}
