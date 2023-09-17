import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/pages/calendar-detail.dart';

class DayDisplay extends StatefulWidget {
  final DateTime date;
  final int events;

  const DayDisplay({
    required this.date,
    required this.events,
  });

  @override
  State<StatefulWidget> createState() =>
      DayDisplayState(date: date, events: events);
}

class DayDisplayState extends State<DayDisplay> {
  final DateTime date;
  final int events;

  DayDisplayState({
    required this.date,
    required this.events,
  });

  @override
  Widget build(BuildContext context) {
    double _scale = 1.0;
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    String text = events == 1 ? "EVENT ON" : "EVENTS ON";

    print("Widget");

    return Padding(
          padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
          child: Container(
            constraints: BoxConstraints(maxWidth: 350),
            child: GestureDetector(
              onTapDown: (details) {
                print("IM BEING TOUCHEDDD!");
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                  return CalendarDetail(date: DateTime.now(),);
                }));
                setState(() {
                  _scale = 2.0;
                });
              },
              child: AnimatedScale(
                scale: _scale,
                duration: const Duration(seconds: 1),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      color: Theme.of(context).cardColor),
                  height: 140,
                  child: Row(children: [
                    // SizedBox.fromSize(
                    //     size: Size(120, 140),
                        Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(15, 18, 15, 15),
                            child: Center(
                              child: Column(
                                children: [
                                  Text(
                                    DateFormat('EEEE').format(date),
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(date.day.toString(),
                                      style: TextStyle(
                                          fontSize: 50.0,
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                    DateFormat('MMMM').format(date),
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              // ),
                            ),
                          ),
                        )),
                    Padding(
                        padding: EdgeInsets.zero,
                        child: Center(
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context).cardColor),
                                padding: EdgeInsets.fromLTRB(15, 8, 5, 0),
                                child: Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(0)),
                                    child: Center(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            events.toString(),
                                            style: TextStyle(fontSize: 70.0),
                                          ),
                                          Text(
                                            text,
                                            style: TextStyle(fontSize: 13.0),
                                          ),
                                          Text(
                                            "THIS DAY",
                                            style: TextStyle(fontSize: 13.0),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )))),
                    Expanded(child: Container()),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(50)),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: const Icon(Icons.arrow_forward_rounded,
                              size: 40, color: Colors.black),
                        ),
                      ),
                    )
                  ]),
                ),
              ),
            ),
          ));
  }
}
