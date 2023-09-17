import 'package:flutter/material.dart';
import 'package:myapp/pages/suggestionsPage.dart';
import 'package:myapp/ui/calendar.dart';
import 'package:myapp/ui/day-display.dart';
import 'package:myapp/utils/globals.dart';
import 'package:myapp/utils/pagescrollphysics.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentPageIndex = 0;
  int _length = 5;

  final controller = ScrollController();

  List<Widget> days = [
    DayDisplay(date: DateTime.now(), events: eventsOnDay(DateTime.now()).length),
    DayDisplay(date: DateTime.now().add(Duration(days: 1)), events: eventsOnDay(DateTime.now().add(Duration(days: 1))).length),
    DayDisplay(date: DateTime.now().add(Duration(days: 2)), events: eventsOnDay(DateTime.now().add(Duration(days: 2))).length),
    DayDisplay(date: DateTime.now().add(Duration(days: 3)), events: eventsOnDay(DateTime.now().add(Duration(days: 3))).length),
    DayDisplay(date: DateTime.now().add(Duration(days: 4)), events: eventsOnDay(DateTime.now().add(Duration(days: 4))).length),
    DayDisplay(date: DateTime.now().add(Duration(days: 5)), events: eventsOnDay(DateTime.now().add(Duration(days: 5))).length),
    DayDisplay(date: DateTime.now().add(Duration(days: 6)), events: eventsOnDay(DateTime.now().add(Duration(days: 6))).length),
    DayDisplay(date: DateTime.now().add(Duration(days: 7)), events: eventsOnDay(DateTime.now().add(Duration(days: 7))).length),
    DayDisplay(date: DateTime.now().add(Duration(days: 8)), events: eventsOnDay(DateTime.now().add(Duration(days: 8))).length),
    DayDisplay(date: DateTime.now().add(Duration(days: 9)), events: eventsOnDay(DateTime.now().add(Duration(days: 9))).length),
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
            date: DateTime.now().add(Duration(days: days.length)), events: eventsOnDay(DateTime.now().add(Duration(days: days.length))).length));
      }
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      currentPageIndex = index;
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
      body: <Widget>[Column(children: [
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
      SuggestionsPage()][currentPageIndex],
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: ImageIcon(AssetImage('assets/logo-alone.png'),size: 20.0,), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.star_border,size: 20.0), label: "Suggestions")
        ],
        onTap: _onItemTapped,
        currentIndex: currentPageIndex,),
    );
  }
}
