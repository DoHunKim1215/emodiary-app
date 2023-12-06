import 'package:emodiary/provider/Auth/auth_provider.dart';
import 'package:emodiary/util/enum/secure_token_key.dart';
import 'package:emodiary/util/function/log_on_dev.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<String> getInitialRoute() async {
  final AuthProvider signUpProvider = AuthProvider();

  const secureStorage = FlutterSecureStorage();
  final accessToken = await secureStorage.read(key: AuthToken.accessToken.key);
  final refreshToken =
      await secureStorage.read(key: AuthToken.refreshToken.key);

  logOnDev(
    "🔑 [Initial Route] accessToken : $accessToken",
  );
  logOnDev(
    "🔑 [Initial Route] refreshToken : $refreshToken",
  );

  if (accessToken == null || refreshToken == null) {
    logOnDev(
      "🚨 [Initial Route] Access Token Or Refresh Token Not Found => Login Entry Screen",
    );
    const secureStorage = FlutterSecureStorage();
    await secureStorage.deleteAll();
    return "/entry";
  }

  bool isSuccess = await signUpProvider.refresh(refreshToken);

  if (isSuccess) {
    logOnDev("🎉 [Initial Route] Token Refresh Successes => Home Screen");
    return "/";
  } else {
    logOnDev("🚨 [Initial Route] Token Refresh Failed => Login Entry Screen");
    const secureStorage = FlutterSecureStorage();
    await secureStorage.deleteAll();
    return "/entry";
  }
}
