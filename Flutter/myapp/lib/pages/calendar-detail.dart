import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/ui/calendar.dart';
import 'package:myapp/utils/calendar-logic.dart';
import 'package:myapp/utils/calendar/calendar-utils.dart';
import 'package:myapp/utils/calendar/demo-data.dart';
import 'package:myapp/utils/calendar/optimizer.dart';
import 'package:myapp/utils/calendar/structures.dart';
import 'package:myapp/utils/globals.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarDetail extends StatefulWidget {
  final DateTime date;

  const CalendarDetail({super.key, required this.date});

  @override
  State<StatefulWidget> createState() => CalendarDetailState(date: date);
}

class CalendarDetailState extends State<CalendarDetail> {
  final DateTime date;

  CalendarDetailState({required this.date});

  List<CalendarEvent> todaysEvents = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    Optimizer optimizer = Optimizer();

    // Get events for this day
    todaysEvents = eventsOnDay(date);

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SfCalendar(
              view: CalendarView.schedule,
              timeSlotViewSettings: TimeSlotViewSettings(
                startHour: 8,
                endHour: 22
              ),
              dataSource: MeetingDataSource(_getDataSource()),
          ),
          SizedBox(height: 50,),
          Container(
            width: 200,
            height: 50,
            constraints: BoxConstraints(minHeight: 100, maxHeight: 100),
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

  List<CalendarEvent> _getDataSource() {
    print("DLJKFLSDKJFLKDSJFSDJLFKJLKFSJDFKLSJDFKLDSJKLFJDKLFDDLJKFLSDKJFLKDSJFSDJLFKJLKFSJDFKLSJDFKLDSJKL\nFJDKLFDDLJKFLSDKJFLKDSJFSDJLFKJLKFSJDFKLSJDFKLDSJKLFJDKLFDDLJKFLSDKJFLKDSJFSDJLFKJLKFSJDFKLSJDFKLDSJKLFJDKLFDDLJKFLSDKJFLKDSJFSDJLFKJLKFSJDFKLSJDFKLDSJKLFJDKLFDDLJKFLSDKJFLKDSJFSDJLFKJLKFSJDFKLSJDFKLDSJKLFJDKLFDDLJKFLSDKJFLKDSJFSDJLFKJLKFSJDFKLSJDFKLDSJKLFJDKLFDDLJKFLSDKJFLKDSJFSDJLFKJLKFSJDFKLSJDFKLDSJKLFJDKLFDDLJKFLSDKJFLKDSJFSDJLFKJLKFSJDFKLSJDFKLDSJKLFJDKLFDDLJKFLSDKJFLKDSJFSDJLFKJLKFSJDFKLSJDFKLDSJKLFJDKLFDDLJKFLSDKJFLKDSJFSDJLFKJLKFSJDFKLSJDFKLDSJKLFJDKLFDDLJKFLSDKJFLKDSJFSDJLFKJLKFSJDFKLSJDFKLDSJKLFJDKLFD");
    final List<CalendarEvent> meetings = <CalendarEvent>[];
    final DateTime today = DateTime.now();
    final DateTime startTime =
    DateTime(today.year, today.month, today.day, 9, 0, 0);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    for(int i = 0; i<todaysEvents.length; i++) {
      meetings.add(todaysEvents[i]);
    }
    return meetings;
  }
}

class MeetingDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  MeetingDataSource(List<CalendarEvent> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).range.start;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).range.end;
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).name;
  }

  @override
  Color getColor(int index) {
    return Colors.blue;
  }

  @override
  bool isAllDay(int index) {
    return false;
  }

  CalendarEvent _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final CalendarEvent meetingData;
    if (meeting is CalendarEvent) {
      meetingData = meeting;
    }

    return meetingData;
  }
}
