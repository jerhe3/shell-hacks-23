import 'package:flutter/material.dart';

class DayDisplay extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DayDisplayState();

}

class DayDisplayState extends State<DayDisplay> {
  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
    child: Container(decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(15)),
    color: Theme.of(context).primaryColor),
    width: 350,
    height: 200,
    child:
      const Row(children: [
        Center(child:
          Column(children: [
            Text("Monday", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold ),),
            Text("18"),
            Text("Nov")],
          ),
        )
      ]),
      ),
    );
  }

}