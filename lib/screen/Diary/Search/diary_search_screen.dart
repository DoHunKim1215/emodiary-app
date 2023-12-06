import 'package:emodiary/model/Diary/diary_search_item_model.dart';
import 'package:emodiary/provider/Diary/diary_provider.dart';
import 'package:emodiary/screen/Diary/Search/Widget/first_page_error_indicator.dart';
import 'package:emodiary/screen/Diary/Search/Widget/new_page_error_indicator.dart';
import 'package:emodiary/screen/Diary/Search/Widget/no_items_found_indicator.dart';
import 'package:emodiary/screen/Diary/Search/Widget/no_more_items_indicator.dart';
import 'package:emodiary/screen/Diary/Search/Widget/search_result_item_row.dart';
import 'package:emodiary/util/function/log_on_dev.dart';
import 'package:emodiary/widget/base/leading_appbar.dart';
import 'package:emodiary/widget/base/thin_bottom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class DiarySearchScreen extends StatefulWidget {
  const DiarySearchScreen({super.key});

  @override
  State<DiarySearchScreen> createState() => _DiarySearchScreenState();
}

class _DiarySearchScreenState extends State<DiarySearchScreen> {
  static const int pageSize = 10;
  static const int searchKeywordMaxLength = 20;

  final FocusNode focusNode = FocusNode();
  late TextEditingController _searchKeywordCtrl;

  bool isFirstSearch = true;

  final DiaryProvider diaryProvider = DiaryProvider();
  PagingController<int, DiarySearchItemModel> pagingController =
      PagingController(firstPageKey: 0);

  Future<void> fetchPage(String keyword, int pageKey) async {
    try {
      final newItems = await diaryProvider.searchDiaries(
        keyword,
        pageSize,
        pageKey ~/ pageSize,
      );

      if (newItems.length < pageSize) {
        pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      logOnDev("🚨 [Diary Page Request Error] $error");
      pagingController.error = error;
    }
  }

  void onPressSearch() {
    if (isFirstSearch) {
      setState(() {
        isFirstSearch = false;
      });
    }
    pagingController.refresh();
  }

  @override
  void initState() {
    _searchKeywordCtrl = TextEditingController();
    pagingController.addPageRequestListener((pageKey) {
      logOnDev(
        "♻️ [Diary Page Request Invoked] pageSize : $pageSize | pageKey : $pageKey",
      );
      fetchPage(_searchKeywordCtrl.text, pageKey);
    });
    super.initState();
  }

  @override
  void dispose() {
    pagingController.dispose();
    _searchKeywordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: focusNode.unfocus,
      child: Container(
        color: const Color(0xFFF3F6FD),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: const Color(0xFFF3F6FD),
            resizeToAvoidBottomInset: false,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: LeadingAppBar(
                title: "일기 검색",
                color: const Color(0xFFF3F6FD),
                onPressed: Get.back,
              ),
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextField(
                    controller: _searchKeywordCtrl,
                    focusNode: focusNode,
                    onChanged: (_) {
                      setState(() {});
                    },
                    maxLength: searchKeywordMaxLength,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                    ),
                    decoration: InputDecoration(
                      counterText: "",
                      hintText: '제목과 내용으로 검색하기',
                      hintStyle: const TextStyle(
                        color: Color(0xFFBABDBF),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                      ),
                      suffixIconConstraints: const BoxConstraints(
                        minHeight: 20,
                        minWidth: 20,
                      ),
                      suffixIcon: GestureDetector(
                        onTap: _searchKeywordCtrl.clear,
                        child: SvgPicture.asset(
                          "assets/icons/clear.svg",
                          width: 20,
                          height: 20,
                        ),
                      ),
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 13.0,
                        horizontal: 0.0,
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF7541EF),
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: ThinBottomButton(
                          onPressed: onPressSearch,
                          text: "검색하기",
                          isReversed: false,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: isFirstSearch ? 0 : 10,
                ),
                Expanded(
                  child: isFirstSearch
                      ? const Center(
                          child: Text(
                            "키워드로 일기를 검색해보세요.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Color(0xFF656D78),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      : RefreshIndicator(
                          child: PagedListView<int,
                              DiarySearchItemModel>.separated(
                            pagingController: pagingController,
                            builderDelegate:
                                PagedChildBuilderDelegate<DiarySearchItemModel>(
                              animateTransitions: true,
                              itemBuilder: (context, item, index) =>
                                  SearchResultItemRow(model: item),
                              firstPageErrorIndicatorBuilder: (_) =>
                                  FirstPageErrorIndicator(
                                onTryAgain: () => pagingController.refresh(),
                              ),
                              newPageErrorIndicatorBuilder: (_) =>
                                  NewPageErrorIndicator(
                                onTryAgain: () =>
                                    pagingController.retryLastFailedRequest(),
                              ),
                              noItemsFoundIndicatorBuilder: (_) =>
                                  const NoItemsFoundIndicator(),
                              noMoreItemsIndicatorBuilder: (_) =>
                                  const NoMoreItemsIndicator(),
                              // <Loading Spinner Customizer>
                              // firstPageProgressIndicatorBuilder: (_) =>
                              //     FirstPageProgressIndicator(),
                              // newPageProgressIndicatorBuilder: (_) =>
                              //     NewPageProgressIndicator(),
                            ),
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const SizedBox(height: 0),
                          ),
                          onRefresh: () => Future.sync(
                            () => pagingController.refresh(),
                          ),
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
