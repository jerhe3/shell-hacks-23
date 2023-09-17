import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:myapp/api/gcal/googleCalendarEvent.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/utils/calendar-logic.dart';
import 'package:myapp/utils/globals.dart';
import 'package:myapp/utils/userProfile.dart';
import '../../utils/globals.dart';

class GoogleCalendar {
  static Future<List<GoogleCalendarEvent>> getListEvents(
      String startRange, String endRange, String oauthtoken) async {
    var response3 = await http.get(Uri.parse(
        "https://www.googleapis.com/calendar/v3/calendars/primary/events?access_token=$oauthtoken&singlEvents=true"));

    dynamic calendar = jsonDecode(response3.body);
    List<GoogleCalendarEvent> events = <GoogleCalendarEvent>[];

    print(calendar['items']);

    if (calendar['items'] != null) {
      print("in json:)");
      calendar['items']!.forEach((v) {
        if (v['status'] != "cancelled") {
          GoogleCalendarEvent temp = GoogleCalendarEvent.fromJson(v);
          if (temp.startTime != null && temp.endTime != null) {
            if (DateTime.parse(temp.startTime!)
                    .isAfter(DateTime.parse(startRange)) &&
                DateTime.parse(temp.endTime!)
                    .isBefore(DateTime.parse(endRange))) {
              events.add(v);
              print(v);
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
