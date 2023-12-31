import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:myapp/pages/home.dart';
import 'package:myapp/utils/calendar/demo-data.dart';
import 'package:myapp/utils/colors.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:myapp/utils/globals.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {


    // TEMPORARY DEMO EVENTS
    userEvents = List.empty(growable: true);
    userEvents?.addAll(DEMO_EVENTS_2);


    return CalendarControllerProvider(
    controller: EventController(),
    child: MaterialApp(
      title: 'Schedule Builder',
      theme: ThemeData(
        primarySwatch:
            MaterialColorGenerator.from(Color.fromRGBO(102, 189, 137, 1)),
        secondaryHeaderColor:
            MaterialColorGenerator.from(Color.fromRGBO(229, 234, 250, 1.0)),
        cardColor:
            MaterialColorGenerator.from(Color.fromRGBO(168, 200, 181, 1)),
        focusColor:
            MaterialColorGenerator.from(Color.fromRGBO(146, 189, 163, 1)),
      ),
      home: Home(),
    ),
);
  }
}
