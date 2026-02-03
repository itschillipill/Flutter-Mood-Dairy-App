import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../core/theme/app_pallet.dart';

class DatePicker extends StatefulWidget {
  const DatePicker._({required this.onSelected});

  final Function(DateTime) onSelected;

  static Future<void> pickDate(
    BuildContext ctx, {
    required void Function(DateTime) onSelected,
  }) async {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (context) => DatePicker._(onSelected: onSelected),
      ),
    );
  }

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: Colors.grey),
                  ),
                  TextButton(
                    onPressed: () {
                      widget.onSelected(DateTime.now());
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Сегодня",
                      style: TextStyle(color: AppPallet.orange),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              Expanded(
                child: ListView.builder(
                  itemCount: 12,
                  padding: const EdgeInsets.only(bottom: 24),
                  itemBuilder: (context, index) {
                    final firstDayOfMonth =
                        DateTime(DateTime.now().year, index + 1, 1);

                    final lastDayOfMonth = DateTime(
                        firstDayOfMonth.year, firstDayOfMonth.month + 1, 0);

                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${firstDayOfMonth.year}',
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: theme.colorScheme.secondary,
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text(
                            DateFormat.MMMM("ru").format(firstDayOfMonth).map(
                                (char, index) =>
                                    index == 0 ? char.toUpperCase() : char),
                            style: const TextStyle(
                                color: AppPallet.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 22),
                          ),

                          const SizedBox(height: 12),

                          TableCalendar(
                            locale: "ru",
                            firstDay: firstDayOfMonth,
                            lastDay: lastDayOfMonth,
                            focusedDay: firstDayOfMonth,
                            startingDayOfWeek: StartingDayOfWeek.monday,
                            headerVisible: false,
                            calendarFormat: CalendarFormat.month,
                            onDaySelected: (selectedDay, _) {
                              widget.onSelected(selectedDay);
                              Navigator.pop(context);
                            },
                            calendarStyle: const CalendarStyle(
                              outsideDaysVisible: false,
                              todayDecoration: BoxDecoration(
                                color: AppPallet.orange,
                                shape: BoxShape.circle,
                              ),
                              selectedDecoration: BoxDecoration(
                                color: AppPallet.orange,
                                shape: BoxShape.circle,
                              ),
                              weekendTextStyle: TextStyle(
                                color: AppPallet.grey,
                              ),
                            ),
                            daysOfWeekStyle: const DaysOfWeekStyle(
                              weekendStyle: TextStyle(color: AppPallet.grey),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension StringExtension on String {
  String map(String Function(String char, int index) fn) {
    return split("").map((char) => fn(char, split("").indexOf(char))).join();
  }
}
