import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:myapp/api/gcal/googleCalendarEvent.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/utils/calendar-logic.dart';
import 'package:myapp/utils/globals.dart';
import 'package:myapp/utils/userProfile.dart';
import '../../utils/globals.dart';

class GoogleCalendar {
  static Future<List<GoogleCalendarEvent>> getListEvents(
      DateTime startRange, DateTime endRange, String oauthtoken) async {
    var response3 = await http.get(Uri.parse(
        "https://www.googleapis.com/calendar/v3/calendars/primary/events?access_token=$oauthtoken&2023-09-17T07:07:28-00:00&timeMax=2023-09-18T07:07:28-00:00&singlEvents=true"));

    dynamic calendar = jsonDecode(response3.body);
    List<GoogleCalendarEvent> events = <GoogleCalendarEvent>[];

    if (calendar['items'] != null) {
      calendar['items']!.forEach((v) {
        if (v['status'] != "cancelled") {
          GoogleCalendarEvent temp = GoogleCalendarEvent.fromJson(v);
          if (temp.startTime != null && temp.endTime != null) {
            if (DateTime.parse(temp.startTime!).isAfter(startRange) &&
                DateTime.parse(temp.endTime!).isBefore(endRange)) {
              events.add(v);
            }
          }
        }
      });
    }

    events.forEach((e) {
      CalendarLogic.addCalendarEvent(
          userEvents, CalendarLogic.googleToNormalConverter(e));
    });

    return events;
  }
}
