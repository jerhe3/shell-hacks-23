import 'dart:math';

import 'package:flutter/material.dart';
import 'package:myapp/utils/calendar-logic.dart';
import 'package:myapp/utils/calendar/calendar-utils.dart';
import 'package:myapp/utils/calendar/structures.dart';

class Optimizer {
  final int ITERATIONS = 10000;

  // The number of minutes to snap an event to; the lower the slower
  final int TICKS = 60;

  List<List<CalendarEvent>> distributions = List.empty();

  List<CalendarEvent> optimize(
      DateTimeRange range, List<CalendarEvent> events, OptimizeConfig config) {
    // Separate static events from mutable events
    List<CalendarEvent> staticEvents = List.empty(growable: true);
    List<CalendarEvent> mutableEvents = List.empty(growable: true);
    events.forEach((element) {
      element.static ? staticEvents.add(element) : mutableEvents.add(element);
    });

    // Store the time ranges for each day
    List<DateTimeRange> dailyRanges = List.empty(growable: true);
    for (int i = 0; i < range.duration.inDays; ++i) {
      dailyRanges.add(
          config.freeTime[range.start.add(Duration(days: i)).weekday] ??
              DateTimeRange(start: DateTime.now(), end: DateTime.now()));
    }

    // For each event, move up the end of the range so that a spot in the range can be randomly picked from
    List<List<DateTimeRange>> adjustedDailyRanges = List.empty(growable: true);
    for (int i = 0; i < events.length; ++i) {
      List<DateTimeRange> copy = List.from(dailyRanges);
      for (int j = 0; j < dailyRanges.length; j++) {
        copy[j] = DateTimeRange(
            start: copy[j].start,
            end: copy[j].end.subtract(events[i].range.duration));
      }
      adjustedDailyRanges.add(copy);
    }

    // dailyRanges.forEach((element) { print(element.toString()); });

    // Loop through INTERATION(#) random variations of mutable events and store the ones that work
    Random rand = Random();
    List<List<CalendarEvent>> storedDistributions = List.empty(growable: true);
    for (int i = 0; i < ITERATIONS; ++i) {
      // Copy events
      List<CalendarEvent> newDist = List.from(events);
      for (int j = 0; j < events.length; ++j) {
        // Pick a random start time within the range that fits the event in

        int randomDay = 0;
        if (range.duration.inDays > 1) {
          randomDay = rand.nextInt(range.duration.inDays);
        }

        // Pick a random 15 minute slot in the time frame
        int slotCount =
            (adjustedDailyRanges[j][randomDay].duration.inMinutes / TICKS)
                .floor();
        int slot = rand.nextInt(slotCount);
        DateTime startDay =
            range.start.add(Duration(days: randomDay)).startOfDay;
        DateTime rangeStart = adjustedDailyRanges[j]![randomDay].start;
        DateTime startTime = startDay
            .add(Duration(hours: rangeStart.hour, minutes: rangeStart.minute));
        startTime = startTime.add(Duration(minutes: slot * TICKS));

        newDist[j] = CalendarEvent(
            DateTimeRange(
                start: startTime, end: startTime.add(events[j].duration())),
            events[j].name,
            events[j].static);
      }
      storedDistributions.add(newDist);
    }

    // Loop through stored combinations and rate them
    List<GradedDistribution> gradedDistributions = List.empty(growable: true);
    for (int i = 0; i < storedDistributions.length; ++i) {
      // Sort stored version according to start time
      storedDistributions[i]
          .sort(((a, b) => a.range.start.compareTo(b.range.start)));
      gradedDistributions.add(GradedDistribution(
          events: storedDistributions[i],
          grade: score(storedDistributions[i], config)));
    }

    // Pick the best rated
    // SORT THE LIST !!!!!!!
    gradedDistributions.sort((a, b) => a.grade.compareTo(b.grade));

    gradedDistributions.forEach((element) {
      if (element.grade >= 0) print(element);
    });

    return gradedDistributions.last.events;
  }

  // Using the events given in the distribution, rate it
  double score(List<CalendarEvent> events, OptimizeConfig config) {
    double SCORE = 0.0;

    // Check if there is overlap in any events
    if (CalendarEvent.eventsHaveAnyConflict(events)) SCORE -= 100;

    // Free time equation to add
    SCORE += (1 / 1800000) * pow((freeTime(events, config).inMinutes) - 200, 2);

    // Subtract for every gap that is < Buffer
    for (int i = 0; i < events.length - 1; ++i) {
      print("Hi");
      if (events[i].range.end.difference(events[i + 1].range.start) <
          config.buffer) {
        SCORE -= config.buffer.inMinutes / 1000.0;
      }
    }

    // Add points for large gap until end
    SCORE += config.freeTime[events.first.range.start.weekday]!.end
            .difference(events.last.range.end)
            .inMinutes /
        240.0;

    return SCORE;
  }

  Duration freeTime(List<CalendarEvent> events, OptimizeConfig config) {
    Duration dur = Duration.zero;
    dur += config.freeTime[events.first.range.start.weekday]!.start
        .difference(events.first.range.start);
    for (int i = 1; i < events.length - 1; ++i) {
      dur += events[i].range.end.difference(events[i + 1].range.start);
    }
    return dur;
  }
}

class OptimizeConfig {
  Duration buffer;
  Map<int, DateTimeRange> freeTime;

  OptimizeConfig({required this.buffer, required this.freeTime});
}

class GradedDistribution {
  final List<CalendarEvent> events;
  final double grade;

  GradedDistribution({required this.events, required this.grade});

  @override
  String toString() {
    return grade.toString() + ": " + events.toString();
  }
}
