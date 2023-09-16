import 'package:flutter/material.dart';
import 'package:myapp/utils/calendar/calendar-utils.dart';
import 'package:myapp/utils/calendar/optimizer.dart';
import 'package:myapp/utils/calendar/structures.dart';

List<Event> DEMO_EVENTS_1 = [

  Event(RangeUtils.fromTimes(DateTime.now(), 10,00,12,00), "10 to 12"),
  Event(RangeUtils.fromTimes(DateTime.now(), 4,00,5,00), "4 to 5"),
  Event(RangeUtils.fromTimes(DateTime.now(), 3,30,3,45), "3:30 to 3:45"),
  // Event(RangeUtils.fromTimes(DateTime.now(), 9,15,10,30), "9:15 to 10:30"),
  // Event(RangeUtils.fromTimes(DateTime.now(), 1,25,1,55), "1:25 to 1:55"),

];


OptimizeConfig DEMO_CONFIG_1 = OptimizeConfig(buffer: Duration(minutes: 15), freeTime: DEMO_FREE_TIME_1);


Map<int,DateTimeRange> DEMO_FREE_TIME_1 = {
    1: RangeUtils.fromTimes(DateTime.now(),8,00,18,00), // Monday
    2: RangeUtils.fromTimes(DateTime.now(),8,00,18,00), // Tuesday
    3: RangeUtils.fromTimes(DateTime.now(),8,00,18,00), // Wednesday
    4: RangeUtils.fromTimes(DateTime.now(),8,00,18,00), // Thursday
    5: RangeUtils.fromTimes(DateTime.now(),8,00,20,00), // Friday
    6: RangeUtils.fromTimes(DateTime.now(),10,00,20,00), // Saturday
    7: RangeUtils.fromTimes(DateTime.now(),11,00,18,00), // Sunday
  };