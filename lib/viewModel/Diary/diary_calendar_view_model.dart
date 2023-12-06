import 'package:emodiary/model/Diary/diary_small_model.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../model/Diary/diary_calendar_info_model.dart';
import '../../repository/diary/diary_calendar_repository.dart';

class DiaryCalendarViewModel extends GetxController {
  final DiaryCalendarRepository repository;

  /* constructor */
  DiaryCalendarViewModel({required this.repository});

  /* calendar info */
  late final Rx<DiaryCalendarInfoModel> _calendarInfo;
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
  late final RxList<DiarySmallModel> _diaries;
  late final RxBool _isLoadingDiaries;
  List<DiarySmallModel> get diaries => _diaries;
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
    _calendarInfo = DiaryCalendarInfoModel.selectedDate(
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
    repository
        .fetchCalendarImages(focusedDate)
        .then((value) => _calendarImages =
            value.map((key, value) => MapEntry(key, value.obs)).obs)
        .then((value) => _isLoadingCalendarImages.value = false);
  }

  void initDiaries() {
    _isLoadingDiaries.value = true;
    repository
        .fetchDiaries(selectedDate)
        .then((value) => _diaries = value.obs)
        .then((value) => _isLoadingDiaries.value = false);
  }

  /* Update */
  void updateCalendarImages() {
    _isLoadingCalendarImages.value = true;
    repository
        .fetchCalendarImages(focusedDate)
        .then((value) => _calendarImages.value =
            value.map((key, value) => MapEntry(key, value.obs)))
        .then((value) => _isLoadingCalendarImages.value = false);
  }

  void updateDiaries() {
    _isLoadingDiaries.value = true;
    repository
        .fetchDiaries(selectedDate)
        .then((value) => _diaries.value = value)
        .then((value) => _isLoadingDiaries.value = false);
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
