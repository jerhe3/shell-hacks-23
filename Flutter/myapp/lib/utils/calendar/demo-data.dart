import 'package:flutter/material.dart';
import 'package:myapp/utils/calendar/calendar-utils.dart';
import 'package:myapp/utils/calendar/optimizer.dart';
import 'package:myapp/utils/calendar/structures.dart';
import '../globals.dart';

List<CalendarEvent> DEMO_EVENTS_1 = [
  CalendarEvent(
      RangeUtils.fromTimes(DateTime.now(), 10, 00, 12, 00), "10 to 12", false),
  CalendarEvent(
      RangeUtils.fromTimes(DateTime.now(), 4, 00, 5, 00), "4 to 5", false),
  CalendarEvent(RangeUtils.fromTimes(DateTime.now(), 3, 30, 3, 45),
      "3:30 to 3:45", false),
  CalendarEvent(RangeUtils.fromTimes(DateTime.now(), 9, 15, 10, 30),
      "9:15 to 10:30", false),
  CalendarEvent(RangeUtils.fromTimes(DateTime.now(), 1, 25, 1, 55),
      "1:25 to 1:55", false),
];

OptimizeConfig DEMO_CONFIG_1 =
    OptimizeConfig(buffer: Duration(minutes: 15), freeTime: DEMO_FREE_TIME_1);

Map<int, DateTimeRange> DEMO_FREE_TIME_1 = {
  1: RangeUtils.fromTimes(DateTime.now(), 8, 00, 18, 00), // Monday
  2: RangeUtils.fromTimes(DateTime.now(), 8, 00, 18, 00), // Tuesday
  3: RangeUtils.fromTimes(DateTime.now(), 8, 00, 18, 00), // Wednesday
  4: RangeUtils.fromTimes(DateTime.now(), 8, 00, 18, 00), // Thursday
  5: RangeUtils.fromTimes(DateTime.now(), 8, 00, 20, 00), // Friday
  6: RangeUtils.fromTimes(DateTime.now(), 10, 00, 20, 00), // Saturday
  7: RangeUtils.fromTimes(DateTime.now(), 11, 00, 18, 00), // Sunday
};

List<CalendarEvent> DEMO_EVENTS_2 = [
  CalendarEvent(RangeUtils.fromTimes(DateTime.now(), 8, 00, 9, 00),
      "One-on-One with John", false),
  CalendarEvent(RangeUtils.fromTimes(DateTime.now(), 10, 00, 11, 00),
      "Walk the Dog", false),
  CalendarEvent(
      RangeUtils.fromTimes(DateTime.now(), 12, 00, 14, 00), "Calculus 3", true),
  CalendarEvent(RangeUtils.fromTimes(DateTime.now(), 15, 00, 16, 00),
      "Hang Out with Albert", false),
];
