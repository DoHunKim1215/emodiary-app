import 'package:intl/intl.dart';

import '../../calendar/datetime_util.dart';

class HomeRepository {
  Map<String, String> getCalendarImages(DateTime focusedDate) {
    DateTime firstDayOfMonth = DateTimeUtil.getFirstDayOfCalendar(focusedDate);
    DateTime lastDayOfMonth = DateTimeUtil.getLastDayOfCalendar(focusedDate);

    Map<String, String> result = {};

    for (DateTime date = firstDayOfMonth;
        date.isBefore(lastDayOfMonth);
        date = date.add(const Duration(days: 1))) {
      if (date.day % 3 == 0) {
        result[DateFormat("yyyy-MM-dd").format(date)] =
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTwmJDU6pQfsJLENRbU7UyxAL5O4sewnbo80WfQTuWI0w&s";
      } else if (date.day % 5 == 0) {
        result[DateFormat("yyyy-MM-dd").format(date)] =
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQijnpaljet5Rxk83NpjZLPxCIo40R5nVko3bvHWgzQ&s";
      } else {
        result[DateFormat("yyyy-MM-dd").format(date)] = "";
      }
    }

    return result;
  }
}
