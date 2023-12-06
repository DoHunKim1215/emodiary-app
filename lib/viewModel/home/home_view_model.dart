import 'package:emodiary/model/Diary/diary_small_model.dart';
import 'package:emodiary/model/User/user_model.dart';
import 'package:emodiary/repository/home/home_repository.dart';
import 'package:get/get.dart';

import '../../model/e_emotion.dart';

class HomeViewModel extends GetxController {
  final HomeRepository _repository;

  /* constructor */
  HomeViewModel({required HomeRepository repository})
      : _repository = repository;

  /* home info */
  late final Rx<DateTime> _todayDate;
  DateTime get todayDate => _todayDate.value;

  late final Rx<UserModel> _userModel;
  late final RxBool _isLoadingUserModel;
  UserModel get userModel => _userModel.value;
  bool get isLoadingUserModel => _isLoadingUserModel.value;

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
  late final Rx<DiarySmallModel> _todayDiary;
  late final RxBool _isLoadingTodayDiaries;
  DiarySmallModel get todayDiary => _todayDiary.value;
  bool get isLoadingTodayDiary => _isLoadingTodayDiaries.value;

  late final Rx<DiarySmallModel> _yesterdayDiary;
  late final RxBool _isLoadingYesterdayDiaries;
  DiarySmallModel get yesterdayDiary => _yesterdayDiary.value;
  bool get isLoadingYesterdayDiary => _isLoadingYesterdayDiaries.value;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initTodayDate();
    initLoading();

    initUserModel();
    initContinuousDiaryCount();
    initEmotionScore();
    initTodayDiaries();
    initYesterdayDiaries();
  }

  /* init */
  void initTodayDate() {
    _todayDate = DateTime.now().obs;
  }

  void initLoading() {
    _isLoadingUserModel = false.obs;
    _isLoadingContinuousDiaryCount = false.obs;
    _isLoadingEmotionScore = false.obs;
    _isLoadingTodayDiaries = false.obs;
    _isLoadingYesterdayDiaries = false.obs;
  }

  void initUserModel() {
    _isLoadingUserModel.value = true;
    _repository
        .readUserInfo()
        .then((value) => _userModel = value.obs)
        .then((value) => _isLoadingUserModel.value = false);
  }

  void initContinuousDiaryCount() {
    _isLoadingContinuousDiaryCount.value = true;
    _repository
        .readContinuousDiaryCount()
        .then((value) => _continuousDiaryCount = value.obs)
        .then((value) => _isLoadingContinuousDiaryCount.value = false);
  }

  void initEmotionScore() {
    _isLoadingEmotionScore.value = true;
    _repository
        .readEmotionScore(todayDate)
        .then((value) => {
              _emotionScore =
                  value.map((key, value) => MapEntry(key, value.obs)).obs
            })
        .then((value) => _isLoadingEmotionScore.value = false);
  }

  void initTodayDiaries() {
    _isLoadingTodayDiaries.value = true;
    _repository
        .readDiaryByDate(todayDate)
        .then((value) => _todayDiary = value.obs)
        .then((value) => _isLoadingTodayDiaries.value = false);
  }

  void initYesterdayDiaries() {
    _isLoadingYesterdayDiaries.value = true;
    _repository
        .readDiaryByDate(todayDate.subtract(const Duration(days: 1)))
        .then((value) => _yesterdayDiary = value.obs)
        .then((value) => _isLoadingYesterdayDiaries.value = false);
  }

  /* update */
  void fetchContinuousDiaryCount() {
    _isLoadingContinuousDiaryCount.value = true;
    _repository
        .readContinuousDiaryCount()
        .then((value) => _continuousDiaryCount.value = value)
        .then((value) => _isLoadingContinuousDiaryCount.value = false);
  }

  void fetchEmotionScore() {
    _isLoadingEmotionScore.value = true;
    _repository
        .readEmotionScore(todayDate)
        .then((value) => {
              _emotionScore.value =
                  value.map((key, value) => MapEntry(key, value.obs))
            })
        .then((value) => _isLoadingEmotionScore.value = false);
  }

  void fetchTodayDiaries() {
    _isLoadingTodayDiaries.value = true;
    _repository
        .readDiaryByDate(todayDate)
        .then((value) => _todayDiary.value = value)
        .then((value) => _isLoadingTodayDiaries.value = false);
  }

  void fetchYesterdayDiaries() {
    _isLoadingYesterdayDiaries.value = true;
    _repository
        .readDiaryByDate(todayDate.subtract(const Duration(days: 1)))
        .then((value) => _yesterdayDiary.value = value)
        .then((value) => _isLoadingYesterdayDiaries.value = false);
  }
}
