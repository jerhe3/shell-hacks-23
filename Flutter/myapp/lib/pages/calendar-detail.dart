import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/ui/calendar.dart';
import 'package:myapp/utils/calendar-logic.dart';
import 'package:myapp/utils/calendar/calendar-utils.dart';
import 'package:myapp/utils/calendar/demo-data.dart';
import 'package:myapp/utils/calendar/flutter_week_view/event.dart';
import 'package:myapp/utils/calendar/flutter_week_view/styles/day_view.dart';
import 'package:myapp/utils/calendar/flutter_week_view/widgets/day_view.dart';
import 'package:myapp/utils/calendar/optimizer.dart';
import 'package:myapp/utils/calendar/structures.dart';
import 'package:myapp/utils/globals.dart';

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

    Optimizer optimizer = Optimizer();

    // Get events for this day
    List<CalendarEvent> todaysEvents = eventsOnDay(date);

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          DayView(
            date: date,
            events: convertEvents(todaysEvents),
            style: DayViewStyle.fromDate(
              date: date,
              currentTimeCircleColor: Colors.pink,
              backgroundRulesColor: Theme.of(context).primaryColor
              
            ),
          ),
          Container(
            width: 200,
            height: 50,
            constraints: BoxConstraints(minHeight: 300, maxHeight: 300),
            child: 
            SizedBox(
              height: 50,
              child: Container(
                constraints: BoxConstraints(maxHeight: 50),
                decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(15)),
                child: MaterialButton(onPressed: (() {
                  setState(() {
                    todaysEvents = optimizer.optimize(RangeUtils.today(), todaysEvents, OptimizeConfig(buffer: Duration(minutes: 15), freeTime: DEMO_FREE_TIME_1));
                  });
                }),
                child: Text("Optimize", style: TextStyle(fontSize: 30.0),)),
              ),
            )
          ),
        ],
      )
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
