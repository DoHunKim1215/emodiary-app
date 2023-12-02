class CalendarInfoModel {
  DateTime selectedDate;
  DateTime focusedDate;

  CalendarInfoModel({
    required this.selectedDate,
    required this.focusedDate,
  });

  CalendarInfoModel.selectedDate({
    required this.selectedDate,
  }) : focusedDate = selectedDate;

  CalendarInfoModel copyWith({
    DateTime? selectedDate,
    DateTime? focusedDate,
  }) {
    return CalendarInfoModel(
      selectedDate: selectedDate ?? this.selectedDate,
      focusedDate: focusedDate ?? this.focusedDate,
    );
  }
}
