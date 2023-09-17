import 'package:flutter/material.dart';
import 'package:myapp/utils/calendar/calendar-utils.dart';
import 'package:myapp/utils/calendar/optimizer.dart';
import 'package:myapp/utils/calendar/structures.dart';

class CalendarSuggestions {

  // ASSUMING THESE EVENTS ARE IN ORDER
  // List<Event> events;

  // CalendarSuggestions({required List<Event> events});

  // List<DateTimeRange> pruneFreeTimes(List<DateTimeRange> givenFreeTime, List<Event> events) {
  //     List<DateTimeRange> prunedFreeTimes = List.empty(growable: true);

  // }

  static List<DateTimeRange> prunedFreeTimes = [

    RangeUtils.fromTimes(DateTime.now(), 8,00,11,00),
    RangeUtils.fromTimes(DateTime.now(), 13,00,15,00),
    RangeUtils.fromTimes(DateTime.now(), 16,00,19,00),

    RangeUtils.fromTimes(DateTime.now().add(Duration(days:1)), 9,00,11,00),
    RangeUtils.fromTimes(DateTime.now().add(Duration(days:1)), 13,30,14,15),
    RangeUtils.fromTimes(DateTime.now().add(Duration(days:1)), 15,00,17,00),

    RangeUtils.fromTimes(DateTime.now().add(Duration(days:2)), 12,00,14,00),
    RangeUtils.fromTimes(DateTime.now().add(Duration(days:2)), 16,00,22,00),

    RangeUtils.fromTimes(DateTime.now().add(Duration(days:3)), 7,00,9,00),
    RangeUtils.fromTimes(DateTime.now().add(Duration(days:3)), 12,00,25,00),
    RangeUtils.fromTimes(DateTime.now().add(Duration(days:3)), 16,00,23,00),

    RangeUtils.fromTimes(DateTime.now().add(Duration(days:4)), 6,00,10,00),
    RangeUtils.fromTimes(DateTime.now().add(Duration(days:4)), 12,45,14,30),
    RangeUtils.fromTimes(DateTime.now().add(Duration(days:4)), 16,30,22,30),

    RangeUtils.fromTimes(DateTime.now().add(Duration(days:5)), 6,15,8,30),
    RangeUtils.fromTimes(DateTime.now().add(Duration(days:5)), 9,45,11,00),
    RangeUtils.fromTimes(DateTime.now().add(Duration(days:5)), 12,00,14,00),
    RangeUtils.fromTimes(DateTime.now().add(Duration(days:5)), 16,15,21,30),


  ];

}