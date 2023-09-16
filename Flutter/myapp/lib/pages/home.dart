import 'package:flutter/material.dart';
import 'package:myapp/pages/mainPage.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}


class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: MainPage(),
      // bottomNavigationBar: BottomNavigationBar(items: 
      //   [BottomNavigationBarItem(icon: Icon(Icons.star), label: "Hi there"),
      //   BottomNavigationBarItem(icon: ImageIcon(AssetImage('/assets/logo-alone.png')), label: "Bye")],
      //   currentIndex: 0,
      //   selectedItemColor: Theme.of(context).primaryColor,
      //   onTap: (value) {
      //     print("Tapped");
      //   },
      //   ),
      );//Scaffold(body: MainPage(), bottomNavigationBar: AppBar(),);

  }

}