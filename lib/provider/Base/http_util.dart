import 'dart:io';

import 'package:dio/dio.dart';
import 'package:emodiary/util/enum/secure_token_key.dart';
import 'package:emodiary/util/function/log_on_dev.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/route_manager.dart';

class HttpUtil {
  /* PUBLIC */
  late Dio dio;
  late Dio authDio;

  factory HttpUtil() => _instance;

  /* PRIVATE */
  static const _secureStorage = FlutterSecureStorage();
  static final _baseOption = BaseOptions(
    baseUrl: '${dotenv.env['REST_API_HOST']}',
    connectTimeout: const Duration(milliseconds: 5000),
    receiveTimeout: const Duration(milliseconds: 3000),
    contentType: 'application/json; charset=utf-8',
    responseType: ResponseType.json,
    headers: <String, dynamic>{},
  );

  static final HttpUtil _instance = HttpUtil._configDio();

  late Dio _refreshDio;
  late Dio _reRequestDio;

  HttpUtil._default();

  factory HttpUtil._configDio() {
    final httpUtil = HttpUtil._default();

    httpUtil.dio = Dio(_baseOption);
    httpUtil.dio.interceptors
      ..clear()
      ..add(
        InterceptorsWrapper(
          onRequest: httpUtil._onRequest,
          onResponse: httpUtil._onResponse,
          onError: httpUtil._onError,
        ),
      );

    httpUtil._reRequestDio = Dio(_baseOption);
    httpUtil._reRequestDio.interceptors
      ..clear()
      ..add(
        InterceptorsWrapper(
          onRequest: httpUtil._onRequest,
          onResponse: httpUtil._onResponse,
          onError: httpUtil._onError,
        ),
      );

    httpUtil._refreshDio = Dio(_baseOption);
    httpUtil._refreshDio.interceptors
      ..clear()
      ..add(
        InterceptorsWrapper(
          onError: httpUtil._onRefreshError,
        ),
      );

    httpUtil.authDio = Dio(_baseOption);
    httpUtil.authDio.interceptors
      ..clear()
      ..add(
        InterceptorsWrapper(
          onRequest: httpUtil._onAuthRequest,
          onResponse: httpUtil._onResponse,
          onError: httpUtil._onAuthError,
        ),
      );

    return httpUtil;
  }

  void _onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    logOnDev("🛫 [${options.method}] ${options.path} | START");
    return handler.next(options);
  }

  void _onAuthRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final accessToken = await _secureStorage.read(
      key: AuthToken.accessToken.key,
    );

    if (accessToken == null) {
      logOnDev("🔑 [Dio Interceptor] Access Token Not Found");
      Get.offAllNamed("/entry");
      return;
    }

    options.headers[HttpHeaders.authorizationHeader] = 'Bearer $accessToken';

    logOnDev("🛫 [${options.method}] ${options.path} | START");

    return handler.next(options);
  }

  void _onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) async {
    logOnDev(
      "🛬 [${response.requestOptions.method}] ${response.requestOptions.path} | SUCCESS (${response.statusCode})",
    );

    return handler.next(response);
  }

  void _onError(
    DioException error,
    ErrorInterceptorHandler handler,
  ) {
    logOnDev(
      "🚨 [${error.requestOptions.method}] ${error.requestOptions.path} | ERROR : ${error.message}",
    );

    return handler.next(error);
  }

  void _onAuthError(
    DioException error,
    ErrorInterceptorHandler handler,
  ) async {
    logOnDev(
      "🚨 [${error.requestOptions.method}] ${error.requestOptions.path} | ERROR : ${error.message}",
    );

    if (error.response?.statusCode == HttpStatus.unauthorized) {
      logOnDev("♻️ [Dio Interceptor] Token Refresh Occurred");

      final refreshToken =
          await _secureStorage.read(key: AuthToken.refreshToken.key);
      _refreshDio.options.headers[HttpHeaders.authorizationHeader] =
          'Bearer $refreshToken';

      try {
        final refreshResponse = await _refreshDio.post('/auth/reissue');

        logOnDev("🎉 [Dio Interceptor] Token Refresh Successes");

        final newAccessToken =
            refreshResponse.data["data"][AuthToken.accessToken.jsonKey];
        final newRefreshToken =
            refreshResponse.data["data"][AuthToken.refreshToken.jsonKey];

        await _secureStorage.write(
          key: AuthToken.accessToken.key,
          value: newAccessToken,
        );
        await _secureStorage.write(
          key: AuthToken.refreshToken.key,
          value: newRefreshToken,
        );

        error.requestOptions.headers[HttpHeaders.authorizationHeader] =
            'Bearer $newAccessToken';

        logOnDev(
            "🔑 [Dio Interceptor] New Token Set | Access Token: $newAccessToken");

        final reRequestedResponse = await _reRequestDio.request(
          error.requestOptions.path,
          options: Options(
            method: error.requestOptions.method,
            headers: error.requestOptions.headers,
          ),
          data: error.requestOptions.data,
          queryParameters: error.requestOptions.queryParameters,
        );

        return handler.resolve(reRequestedResponse);
      } on DioException catch (error) {
        return handler.next(error);
      }
    }

    return handler.next(error);
  }

  void _onRefreshError(
    DioException error,
    ErrorInterceptorHandler handler,
  ) async {
    logOnDev("🚨️ [Dio Interceptor] Token Refresh Failed");

    if (error.response?.statusCode == 401 ||
        error.response?.statusCode == 404) {
      await _secureStorage.deleteAll();
      Get.offAllNamed("/entry");
    }

    return handler.next(error);
  }
}
