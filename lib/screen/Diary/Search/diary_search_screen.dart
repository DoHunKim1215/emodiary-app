import 'package:emodiary/model/Diary/diary_search_item_model.dart';
import 'package:emodiary/screen/Diary/Search/Widget/search_result_item_row.dart';
import 'package:emodiary/widget/base/leading_appbar.dart';
import 'package:emodiary/widget/base/thin_bottom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DiarySearchScreen extends StatefulWidget {
  const DiarySearchScreen({super.key});

  @override
  State<DiarySearchScreen> createState() => _DiarySearchScreenState();
}

class _DiarySearchScreenState extends State<DiarySearchScreen> {
  static const int searchKeywordMaxLength = 20;

  final FocusNode focusNode = FocusNode();
  late TextEditingController _searchKeywordCtrl;

  @override
  void initState() {
    super.initState();
    _searchKeywordCtrl = TextEditingController();
  }

  @override
  void dispose() {
    _searchKeywordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        focusNode.unfocus();
      },
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
                onPressed: () {
                  Get.back();
                },
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  TextField(
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
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ThinBottomButton(
                          onPressed: () {},
                          text: "검색하기",
                          isReversed: false,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SearchResultItemRow(
                    model: DiarySearchItemModel(
                      id: 1,
                      title: "오늘도 밥을 먹었습니다.",
                      createdDate: DateFormat("yyyy-MM-dd").parse("2023-11-30"),
                      imageUrl: "assets/images/ex1.png",
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SearchResultItemRow(
                    model: DiarySearchItemModel(
                      id: 2,
                      title: "오늘은 밥을 먹었습니다.",
                      createdDate: DateFormat("yyyy-MM-dd").parse("2023-11-29"),
                      imageUrl: "assets/images/ex2.png",
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SearchResultItemRow(
                    model: DiarySearchItemModel(
                      id: 3,
                      title: "그래도",
                      createdDate: DateFormat("yyyy-MM-dd").parse("2023-11-28"),
                      imageUrl: "assets/images/ex3.png",
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SearchResultItemRow(
                    model: DiarySearchItemModel(
                      id: 4,
                      title: "재밌으니까",
                      createdDate: DateFormat("yyyy-MM-dd").parse("2023-11-27"),
                      imageUrl: "assets/images/ex4.png",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
