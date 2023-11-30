import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../calendar/calendar_info_model.dart';
import '../../model/Diary/calendar_diary_model.dart';
import '../../repository/diary/diary_calendar_repository.dart';

class DiaryCalendarViewModel extends GetxController {
  final DiaryCalendarRepository repository;

  /* constructor */
  DiaryCalendarViewModel({required this.repository});

  /* calendar info */
  late final Rx<CalendarInfoModel> _calendarInfo;
  DateTime get selectedDate => _calendarInfo.value.selectedDate;
  DateTime get focusedDate => _calendarInfo.value.focusedDate;

  /* calendar images */
  late final Rx<CalendarFormat> _calendarFormat;
  late final RxMap<String, RxString> _calendarImages;
  late final RxBool _isLoadingCalendarImages;
  CalendarFormat get calendarFormat => _calendarFormat.value;
  Map<String, Rx<String>> get calendarImages => _calendarImages;
  bool get isLoadingCalendarImages => _isLoadingCalendarImages.value;

  /* diaries */
  late final RxList<CalendarDiaryModel> _diaries;
  late final RxBool _isLoadingDiaries;
  List<CalendarDiaryModel> get diaries => _diaries;
  bool get isLoadingDiaries => _isLoadingDiaries.value;

  @override
  void onInit() {
    super.onInit();

    initLoading();
    initCalendarInfo();
    initCalendarImages();
    initDiaries();
  }

  /* init */
  void initCalendarInfo() {
    _calendarInfo = CalendarInfoModel.selectedDate(
      selectedDate: DateTime.now(),
    ).obs;
    _calendarFormat = CalendarFormat.week.obs;
  }

  void initLoading() {
    _isLoadingCalendarImages = false.obs;
    _isLoadingDiaries = false.obs;
  }

  void initCalendarImages() {
    _isLoadingCalendarImages.value = true;
    _calendarImages = repository
        .getCalendarImages(focusedDate)
        .map((key, value) => MapEntry(key, value.obs))
        .obs;
    _isLoadingCalendarImages.value = false;
  }

  void initDiaries() {
    _isLoadingDiaries.value = true;
    _diaries = repository.fetchDiaries(selectedDate).obs;
    _isLoadingDiaries.value = false;
  }

  /* Update */
  void updateCalendarImages() {
    _isLoadingCalendarImages.value = true;
    _calendarImages.value = repository
        .getCalendarImages(focusedDate)
        .map((key, value) => MapEntry(key, value.obs));
    _isLoadingCalendarImages.value = false;
  }

  void updateDiaries() {
    _isLoadingDiaries.value = true;
    _diaries.value = repository.fetchDiaries(selectedDate);
    _isLoadingDiaries.value = false;
  }

  void updateSelectedDate(DateTime selectedDate) {
    int beforeMonth = _calendarInfo.value.focusedDate.month;

    _calendarInfo.value = _calendarInfo.value.copyWith(
      selectedDate: selectedDate,
      focusedDate: selectedDate,
    );

    if (beforeMonth != selectedDate.month) {
      updateCalendarImages();
    }

    updateDiaries();
  }

  void updateFocusedDate(DateTime focusedDate) {
    int beforeMonth = _calendarInfo.value.focusedDate.month;
    _calendarInfo.value = _calendarInfo.value.copyWith(
      focusedDate: focusedDate,
    );

    if (beforeMonth != focusedDate.month) {
      updateCalendarImages();
    }
  }

  void updateCalendarFormat(CalendarFormat calendarFormat) {
    _calendarFormat.value = calendarFormat;
  }
}
