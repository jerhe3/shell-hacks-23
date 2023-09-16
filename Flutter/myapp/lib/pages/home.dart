import 'package:flutter/material.dart';
import 'package:myapp/pages/mainPage.dart';
import 'package:myapp/utils/calendar/calendar-utils.dart';
import 'package:myapp/utils/calendar/demo-data.dart';
import 'package:myapp/utils/calendar/optimizer.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}


class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {


    // TEMPORARY TESTING FOR CALENDAR ORGANIZATION

    Optimizer optimizer = Optimizer();
    print("fdsfsdfsf");
    optimizer.optimize(RangeUtils.today(), DEMO_EVENTS_1, DEMO_CONFIG_1);


    return Text("TEMPORARY");
    // return Scaffold(
    //   body: MainPage(),
    //   // bottomNavigationBar: BottomNavigationBar(items: 
    //   //   [BottomNavigationBarItem(icon: Icon(Icons.star), label: "Hi there"),
    //   //   BottomNavigationBarItem(icon: ImageIcon(AssetImage('/assets/logo-alone.png')), label: "Bye")],
    //   //   currentIndex: 0,
    //   //   selectedItemColor: Theme.of(context).primaryColor,
    //   //   onTap: (value) {
    //   //     print("Tapped");
    //   //   },
    //   //   ),
    //   );//Scaffold(body: MainPage(), bottomNavigationBar: AppBar(),);

  }

}