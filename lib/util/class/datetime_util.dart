class DateTimeUtil {
  static DateTime getFirstDayOfCalendar(DateTime date) {
    DateTime firstDay = getFirstDayOfMonth(date);
    int difference = firstDay.weekday == 7 ? 0 : firstDay.weekday;
    DateTime startOfCalendar = firstDay.subtract(Duration(days: difference));

    return startOfCalendar;
  }

  static DateTime getLastDayOfCalendar(DateTime date) {
    DateTime lastDay = getLastDayOfMonth(date);
    int difference = lastDay.weekday == 7 ? 6 : 6 - lastDay.weekday;
    DateTime endOfCalendar = lastDay.add(Duration(days: difference));

    return endOfCalendar;
  }

  static DateTime getFirstDayOfMonth(DateTime date) =>
      DateTime(date.year, date.month, 1);

  static DateTime getLastDayOfMonth(DateTime date) {
    DateTime nextMonth = DateTime(date.year, date.month + 1, 1);
    return nextMonth.subtract(const Duration(days: 1));
  }
}
