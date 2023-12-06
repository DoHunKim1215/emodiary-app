import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class DiaryCalendarItem extends StatelessWidget {
  final DateTime date;
  final bool isOutSide;
  final bool isSelected;
  final String imageUrl;
  final Function(DateTime date) onTap;
  const DiaryCalendarItem({
    Key? key,
    required this.date,
    required this.isOutSide,
    required this.isSelected,
    required this.imageUrl,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: Opacity(
        opacity: isOutSide ? 0.4 : 1,
        child: InkWell(
          onTap: () {
            onTap(date);
          },
          child: Column(
            children: [
              _CircularText(
                isToday: isSelected,
                data: date.day.toString(),
              ),
              const SizedBox(height: 5),
              imageUrl.isNotEmpty
                  ? Container(
                      height: 48,
                      width: 48,
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    )
                  : Container(
                      height: 48,
                      width: 48,
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      child: DottedBorder(
                        padding: const EdgeInsets.all(0),
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(5),
                        dashPattern: const [5, 5],
                        color: Colors.grey,
                        strokeWidth: 1,
                        child: Opacity(
                          opacity: 0.4,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CircularText extends StatelessWidget {
  final bool isToday;
  final String data;

  const _CircularText({
    required this.isToday,
    required this.data,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      width: 24,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: isToday
          ? const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF7541EF),
            )
          : const BoxDecoration(
              shape: BoxShape.circle,
            ),
      child: Center(
        child: Text(
          data,
          style: TextStyle(
            color: isToday ? Colors.white : Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
