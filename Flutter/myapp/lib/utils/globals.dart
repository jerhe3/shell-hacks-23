import 'package:myapp/utils/calendar-logic.dart';
import 'package:myapp/utils/calendar/structures.dart';

String? userId;
List<CalendarEvent>? userEvents;

List<CalendarEvent> eventsOnDay(DateTime day) {
  // Get events for this day
    List<CalendarEvent> todaysEvents = List.empty(growable: true);
    userEvents?.forEach((element) {
      if(element.range.start.startOfDay == day.startOfDay) todaysEvents.add(element);
    });
    return todaysEvents;
}