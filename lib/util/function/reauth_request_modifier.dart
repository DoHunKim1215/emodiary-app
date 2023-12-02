import 'dart:async';

import 'package:emodiary/util/function/log_on_dev.dart';
import 'package:get/get_connect/http/src/request/request.dart';

FutureOr<Request<T>> reauthRequestModifier<T>(Request<T?> request) async {
  logOnDev("🛫 [${request.method}] ${request.url} | START");

  const storage = FlutterSecureStorage();

  final accessToken = await storage.read(key: 'ACCESS_TOKEN');

  if (accessToken == null) {
    get_x.Get.offAllNamed("/login");
    return;
  }

  /* Already Exist Token */
  if (kDebugMode) {
    print('🔑 [Already Exist Token] $accessToken');
  }

  options.headers['Authorization'] = 'Bearer $accessToken';

  /* Request Logging */
  if (kDebugMode) {
    print('🛫 [${options.method}] ${options.path} | START');
  }

  return request as Request<T>;
}
