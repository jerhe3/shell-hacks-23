import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:myapp/pages/googleCalendarEvent.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/pages/userProfile.dart';

class GoogleCalendar {
  Future<List<GoogleCalendarEvent>> getListEvents(
      DateTime startRange, DateTime endRange, String oauthtoken) async {
    var response3 = await http.get(Uri.parse(
        "https://www.googleapis.com/calendar/v3/calendars/primary/events?access_token=$oauthtoken&2023-09-17T07:07:28-00:00&timeMax=2023-09-18T07:07:28-00:00&singlEvents=true"));

    dynamic calendar = jsonDecode(response3.body);
    List<GoogleCalendarEvent> events = <GoogleCalendarEvent>[];

    if (calendar['items'] != null) {
      calendar['items']!.forEach((v) {
        if (v['status'] != "cancelled" && (v)) {
          events.add(GoogleCalendarEvent.fromJson(v));
        }
      });
    }

    return events;
  }
}
