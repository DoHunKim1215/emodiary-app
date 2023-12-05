import 'package:emodiary/model/Diary/diary_search_item_model.dart';
import 'package:emodiary/provider/Diary/diary_provider.dart';
import 'package:emodiary/util/function/log_on_dev.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class DiarySearchViewModel extends GetxController {
  static const int pageSize = 10;

  final DiaryProvider diaryProvider = DiaryProvider();
  Rx<PagingController<int, DiarySearchItemModel>> pagingController =
      Rx<PagingController<int, DiarySearchItemModel>>(
          PagingController(firstPageKey: 0));

  void init(String keyword) {
    pagingController.value.dispose();
    pagingController.value = PagingController(firstPageKey: 0);
    pagingController.value.addPageRequestListener((pageKey) {
      logOnDev(
        "♻️ [Diary Page Request Invoked] pageSize : $pageSize | pageKey : $pageKey",
      );
      fetchPage(keyword, pageKey);
    });
    pagingController.refresh();
  }

  Future<void> fetchPage(String keyword, int pageKey) async {
    try {
      final newItems = await diaryProvider.searchDiaries(
        keyword,
        pageSize,
        pageKey ~/ pageSize,
      );

      if (newItems.length < pageSize) {
        pagingController.value.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        pagingController.value.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      logOnDev("🚨 [Diary Page Request Error] $error");
      pagingController.value.error = error;
    }
  }
}
