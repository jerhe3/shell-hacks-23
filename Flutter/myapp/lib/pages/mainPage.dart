import 'package:flutter/material.dart';
import 'package:myapp/ui/calendar.dart';
import 'package:myapp/ui/day-display.dart';
import 'package:myapp/utils/pagescrollphysics.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _length = 5;

  final controller = ScrollController();

  List<Widget> days = [
    DayDisplay(date: DateTime.now(), events: 0),
    DayDisplay(date: DateTime.now().add(Duration(days: 1)), events: 0),
    DayDisplay(date: DateTime.now().add(Duration(days: 2)), events: 0),
    DayDisplay(date: DateTime.now().add(Duration(days: 3)), events: 0),
    DayDisplay(date: DateTime.now().add(Duration(days: 4)), events: 0),
    DayDisplay(date: DateTime.now().add(Duration(days: 5)), events: 0),
    DayDisplay(date: DateTime.now().add(Duration(days: 6)), events: 0),
    DayDisplay(date: DateTime.now().add(Duration(days: 7)), events: 0),
    DayDisplay(date: DateTime.now().add(Duration(days: 8)), events: 0),
    DayDisplay(date: DateTime.now().add(Duration(days: 9)), events: 0),
  ];

  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        fetch();
      }
    });
  }

  Future fetch() async {
    setState(() {
      for (int i = 0; i < 10; i++) {
        days.add(DayDisplay(
            date: DateTime.now().add(Duration(days: days.length)), events: 0));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ListView list = ListView.builder(
      controller: controller,
      scrollDirection: Axis.vertical,
      physics: PagingScrollPhysics(itemDimension: 160),
      itemCount: days.length + 1,
      itemBuilder: (content, index) {
        if (index < days.length) {
          return days[index];
        } else {
          return Padding(
              padding: EdgeInsets.symmetric(vertical: 32),
              child: Center(child: CircularProgressIndicator()));
        }
      },
    );

    return Scaffold(
      body: Column(children: [
        Container(
            constraints: BoxConstraints(maxHeight: 390),
            child: Expanded(
              flex: 1,
              child: Calendar(
                listController: controller,
              ),
            )),
        Expanded(
          flex: 1,
          child: Container(
              width: double.infinity,
              // child: SingleChildScrollView(child:
              child: list),
          // )
        )
      ]),
      backgroundColor: Theme.of(context).secondaryHeaderColor,
    );
  }
}
