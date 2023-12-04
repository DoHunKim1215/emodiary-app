import 'package:emodiary/provider/SignUp/signup_provider.dart';
import 'package:emodiary/util/enum/secure_token_key.dart';
import 'package:emodiary/util/function/log_on_dev.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<String> getInitialRoute() async {
  final SignUpProvider signUpProvider = SignUpProvider();

  const secureStorage = FlutterSecureStorage();
  final accessToken = await secureStorage.read(key: AuthToken.accessToken.key);
  final refreshToken =
      await secureStorage.read(key: AuthToken.refreshToken.key);

  if (accessToken == null || refreshToken == null) {
    logOnDev(
      "🚨 Access Token Or Refresh Token Not Found => Login Entry Screen",
    );
    const secureStorage = FlutterSecureStorage();
    await secureStorage.deleteAll();
    return "/entry";
  }

  bool isSuccess = await signUpProvider.refresh(refreshToken);

  if (isSuccess) {
    logOnDev("🎉 Token Refresh Successes => Home Screen");
    return "/";
  } else {
    logOnDev("🚨 Token Refresh Failed => Login Entry Screen");
    const secureStorage = FlutterSecureStorage();
    await secureStorage.deleteAll();
    return "/entry";
  }
}
