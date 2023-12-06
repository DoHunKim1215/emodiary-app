import 'package:emodiary/model/Diary/diary_small_model.dart';
import 'package:emodiary/model/User/user_model.dart';
import 'package:emodiary/provider/home/home_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../model/e_emotion.dart';
import '../../util/class/datetime_util.dart';

class HomeRepository {
  static final String SERVER_URL = dotenv.env['SERVER_HOST']!;
  final HomeProvider _homeProvider;

  HomeRepository({
    required HomeProvider homeProvider,
  }) : _homeProvider = homeProvider;

  Future<int> readContinuousDiaryCount() async {
    Map<String, dynamic> data = await _homeProvider.getContinuousDiaryCount();

    return data['continuous_diary_count'];
  }

  Future<Map<EEmotion, int>> readEmotionScore(DateTime todayDate) async {
    final DateTime firstDayOfMonth = DateTimeUtil.getFirstDayOfMonth(todayDate);
    final DateTime lastDayOfMonth = DateTimeUtil.getLastDayOfMonth(todayDate);

    List<dynamic> data =
        await _homeProvider.getEmotionScore(firstDayOfMonth, lastDayOfMonth);

    Map<EEmotion, int> result = {
      EEmotion.BAD: 0,
      EEmotion.SOSO: 0,
      EEmotion.GOOD: 0,
      EEmotion.NONE: 0,
    };

    for (var item in data) {
      int score = item['emotion_score'];

      if (score == -1) {
        result[EEmotion.NONE] = result[EEmotion.NONE]! + 1;
      } else if (0 <= score && score < 4) {
        result[EEmotion.BAD] = result[EEmotion.BAD]! + 1;
      } else if (4 <= score && score < 7) {
        result[EEmotion.SOSO] = result[EEmotion.SOSO]! + 1;
      } else if (7 <= score && score < 11) {
        result[EEmotion.GOOD] = result[EEmotion.GOOD]! + 1;
      }
    }

    if (result[EEmotion.BAD] != 0 ||
        result[EEmotion.SOSO] != 0 ||
        result[EEmotion.GOOD] != 0) {
      result[EEmotion.NONE] = 0;
    }

    return result;
  }

  Future<DiarySmallModel> readDiaryByDate(DateTime date) async {
    List<dynamic> data =
        await _homeProvider.getDiariesByStartDateAndEndDate(date, date);

    return DiarySmallModel.fromJson(data[0], SERVER_URL);
  }

  Future<List<DiarySmallModel>> readDiaryByStartDateAndEndDate(
      DateTime startDate, endDate) async {
    var data =
        await _homeProvider.getDiariesByStartDateAndEndDate(startDate, endDate);

    List<DiarySmallModel> result = [];

    for (var item in data) {
      result.add(DiarySmallModel.fromJson(item, SERVER_URL));
    }

    return result;
  }

  Future<UserModel> readUserInfo() async {
    Map<String, dynamic> data = await _homeProvider.getUserInfo();

    return UserModel.fromJson(data);
  }
}
