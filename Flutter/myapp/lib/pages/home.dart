import 'package:flutter/material.dart';
import 'package:myapp/ui/calendar.dart';
import 'package:myapp/ui/day-display.dart';
import 'package:myapp/utils/pagescrollphysics.dart';
import 'package:table_calendar/table_calendar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    List<Widget> days = [
      DayDisplay(),
      DayDisplay(),
      DayDisplay(),
      DayDisplay(),
      DayDisplay(),
      DayDisplay(),
      DayDisplay(),
      DayDisplay(),
      DayDisplay(),
    ];

    return Scaffold(
      body: Column(
        children: [
          Container(constraints: BoxConstraints(maxHeight: 390),
            child: Expanded(flex: 1, child: Calendar(),)),
          Expanded(flex: 1,
            child: Container(
              width: double.infinity,
              // child: SingleChildScrollView(child: 
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: PagingScrollPhysics(itemDimension: 200),
                  itemCount: days.length,
                  itemBuilder: (_, index) => days[index],)
              ),
            // )
          )
        ]
      ),
      backgroundColor: Theme.of(context).secondaryHeaderColor,
    );
  }
}
