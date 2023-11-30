import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../calendar/calendar_info_model.dart';
import '../../repository/home/home_repository.dart';

class HomeViewModel extends GetxController {
  final HomeRepository repository;

  /* constructor */
  HomeViewModel({required this.repository});

  /* calendar info */
  late final Rx<CalendarInfoModel> _calendarInfo;
  DateTime get selectedDate => _calendarInfo.value.selectedDate;
  DateTime get focusedDate => _calendarInfo.value.focusedDate;

  /* calendar images */
  late final CalendarFormat calendarFormat;
  late final RxMap<String, RxString> _calendarImages;
  late final RxBool _isLoadingCalendarImages;
  Map<String, Rx<String>> get calendarImages => _calendarImages;
  bool get isLoadingCalendarImages => _isLoadingCalendarImages.value;

  @override
  void onInit() {
    super.onInit();

    initLoading();
    initCalendarInfo();
    initCalendarImages();
  }

  /* init */
  void initCalendarInfo() {
    _calendarInfo = CalendarInfoModel.selectedDate(
      selectedDate: DateTime.now(),
    ).obs;
    calendarFormat = CalendarFormat.month;
  }

  void initLoading() {
    _isLoadingCalendarImages = false.obs;
  }

  void initCalendarImages() {
    _isLoadingCalendarImages.value = true;
    _calendarImages = repository
        .getCalendarImages(focusedDate)
        .map((key, value) => MapEntry(key, value.obs))
        .obs;
    _isLoadingCalendarImages.value = false;
  }

  /* Update */
  void updateCalendarImages() {
    _isLoadingCalendarImages.value = true;
    _calendarImages.value = repository
        .getCalendarImages(focusedDate)
        .map((key, value) => MapEntry(key, value.obs));
    _isLoadingCalendarImages.value = false;
  }

  void updateSelectedDate(DateTime selectedDate) {
    _calendarInfo.value = _calendarInfo.value.copyWith(
      selectedDate: selectedDate,
    );
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
}
