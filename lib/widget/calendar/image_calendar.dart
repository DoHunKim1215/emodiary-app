import 'package:emodiary/viewmodel/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import 'image_calendar_item.dart';

class ImageCalendar extends StatefulWidget {
  final HomeViewModel viewModel;
  const ImageCalendar({required this.viewModel, Key? key}) : super(key: key);

  @override
  State<ImageCalendar> createState() => _ImageCalendarState();
}

class _ImageCalendarState extends State<ImageCalendar> {
  late final HomeViewModel _viewModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _viewModel = widget.viewModel;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: TableCalendar(
          // Base Info of Calendar
          locale: 'ko_KR',
          firstDay: DateTime.now().subtract(const Duration(days: 365 * 10 + 2)),
          lastDay: DateTime.now().add(const Duration(days: 365 * 10 + 2)),
          currentDay: DateTime.now(),
          focusedDay: _viewModel.focusedDate,
          calendarFormat: _viewModel.calendarFormat,
          daysOfWeekHeight: 30,
          rowHeight: 90,

          // UI Customization
          headerStyle: const HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
            titleTextStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            leftChevronIcon: Icon(
              Icons.chevron_left,
              color: Colors.black,
            ),
            rightChevronIcon: Icon(
              Icons.chevron_right,
              color: Colors.black,
            ),
          ),

          selectedDayPredicate: (day) =>
              isSameDay(_viewModel.selectedDate, day),

          onDaySelected: (selectedDay, focusedDay) {
            if (!isSameDay(_viewModel.selectedDate, selectedDay)) {
              setState(() {
                _viewModel.updateSelectedDate(selectedDay);
              });
            }
          },

          onPageChanged: (focusedDay) {
            _viewModel.updateFocusedDate(focusedDay);
          },

          calendarBuilders: CalendarBuilders(
            defaultBuilder: (context, day, focusedDay) {
              return Obx(
                () => _viewModel.isLoadingCalendarImages
                    ? Container()
                    : ImageCalendarItem(
                        date: day,
                        isOutSide: false,
                        isToday: false,
                        imageUrl: _viewModel
                                .calendarImages[
                                    DateFormat('yyyy-MM-dd').format(day)]
                                ?.value ??
                            "",
                      ),
              );
            },
            outsideBuilder: (context, day, focusedDay) {
              return Obx(
                () => _viewModel.isLoadingCalendarImages
                    ? Container()
                    : ImageCalendarItem(
                        date: day,
                        isOutSide: true,
                        isToday: false,
                        imageUrl: _viewModel
                                .calendarImages[
                                    DateFormat('yyyy-MM-dd').format(day)]
                                ?.value ??
                            "",
                      ),
              );
            },
            selectedBuilder: (context, day, focusedDay) {
              return Obx(
                () => _viewModel.isLoadingCalendarImages
                    ? Container()
                    : ImageCalendarItem(
                        date: day,
                        isOutSide: false,
                        isToday: true,
                        imageUrl: _viewModel
                                .calendarImages[
                                    DateFormat('yyyy-MM-dd').format(day)]
                                ?.value ??
                            "",
                      ),
              );
            },
          ),
        ),
      ),
    );
  }
}
