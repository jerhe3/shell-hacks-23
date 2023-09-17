import 'package:flutter/material.dart';

class GoogleCalendarEvent {
  String? summary;
  String? startTime;
  String? endTime;
  DateTimeRange? timeRange;

  GoogleCalendarEvent(
      {required this.startTime, required this.summary, required this.endTime});

  GoogleCalendarEvent.fromJson(Map<String, dynamic> json) {
    summary =
        json["summary"] == null ? "Untited Event" : json["summary"] as String;
    startTime = json["start"]["dateTime"] == null
        ? "Unvalid"
        : json["start"]["dateTime"] as String;
    endTime = json["end"]["dateTime"] == null
        ? "Unvalid"
        : json["end"]["dateTime"] as String;

    if (startTime != null && endTime != null) {
      timeRange = DateTimeRange(
          start: DateTime.parse(startTime!), end: DateTime.parse(endTime!));
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = Map<String, dynamic>();
    json["summary"] = summary;
    json["start"]["dateTime"] = startTime;
    json["end"]["dateTime"] = endTime;

    return json;
  }

  @override
  String toString() {
    return "$summary, $startTime, $endTime";
  }
}
