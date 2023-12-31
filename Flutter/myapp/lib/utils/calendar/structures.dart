import 'dart:math';

import 'package:flutter/material.dart';
import 'package:myapp/utils/calendar/calendar-utils.dart';
import 'package:myapp/utils/calendar/demo-data.dart';

class CalendarEvent {
  DateTimeRange range;
  String name;
  bool static = false;
  // Location? location;

  CalendarEvent(this.range, this.name, static) {}

  Duration duration() {
    return range.duration;
  }

  bool conflicts(CalendarEvent event) {
    return max(range.start.millisecondsSinceEpoch,
            event.range.start.millisecondsSinceEpoch) <
        min(range.end.millisecondsSinceEpoch,
            event.range.end.millisecondsSinceEpoch);
  }

  static bool eventsHaveAnyConflict(List<CalendarEvent> events) {
    for (int i = 0; i < events.length; i++) {
      for (int j = 0; j < events.length; j++) {
        if (i == j) break;
        if (events[i].conflicts(events[j])) return true;
      }
    }
    return false;
  }

  @override
  String toString() {
    return "\"" +
        name +
        "\" - " +
        range.start.toString() +
        " to " +
        range.end.toString();
  }
}

class User {
  String name = "[Name]";
  List<CalendarEvent> events = List.empty();
  Duration bufferTime = Duration(minutes: 15);

  // Set default free times
  Map<int, DateTimeRange> freeTime = DEMO_FREE_TIME_1;

  User(this.name) {
    print("New user created: " + name + ".");
  }
}
