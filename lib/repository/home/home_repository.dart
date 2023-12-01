import '../../model/e_emotion.dart';

class HomeRepository {
  int getContinuousDiaryCount(DateTime todayDate) {
    return 7;
  }

  Map<EEmotion, int> getEmotionScore(DateTime todayDate) {
    // 현재 월의 첫 번째 날짜 계산
    DateTime firstDayOfMonth = DateTime(todayDate.year, todayDate.month, 1);

    // 다음 월의 첫 번째 날짜 계산 (12월의 경우 다음 년도의 1월)
    DateTime nextMonth = todayDate.month < 12
        ? DateTime(todayDate.year, todayDate.month + 1, 1)
        : DateTime(todayDate.year + 1, 1, 1);

    // 현재 월의 마지막 날짜 계산
    DateTime lastDayOfMonth = nextMonth.subtract(const Duration(days: 1));

    Map<EEmotion, int> result = {
      EEmotion.BAD: 0,
      EEmotion.SOSO: 0,
      EEmotion.GOOD: 0,
      EEmotion.NONE: 0,
    };

    for (DateTime date = firstDayOfMonth;
        date.isBefore(lastDayOfMonth);
        date = date.add(const Duration(days: 1))) {
      if (date.day % 3 == 0) {
        result[EEmotion.SOSO] = result[EEmotion.SOSO]! + 1;
      } else if (date.day % 5 == 0) {
        result[EEmotion.BAD] = result[EEmotion.BAD]! + 1;
      } else {
        result[EEmotion.GOOD] = result[EEmotion.GOOD]! + 1;
      }
      // result[EEmotion.NONE] = result[EEmotion.NONE]! + 1;
    }

    return result;
  }

  // getTodayDiaries(DateTime todayDate) {}
  //
  // getYesterdayDiaries(DateTime todayDate) {}
}
