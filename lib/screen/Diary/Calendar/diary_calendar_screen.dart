import 'package:cached_network_image/cached_network_image.dart';
import 'package:emodiary/model/Diary/diary_small_model.dart';
import 'package:emodiary/screen/Diary/Calendar/widget/diary_calendar.dart';
import 'package:emodiary/util/function/log_on_dev.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../provider/Diary/diary_calendar_provider.dart';
import '../../../repository/diary/diary_calendar_repository.dart';
import '../../../viewModel/Diary/diary_calendar_view_model.dart';
import '../../../widget/base/default_back_appbar.dart';

class DiaryCalendarScreen extends StatelessWidget {
  const DiaryCalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DiaryCalendarViewModel viewModel = Get.put(
      DiaryCalendarViewModel(
        repository: DiaryCalendarRepository(
          diaryCalendarProvider: Get.put(
            DiaryCalendarProvider(),
          ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: DefaultBackAppbar(
          title: '일기 달력',
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: DiaryCalendar(viewModel: viewModel),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 2,
              color: const Color(0xFFE5E5E5),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            sliver: SliverToBoxAdapter(
              child: Obx(
                () => Text(
                  DateFormat('yyyy년 MM월 d일').format(viewModel.focusedDate),
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
          ),
          Obx(
            () => viewModel.isLoadingDiaries
                ? const SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : (viewModel.diaries.isEmpty
                    ? const SliverToBoxAdapter(
                        child: SizedBox(
                          height: 100,
                          child: Center(
                            child: Text(
                              '작성한 일기가 없어요',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      )
                    : SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        sliver: SliverGrid(
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent:
                                (MediaQuery.of(context).size.width / 2),
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return _DiaryImage(
                                model: viewModel.diaries[index],
                              );
                            },
                            childCount: viewModel.diaries.length,
                          ),
                        ),
                      )),
          ),
          const SliverToBoxAdapter(
              child: SizedBox(
            height: 50,
          ))
        ],
      ),
    );
  }
}

class _DiaryImage extends StatelessWidget {
  final DiarySmallModel model;
  const _DiaryImage({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: InkWell(
        onTap: () {
          print(model.id);
          Get.toNamed(
            '/diary',
            arguments: {'id': model.id},
          );
        },
        child: Container(
          margin: const EdgeInsets.all(5),
          child: CachedNetworkImage(
            imageUrl: model.imageUrl,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
