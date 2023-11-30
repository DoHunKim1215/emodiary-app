import 'package:emodiary/viewModel/Diary/diary_calendar_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import 'diary_calendar_item.dart';

class DiaryCalendar extends StatefulWidget {
  final DiaryCalendarViewModel viewModel;
  const DiaryCalendar({required this.viewModel, Key? key}) : super(key: key);

  @override
  State<DiaryCalendar> createState() => _DiaryCalendarState();
}

class _DiaryCalendarState extends State<DiaryCalendar> {
  late final DiaryCalendarViewModel _viewModel;

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

          availableCalendarFormats: const {
            CalendarFormat.week: '한 주씩 보기',
            CalendarFormat.month: '한 달씩 보기',
          },

          onFormatChanged: (format) {
            if (_viewModel.calendarFormat != format) {
              // Call `setState()` when updating calendar format
              setState(() {
                _viewModel.updateCalendarFormat(format);
              });
            }
          },

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
                    : DiaryCalendarItem(
                        date: day,
                        isOutSide: false,
                        isSelected: false,
                        imageUrl: _viewModel
                                .calendarImages[
                                    DateFormat('yyyy-MM-dd').format(day)]
                                ?.value ??
                            "",
                        onTap: (date) {
                          _viewModel.updateSelectedDate(date);
                        },
                      ),
              );
            },
            outsideBuilder: (context, day, focusedDay) {
              return Obx(
                () => _viewModel.isLoadingCalendarImages
                    ? Container()
                    : DiaryCalendarItem(
                        date: day,
                        isOutSide: true,
                        isSelected: false,
                        imageUrl: _viewModel
                                .calendarImages[
                                    DateFormat('yyyy-MM-dd').format(day)]
                                ?.value ??
                            "",
                        onTap: (date) {
                          _viewModel.updateSelectedDate(date);
                        },
                      ),
              );
            },
            selectedBuilder: (context, day, focusedDay) {
              return Obx(
                () => _viewModel.isLoadingCalendarImages
                    ? Container()
                    : DiaryCalendarItem(
                        date: day,
                        isOutSide: false,
                        isSelected: true,
                        imageUrl: _viewModel
                                .calendarImages[
                                    DateFormat('yyyy-MM-dd').format(day)]
                                ?.value ??
                            "",
                        onTap: (date) {
                          _viewModel.updateSelectedDate(date);
                        },
                      ),
              );
            },
            todayBuilder: (context, day, focusedDay) {
              return Obx(
                () => _viewModel.isLoadingCalendarImages
                    ? Container()
                    : DiaryCalendarItem(
                        date: day,
                        isOutSide: false,
                        isSelected: false,
                        imageUrl: _viewModel
                                .calendarImages[
                                    DateFormat('yyyy-MM-dd').format(day)]
                                ?.value ??
                            "",
                        onTap: (date) {
                          _viewModel.updateSelectedDate(date);
                        },
                      ),
              );
            },
          ),
        ),
      ),
    );
  }
}
