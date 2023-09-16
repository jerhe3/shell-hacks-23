import 'package:flutter/material.dart';
import 'package:myapp/utils/calendar/calendar-utils.dart';
import 'package:myapp/utils/calendar/demo-data.dart';

class Event {
  DateTimeRange range;
  String name;
  bool static = false;
  // Location? location;

  Event(this.range, this.name) {}

  Duration duration() {
    return range.duration;
  }

  bool conflicts(Event event) {
    return (range.start.isAfter(event.range.start) && range.start.isBefore(event.range.end)) || (range.end.isAfter(event.range.start) && range.end.isBefore(event.range.end));
  }

  @override
  String toString() {
    return "\"" + name + "\" - " + range.start.toString() + " to " + range.end.toString();
  }
}

class User {
  String name = "[Name]";
  List<Event> events = List.empty();
  Duration bufferTime = Duration(minutes: 15);

  // Set default free times
  Map<int,DateTimeRange> freeTime = DEMO_FREE_TIME_1;

  User(this.name) {
    print("New user created: " + name + ".");
  }
}