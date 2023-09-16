import 'package:flutter/material.dart';
import 'package:myapp/pages/home.dart';
import 'package:myapp/utils/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Schedule Builder',
      theme: ThemeData(
        primarySwatch: MaterialColorGenerator.from(Color.fromRGBO(102, 189, 137, 1.0)),
        secondaryHeaderColor: MaterialColorGenerator.from(Color.fromRGBO(229, 234, 250, 1.0)),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
