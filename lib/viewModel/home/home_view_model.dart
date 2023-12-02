import 'package:emodiary/repository/home/home_repository.dart';
import 'package:get/get.dart';

import '../../model/Diary/calendar_diary_model.dart';
import '../../model/e_emotion.dart';

class HomeViewModel extends GetxController {
  final HomeRepository _repository;

  /* constructor */
  HomeViewModel({required HomeRepository repository})
      : _repository = repository;

  /* home info */
  late final Rx<DateTime> _todayDate;
  DateTime get todayDate => _todayDate.value;

  /* continuous diary count info */
  late final RxInt _continuousDiaryCount;
  late final RxBool _isLoadingContinuousDiaryCount;
  int get continuousDiaryCount => _continuousDiaryCount.value;
  bool get isLoadingContinuousDiaryCount =>
      _isLoadingContinuousDiaryCount.value;

  /* emotion info */
  late final RxMap<EEmotion, RxInt> _emotionScore;
  late final RxBool _isLoadingEmotionScore;
  Map<EEmotion, RxInt> get emotionScore => _emotionScore;
  bool get isLoadingEmotionScore => _isLoadingEmotionScore.value;

  /* diaries info */
  late final RxList<CalendarDiaryModel> _todayDiaries;
  late final RxBool _isLoadingTodayDiaries;
  List<CalendarDiaryModel> get todayDiaries => _todayDiaries;
  bool get isLoadingTodayDiaries => _isLoadingTodayDiaries.value;

  late final RxList<CalendarDiaryModel> _yesterdayDiaries;
  late final RxBool _isLoadingYesterdayDiaries;
  List<CalendarDiaryModel> get yesterdayDiaries => _yesterdayDiaries;
  bool get isLoadingYesterdayDiaries => _isLoadingYesterdayDiaries.value;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initTodayDate();
    initLoading();

    initContinuousDiaryCount();
    initEmotionScore();
    // initTodayDiaries();
    // initYesterdayDiaries();
  }

  /* init */
  void initTodayDate() {
    _todayDate = DateTime.now().obs;
  }

  void initLoading() {
    _isLoadingContinuousDiaryCount = false.obs;
    _isLoadingEmotionScore = false.obs;
    _isLoadingTodayDiaries = false.obs;
    _isLoadingYesterdayDiaries = false.obs;
  }

  void initContinuousDiaryCount() {
    _isLoadingContinuousDiaryCount.value = true;
    _continuousDiaryCount = _repository.getContinuousDiaryCount(todayDate).obs;
    _isLoadingContinuousDiaryCount.value = false;
  }

  void initEmotionScore() {
    _isLoadingEmotionScore.value = true;
    _emotionScore = _repository
        .getEmotionScore(todayDate)
        .map((key, value) => MapEntry(key, value.obs))
        .obs;
    _isLoadingEmotionScore.value = false;
  }

  // void initTodayDiaries() {
  //   _isLoadingTodayDiaries.value = true;
  //   _todayDiaries = _repository.getTodayDiaries(todayDate).obs;
  //   _isLoadingTodayDiaries.value = false;
  // }
  //
  // void initYesterdayDiaries() {
  //   _isLoadingYesterdayDiaries.value = true;
  //   _yesterdayDiaries = _repository.getYesterdayDiaries(todayDate).obs;
  //   _isLoadingYesterdayDiaries.value = false;
  // }

  /* update */
  void fetchEmotionScore() {
    _isLoadingEmotionScore.value = true;
    _emotionScore.value = _repository
        .getEmotionScore(todayDate)
        .map((key, value) => MapEntry(key, value.obs));
    _isLoadingEmotionScore.value = false;
  }

  // void fetchTodayDiaries() {
  //   _isLoadingTodayDiaries.value = true;
  //   _todayDiaries.value = _repository.getTodayDiaries(todayDate);
  //   _isLoadingTodayDiaries.value = false;
  // }
  //
  // void fetchYesterdayDiaries() {
  //   _isLoadingYesterdayDiaries.value = true;
  //   _yesterdayDiaries.value = _repository.getYesterdayDiaries(todayDate);
  //   _isLoadingYesterdayDiaries.value = false;
  // }
}
