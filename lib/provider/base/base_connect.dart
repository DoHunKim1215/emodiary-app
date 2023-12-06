import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_connect/connect.dart';

import '../../util/function/log_on_dev.dart';

abstract class BaseConnect extends GetConnect {
  @override
  void onInit() {
    super.onInit();
    httpClient
      ..baseUrl = dotenv.env['REST_API_HOST']
      ..defaultContentType = "application/json"
      ..timeout = const Duration(seconds: 30)
      ..addRequestModifier<dynamic>((request) {
        request.headers['Authorization'] =
            'Bearer eyJKV1QiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJ1aWQiOjEsInJvbCI6IkFETUlOIiwiaWF0IjoxNzAxNzExNTEwLCJleHAiOjE3MDE3MTg3MTB9.z75EMxLsh6YIc6qF4zEmssaDMWIP3mLC4EtENYPqZtogJ_g2bQy9JPkZ1EQIFC7SXmNpe3q3124CSluAQvEWMw';

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
}
