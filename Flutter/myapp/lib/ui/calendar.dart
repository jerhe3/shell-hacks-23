import 'dart:core';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/ui/calendar_model.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class Calendar extends StatefulWidget {

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {

    DateTime _selectedDay = DateTime.now();

    // CalendarController _calendarController;
     Map<DateTime, List<dynamic>> _events = {};
     List<CalendarItem> _data = [];

     List<dynamic> _selectedEvents = [];
     List<Widget> get _eventWidgets => _selectedEvents.map((e) => events(e)).toList();
  
  void initState() {
    super.initState();
    // DB.init().then((value) => _fetchEvents());
    // _calendarController = CalendarController();
  }

  void dispose(){
    // _calendarController.dispose();
    super.dispose();
  }

  Widget events(var d){
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
          decoration: BoxDecoration(
              border: Border(
            top: BorderSide(color: Theme.of(context).dividerColor),
          )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:[Text(d,
                            style:
                                Theme.of(context).primaryTextTheme.bodyText1),
                                IconButton(icon: const FaIcon(FontAwesomeIcons.trashAlt, color: Colors.redAccent, size: 15,), onPressed: ()=> _deleteEvent(d))
             ]) ),
        );  }

  void _onDaySelected(DateTime day, DateTime day2) {
    setState(() {
      print(day);
      _selectedDay = day;
      // _selectedEvents = events;
    });
  }

  void _create(BuildContext context) {
    String _name = "";
    var content = TextField(
      autofocus: true,
      decoration: InputDecoration(
        labelText: 'Workout Name',
      ),
      onChanged: (value) {
        _name = value;
      },
    );
    var btn = MaterialButton(
      child: Text('Save'),
      onPressed: () => _addEvent(_name),
    );
    var cancelButton = MaterialButton(
            child: Text('Cancel',),
            onPressed: () => Navigator.of(context).pop(false));
    showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              const BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              const SizedBox(height: 16.0),
              Text("Add Event"),
              Container(padding: const EdgeInsets.all(20), child: content),
              Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[btn, cancelButton]),
            ],
          ),
        ),
      ],
    ),
      ),
    );
  }

  void _fetchEvents() async{
    _events = {};
    List<Map<String, dynamic>> _results = [];//await DB.query(CalendarItem.table);
    _data = _results.map((item) => CalendarItem.fromMap(item)).toList();
      _data.forEach((element) {
        DateTime formattedDate = DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.parse(element.date.toString())));
      if(_events.containsKey(formattedDate)){
        // _events[formattedDate].add(element.name.toString());
      }
      else{
          _events[formattedDate] = [element.name.toString()];
        }
      }
    );
    setState(() {});
  }

  void _addEvent(String event) async{
    CalendarItem item = CalendarItem(
      id: 1,
      date: _selectedDay.toString(),
      name: event
    );
    // await DB.insert(CalendarItem.table, item);
    _selectedEvents.add(event);
    _fetchEvents();
    
    Navigator.pop(context);
  }

  // Delete doesnt refresh yet, thats it, then done!
  void _deleteEvent(String s){
    List<CalendarItem> d = _data.where((element) => element.name == s).toList();
    if(d.length == 1){
      // DB.delete(CalendarItem.table, d[0]);
      _selectedEvents.removeWhere((e) => e == s);
      _fetchEvents();
    }
  }

  Widget calendar(){
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(6),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black45,
            blurRadius: 10,
            offset: new Offset(0.0, 0.0)
          )
        ]
      ),
      child: TableCalendar(
          
            calendarStyle: const CalendarStyle(
              canMarkersOverflow: true,
              markerDecoration: BoxDecoration(color: Colors.white),
              todayTextStyle: TextStyle(color: Colors.black),
              todayDecoration: BoxDecoration(color: Colors.white54),
              defaultTextStyle: TextStyle(color: Colors.white, fontSize: 15),
              selectedDecoration: BoxDecoration(color: Colors.green),
              outsideTextStyle: TextStyle(color: Colors.white60),
              weekendTextStyle: TextStyle(color: Colors.white60),
              outsideDaysVisible: false,
            ),
            
            onDaySelected: _onDaySelected,
          
            headerStyle: HeaderStyle(
              leftChevronIcon: const Icon(Icons.arrow_back_ios, size: 20, color: Colors.white),
              rightChevronIcon: const Icon(Icons.arrow_forward_ios, size: 20, color: Colors.white),
            ),

            focusedDay: _selectedDay,
            firstDay: DateTime(DateTime.now().year, DateTime.now().month, 1),
            lastDay: DateTime(DateTime.now().year, DateTime.now().month + 1, 0)
            
      )
          );
  }

  Widget eventTitle(){
    if(_selectedEvents.length == 0){
      return Container(
              padding: const EdgeInsets.fromLTRB(15, 20, 15, 15),
              child:Text("No events", style: Theme.of(context).primaryTextTheme.headline1),
            );
    }
    return Container(
              padding: const EdgeInsets.fromLTRB(15, 20, 15, 15),
              child:Text("Events", style: Theme.of(context).primaryTextTheme.headline1),
            );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(15),
        child: Container(constraints: BoxConstraints(maxWidth: 400),
          child: ListView(
            children: <Widget>[
              calendar(),
            ],
          ),
        )
      );
  }
}