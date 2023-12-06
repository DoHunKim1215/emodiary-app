import 'package:emodiary/model/Diary/diary_small_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';

import '../../provider/Diary/diary_calendar_provider.dart';
import '../../util/class/datetime_util.dart';

class DiaryCalendarRepository {
  static final String SERVER_URL = dotenv.env['SERVER_HOST']!;

  final DiaryCalendarProvider _diaryCalendarProvider;

  DiaryCalendarRepository({
    required DiaryCalendarProvider diaryCalendarProvider,
  }) : _diaryCalendarProvider = diaryCalendarProvider;

  Future<Map<String, String>> fetchCalendarImages(DateTime focusedDate) async {
    DateTime firstDayOfCalendar =
        DateTimeUtil.getFirstDayOfCalendar(focusedDate);
    DateTime lastDayOfCalendar = DateTimeUtil.getLastDayOfCalendar(focusedDate);

    List<dynamic> data =
        await _diaryCalendarProvider.getDiariesByStartDateAndEndDate(
      firstDayOfCalendar,
      lastDayOfCalendar,
    );

    Map<String, String> result = {};

    for (var item in data) {
      DateTime date = DateTime.parse(item['date']);
      String imageUrl = item['image_url'] != null
          ? "$SERVER_URL/images/${item['image_url']}"
          : "";

      result[DateFormat("yyyy-MM-dd").format(date)] = imageUrl;
    }

    return result;
  }

  Future<List<DiarySmallModel>> fetchDiaries(DateTime selectedDate) async {
    List<dynamic> data =
        await _diaryCalendarProvider.getDiariesByWhichDate(selectedDate);

    List<DiarySmallModel> result = [];

    for (var item in data) {
      result.add(DiarySmallModel.fromJson(item, SERVER_URL));
    }

    return result;
  }
}
