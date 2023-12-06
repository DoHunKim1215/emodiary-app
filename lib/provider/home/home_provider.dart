import 'package:emodiary/provider/base/base_connect.dart';

class HomeProvider extends BaseConnect {
  Future getNotice() async {
    try {
      final response = await get('/notice');
      return response.body;
    } on Exception catch (e) {
      return Future.error(e);
    }
  }
}
