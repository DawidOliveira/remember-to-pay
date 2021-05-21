import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:remember_to_pay/app/core/app_colors.dart';
import 'package:remember_to_pay/app/modules/home/home_controller.dart';
import 'package:table_calendar/table_calendar.dart';

extension CapExtension on String {
  String get inCaps =>
      this.length > 0 ? '${this[0].toUpperCase()}${this.substring(1)}' : '';
  String get capitalizeFirstofEach => this
      .replaceAll(RegExp(' +'), ' ')
      .split(" ")
      .map((str) => str == 'de' ? 'de' : str.inCaps)
      .join(" ");
}

class HeaderContentWidget extends StatelessWidget {
  const HeaderContentWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TableCalendar(
          focusedDay: DateTime.now(),
          firstDay: DateTime.now(),
          lastDay: DateTime.now().add(Duration(days: 365)),
          calendarFormat: CalendarFormat.week,
          calendarStyle: CalendarStyle(
            disabledTextStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: AppColors.WHITE,
                ),
            defaultTextStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: AppColors.WHITE,
                ),
            weekendTextStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: AppColors.WHITE,
                ),
          ),
          headerStyle: HeaderStyle(
            headerPadding: EdgeInsets.zero,
            formatButtonVisible: false,
            leftChevronVisible: false,
            rightChevronVisible: false,
            titleTextStyle: Theme.of(context).textTheme.headline4!.copyWith(
                  color: AppColors.WHITE,
                ),
            titleTextFormatter: (date, locale) {
              return DateFormat.MMMM(locale).format(date).capitalizeFirstofEach;
            },
          ),
          locale: 'pt-BR',
          headerVisible: true,
          startingDayOfWeek: StartingDayOfWeek.monday,
          daysOfWeekHeight: 40,
          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: AppColors.WHITE,
                ),
            weekendStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: AppColors.WHITE,
                ),
            dowTextFormatter: (date, locale) =>
                DateFormat.E(locale).format(date)[0].toUpperCase(),
          ),
        ),
      ],
    );
  }
}
