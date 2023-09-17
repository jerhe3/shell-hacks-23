import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/ui/calendar.dart';
import 'package:myapp/utils/calendar/demo-data.dart';
import 'package:myapp/utils/calendar/flutter_week_view/event.dart';
import 'package:myapp/utils/calendar/flutter_week_view/styles/day_view.dart';
import 'package:myapp/utils/calendar/flutter_week_view/widgets/day_view.dart';
import 'package:myapp/utils/calendar/structures.dart';

class CalendarDetail extends StatefulWidget {
  final DateTime date;

  const CalendarDetail({super.key, required this.date});

  @override
  State<StatefulWidget> createState() => CalendarDetailState(date: date);
}

class CalendarDetailState extends State<CalendarDetail> {
  final DateTime date;

  CalendarDetailState({required this.date});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    return Column(
      children: [
        Text(
          DateFormat('LLL').format(date),
          style: TextStyle(fontSize: 30.0, color: Colors.black),
        ),
        DayView(
          date: date,
          events: convertEvents(DEMO_EVENTS_2),
          style: DayViewStyle.fromDate(
            date: date,
            currentTimeCircleColor: Colors.pink,
          ),
        ),
      ],
    );
  }

  List<FlutterWeekViewEvent> convertEvents(List<CalendarEvent> events) {
    List<FlutterWeekViewEvent> newEvents = List.empty(growable: true);

    for (int i = 0; i < events.length; ++i) {
      newEvents.add(FlutterWeekViewEvent(
          title: events[i].name,
          description: "",
          start: events[i].range.start,
          end: events[i].range.end));
    }

    return newEvents;
  }
}
