import 'package:flutter/material.dart';
import 'package:myapp/utils/calendar-logic.dart';

class RangeUtils {
  static DateTimeRange fromTimes(DateTime date, int hour1, int minute1, int hour2, int minute2) {
    return DateTimeRange(start: date.startOfDay.add(Duration(hours: hour1, minutes: minute1)), end: date.startOfDay.add(Duration(hours: hour2, minutes: minute2)));
  }

  static today() {
    return DateTimeRange(start: DateTime.now().startOfDay, end: DateTime.now().endOfDay);
  }

  static fromDay(DateTime day) {
    return DateTimeRange(start: day.startOfDay, end: day.endOfDay);
  }

  static fromDays(DateTime startDay, DateTime endDay) {
    return DateTimeRange(start: startDay.startOfDay, end: endDay.endOfDay);
  }

  static subtractTime(DateTimeRange range, Duration subtract) {
    return DateTimeRange(start: range.start.subtract(subtract),end: range.end.subtract(subtract));
  }

  static addTime(DateTimeRange range, Duration add) {
    return DateTimeRange(start: range.start.add(add),end: range.end.add(add));
  }
}