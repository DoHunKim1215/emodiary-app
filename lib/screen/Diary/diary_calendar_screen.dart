import 'package:cached_network_image/cached_network_image.dart';
import 'package:emodiary/model/Diary/calendar_diary_model.dart';
import 'package:emodiary/repository/home/diary_calendar_repository.dart';
import 'package:emodiary/widget/calendar/diary_calendar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../viewModel/Diary/diary_calendar_view_model.dart';
import '../../widget/base/default_back_appbar.dart';

class DiaryCalendarScreen extends StatelessWidget {
  const DiaryCalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DiaryCalendarViewModel viewModel = Get.put(
      DiaryCalendarViewModel(
        repository: DiaryCalendarRepository(),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: DefaultBackAppbar(
          title: '달력',
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: DiaryCalendar(
              viewModel: viewModel,
            ),
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
            () => viewModel.diaries.isEmpty
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
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
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
                  ),
          ),
        ],
      ),
    );
  }
}

class _DiaryImage extends StatelessWidget {
  final CalendarDiaryModel model;
  const _DiaryImage({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(model.id);
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
    );
  }
}
