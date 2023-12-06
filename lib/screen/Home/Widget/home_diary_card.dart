import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:emodiary/viewModel/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeDiaryCard extends StatefulWidget {
  final String title;
  final HomeViewModel viewModel;

  const HomeDiaryCard({
    Key? key,
    required this.title,
    required this.viewModel,
  }) : super(key: key);

  @override
  State<HomeDiaryCard> createState() => _HomeDiaryCardState();
}

class _HomeDiaryCardState extends State<HomeDiaryCard> {
  late final String title;
  late final HomeViewModel viewModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    title = widget.title;
    viewModel = widget.viewModel;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 1,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Container(
        width: double.infinity,
        padding:
            const EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 1,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              "$title의 일기",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            InkWell(
              onTap: () {
                var isNotEmpty = title == "오늘"
                    ? viewModel.todayDiary.imageUrl.isNotEmpty
                    : viewModel.yesterdayDiary.imageUrl.isNotEmpty;

                if (isNotEmpty) {
                  Get.toNamed("/diary/detail");
                } else {
                  Get.toNamed("/diary/writing");
                }
              },
              child: Container(
                height: 150,
                width: 150,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                child: title == "오늘"
                    ? Obx(() => (viewModel.isLoadingTodayDiary
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : (viewModel.todayDiary.imageUrl.isNotEmpty
                            ? _ImageWidget(
                                imageUrl: viewModel.todayDiary.imageUrl)
                            : const _DottedBorderWidget())))
                    : Obx(() => (viewModel.isLoadingYesterdayDiary
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : (viewModel.yesterdayDiary.imageUrl.isNotEmpty
                            ? _ImageWidget(
                                imageUrl: viewModel.yesterdayDiary.imageUrl)
                            : const _DottedBorderWidget()))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ImageWidget extends StatelessWidget {
  final String imageUrl;

  const _ImageWidget({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15), // 둥근 모서리 15
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        width: 150,
        height: 150,
      ),
    );
  }
}

class _DottedBorderWidget extends StatelessWidget {
  const _DottedBorderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: const Radius.circular(20),
      dashPattern: const [5, 5],
      color: Colors.grey,
      strokeWidth: 1,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "오늘은 일기를",
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
            ),
          ),
          Center(
            child: Text(
              "작성하지 않았어요.",
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
            ),
          ),
          Center(
            child: Text(
              "작성해보세요!",
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
