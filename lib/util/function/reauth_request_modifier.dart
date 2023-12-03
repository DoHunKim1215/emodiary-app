import 'dart:async';

import 'package:emodiary/util/enum/secure_token_key.dart';
import 'package:emodiary/util/function/log_on_dev.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';

FutureOr<Request<T>> reauthRequestModifier<T>(Request<T?> request) async {
  const storage = FlutterSecureStorage();
  final accessToken = await storage.read(key: AuthToken.accessToken.key);

  if (accessToken == null) {
    logOnDev("🔑 Access Token Dose Not Exist..");
    Get.offAllNamed("/login");
    return request as Request<T>;
  }

  request.headers.addAll(<String, String>{
    "Authorization": "Bearer $accessToken",
  });

  logOnDev("🛫 [${request.method}] ${request.url} | START");

  return request as Request<T>;
}
