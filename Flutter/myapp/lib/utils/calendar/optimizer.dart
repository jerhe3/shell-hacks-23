import 'dart:math';

import 'package:flutter/material.dart';
import 'package:myapp/utils/calendar-logic.dart';
import 'package:myapp/utils/calendar/calendar-utils.dart';
import 'package:myapp/utils/calendar/structures.dart';

class Optimizer {

  final int ITERATIONS = 10;
  
  // The number of minutes to snap an event to; the lower the slower
  final int TICKS = 60;

  List<List<Event>> distributions = List.empty();

  List<Event> optimize(DateTimeRange range, List<Event> events, OptimizeConfig config) {
    
    // Separate static events from mutable events
    List<Event> staticEvents = List.empty(growable: true);
    List<Event> mutableEvents = List.empty(growable: true);
    events.forEach((element) {
      element.static ? staticEvents.add(element) : mutableEvents.add(element);
    });

    // Store the time ranges for each day
    List<DateTimeRange> dailyRanges = List.empty(growable: true);
    for(int i=0; i<range.duration.inDays; ++i) {
      dailyRanges.add(config.freeTime[range.start.add(Duration(days: i)).weekday] ?? DateTimeRange(start: DateTime.now(),end: DateTime.now()));
    }

    // For each event, move up the end of the range so that a spot in the range can be randomly picked from
    List<List<DateTimeRange>> adjustedDailyRanges = List.empty(growable: true);
    for(int i=0; i<events.length; ++i) {
      List<DateTimeRange> copy = List.from(dailyRanges);
      for(int j=0; j<dailyRanges.length; j++) {
        copy[j] = DateTimeRange(start: copy[j].start, end: copy[j].end.subtract(events[i].range.duration));
      }
      adjustedDailyRanges.add(copy);
    }

    // dailyRanges.forEach((element) { print(element.toString()); });

    // Loop through INTERATION(#) random variations of mutable events and store the ones that work
    Random rand = Random();
    List<List<Event>> storedDistributions = List.empty(growable: true);
    for(int i=0; i<ITERATIONS; ++i) {
      // Copy events
      List<Event> newDist = List.from(events);
      for(int j=0; j<events.length; ++j) {
        // Pick a random start time within the range that fits the event in

        int randomDay = 0;
        if(range.duration.inDays>1) {
          randomDay = rand.nextInt(range.duration.inDays);
        }

        // Pick a random 15 minute slot in the time frame
        int slotCount = (adjustedDailyRanges[j][randomDay].duration.inMinutes / TICKS).floor();
        int slot = rand.nextInt(slotCount);
        DateTime startDay = range.start.add(Duration(days: randomDay)).startOfDay;
        DateTime rangeStart = adjustedDailyRanges[j]![randomDay].start;
        DateTime startTime = startDay.add(Duration(hours: rangeStart.hour, minutes: rangeStart.minute));
        startTime = startTime.add(Duration(minutes: slot*TICKS));

        newDist[j] = Event(DateTimeRange(start: startTime, end: startTime.add(events[j].duration())), events[j].name);
      }
      storedDistributions.add(newDist);
    }

    // Loop through stored combinations and rate them
    List<GradedDistribution> gradedDistributions = List.empty(growable: true);
    for(int i=0; i<storedDistributions.length; ++i) {
      gradedDistributions.add(GradedDistribution(events: storedDistributions[i], grade: score(storedDistributions[i], config)));
    }

    // Pick the best rated
    // SORT THE LIST !!!!!!!
    gradedDistributions.sort((a,b) => a.grade.compareTo(b.grade));

    gradedDistributions.forEach((element) {
      if(element.grade >= 0) print(element);
    });

    return gradedDistributions.first.events;

  }

  // Using the events given in the distribution, rate it
  double score(List<Event> events, OptimizeConfig config) {

    double SCORE = 0.0;
    
    // Check if there is overlap in any events
    if(Event.eventsHaveAnyConflict(events)) SCORE -= 100;

    

    return SCORE;

  }
  

}

class OptimizeConfig {
  Duration buffer;
  Map<int,DateTimeRange> freeTime;

  OptimizeConfig({
    required this.buffer,
    required this.freeTime
  });
}

class GradedDistribution {
  final List<Event> events;
  final double grade;

  GradedDistribution({required this.events, required this.grade});

  @override
  String toString() {
    return grade.toString() + ": " + events.toString();
  }

}