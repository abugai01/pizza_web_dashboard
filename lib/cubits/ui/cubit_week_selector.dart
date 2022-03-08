import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_web_dashboard/cubits/states.dart';
import 'package:pizza_web_dashboard/helpers/functions.dart';
import 'package:pizza_web_dashboard/helpers/rus_date_formatter.dart';

//TODO: добавить режим прошлое онли, будущее или без ограничений!
class CubitWeekSelector extends Cubit<WeekSelectorGenericState> {
  CubitWeekSelector()
      : super(WeekSelectorGenericState(
            weekCounter: 0,
            text: WeekSelectorHelper.genText(weekCounter: 0),
            weekRange: DateTimeRange(
                start: WeekSelectorHelper.getWeekStartDate(weekCounter: 0),
                end: WeekSelectorHelper.getWeekEndDate(weekCounter: 0)),
            // weekStart: WeekSelectorHelper.getWeekStartDate(weekCounter: 0),
            // weekEnd: WeekSelectorHelper.getWeekEndDate(weekCounter: 0),
            isBeforeButtonEnabled: true));

  void increment() => emitState(state.weekCounter + 1);

  void decrement() => emitState(state.weekCounter - 1);

  void emitState(int value) {
    DateTime weekStart =
        WeekSelectorHelper.getWeekStartDate(weekCounter: value);
    DateTime weekEnd = WeekSelectorHelper.getWeekEndDate(weekCounter: value);

    emit(WeekSelectorGenericState(
      weekCounter: value,
      text: WeekSelectorHelper.genText(weekCounter: value),
      weekRange: DateTimeRange(start: weekStart, end: weekEnd),
      isBeforeButtonEnabled: isBeforeButtonEnabled(value),
      isNextButtonEnabled: isNextButtonEnabled(value),
    ));
  }

  bool isBeforeButtonEnabled(int week) => true; //(week > 0) ? true : false;
  bool isNextButtonEnabled(int week) => true;
}

class WeekSelectorHelper {
  static String formatDate(DateTime date) =>
      rusDateFormatter(date, fmt: DateFormats.DMMM);

  static String formatDateRange(DateTime start, DateTime end) =>
      formatDate(start) + ' – ' + formatDate(end);

  static String genText({int weekCounter = 0}) => formatDateRange(
      getWeekStartDate(weekCounter: weekCounter),
      getWeekEndDate(weekCounter: weekCounter));

  static DateTime getWeekStartDate({int weekCounter = 0}) {
    DateTime referenceDate =
        DateTime.now().add(Duration(days: 7 * weekCounter));
    DateTime res = getDate(
        referenceDate.subtract(Duration(days: referenceDate.weekday - 1)));
    return res;
  }

  static DateTime getWeekEndDate({int weekCounter = 0}) {
    DateTime referenceDate =
        DateTime.now().add(Duration(days: 7 * weekCounter));
    DateTime res = getDate(referenceDate
            .add(Duration(days: DateTime.daysPerWeek - referenceDate.weekday)))
        .add(Duration(
      hours: 23,
      minutes: 59,
      seconds: 59,
    ));
    return res;
  }
}
