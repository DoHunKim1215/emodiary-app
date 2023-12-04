import 'package:emodiary/model/Diary/diary_search_item_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SearchResultItemRow extends StatelessWidget {
  final DiarySearchItemModel model;

  const SearchResultItemRow({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(2.0, 2.0), // changes position of shadow
          ),
        ],
      ),
      child: TextButton(
        onPressed: () {
          // Get.toNamed("/diary", arguments: {"id": model.id});
        },
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xFFE8DCFF),
          splashFactory: NoSplash.splashFactory,
          padding: const EdgeInsets.all(10.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0),
          ),
        ),
        child: Row(
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Image.asset(
                model.imageUrl,
                width: 60,
                height: 60,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                  ),
                ),
                Text(
                  DateFormat("yyyy년 MM월 dd일").format(model.createdDate),
                  style: const TextStyle(
                    color: Color(0xFF434A54),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
