import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/api/chat_api.dart';
import 'package:myapp/ui/suggestions/suggestion-card.dart';
import 'package:myapp/utils/calendar/calendar-suggestions.dart';
import 'package:myapp/utils/calendar/demo-data.dart';
import 'package:myapp/utils/pagescrollphysics.dart';
import '../utils/globals.dart';

int NUM_CARDS = 5;
List<SuggestionsRow> newRows = List.empty(growable: true);

class SuggestionsPage extends StatefulWidget {
  SuggestionsPage() {
    print("Init 2");
    print(userId);
    if (newRows.isEmpty) {
      newRows.add(SuggestionsRow(
        prompt: "Restaraunts",
      ));
      newRows.add(SuggestionsRow(
        prompt: "Outdoor",
      ));
      newRows.add(SuggestionsRow(
        prompt: "Nightlife",
      ));
      newRows.add(SuggestionsRow(
        prompt: "Culture",
      ));
    }
    print("Init 3");
  }

  @override
  State<StatefulWidget> createState() => SuggestionsPageState();
}

double _welcomeOpacity = 1.0;
double _titleOpacity = 0.0;

class SuggestionsPageState extends State<SuggestionsPage> {
  GPTHandler gptHandler = GPTHandler();

  @override
  Widget build(BuildContext context) {
    // _createRow("Restaraunts");
    // _createRow("Outdoor");
    // _createRow("Nightlife");
    // _createRow("Culture");

    print("Build");

    ScrollController controller = ScrollController();

    controller.addListener(() {
      setState(() {
        _welcomeOpacity = mapRange(controller.position.pixels, 150, 230, 1, 0);
        _titleOpacity = mapRange(controller.position.pixels, 200, 260, 0, 1);
      });
    });

    return Scaffold(
      body: CustomScrollView(
        controller: controller,
        slivers: <Widget>[
          SliverAppBar(
            title: Text(
              'Suggestions',
              style: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, _titleOpacity),
                  fontWeight: FontWeight.bold),
            ),
            backgroundColor: Theme.of(context).secondaryHeaderColor,
            expandedHeight: 300.0,
            collapsedHeight: 50.0,
            toolbarHeight: 50.0,
            pinned: true,
            stretch: true,
            // floating: true,
            flexibleSpace: FlexibleSpaceBar(
                stretchModes: <StretchMode>[
                  StretchMode.fadeTitle,
                ],
                background: Image.asset('assets/miami.jpeg', fit: BoxFit.fill),
                title: Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 30, 5),
                  child: Container(
                    height: 50,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(children: [
                            Text("Welcome to",
                                style: TextStyle(
                                  color: Color.fromRGBO(
                                      255, 255, 255, _welcomeOpacity),
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w700,
                                )),
                            Text(
                              " Miami!",
                              style: TextStyle(
                                  color: Color.fromRGBO(
                                      255, 255, 255, _welcomeOpacity),
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w900),
                            )
                          ]),
                          Text(
                            "Get an AI-curated list of suggested activities to do during your personal free times.",
                            style: TextStyle(
                                color: Color.fromRGBO(
                                    255, 255, 255, _welcomeOpacity),
                                fontSize: 9.0),
                          )
                        ]),
                  ),
                )),
          ),
          SliverFixedExtentList.builder(
            itemExtent: 350.0,
            itemCount: newRows.length,
            addAutomaticKeepAlives: true,
            itemBuilder: (BuildContext context, int index) {
              print(newRows);
              return newRows[index];
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => _promptAI(context),
          child: ImageIcon(
            AssetImage('assets/wand.png'),
            size: 30.0,
          )),
    );
  }

  List<SuggestionsRow> rows = List.empty(growable: true);

  Widget _createRow(String prompt) {
    rows.add(SuggestionsRow(prompt: prompt));
    return rows.last;
  }

  _promptAI(BuildContext context) {
    String _name = "";
    var content = TextField(
      style: TextStyle(fontSize: 18.0),
      autofocus: true,
      decoration: InputDecoration(
        labelStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),
        labelText: 'What are you in the mood for?',
      ),
      onChanged: (value) {
        _name = value;
      },
    );
    var btn = MaterialButton(
      child: Text(
        'Done',
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
      onPressed: () => _generateCards(_name),
    );
    var cancelButton = MaterialButton(
        child: Text('Cancel', style: TextStyle(fontSize: 18.0)),
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
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    offset: const Offset(0.0, 10.0),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min, // To make the card compact
                children: <Widget>[
                  SizedBox(height: 16.0),
                  Text("Generate Ideas",
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold)),
                  Container(padding: EdgeInsets.all(20), child: content),
                  Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[cancelButton, btn]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _generateCards(String prompt) async {
    Navigator.of(context).pop(false);
    setState(() {
      newRows.add(SuggestionsRow(prompt: prompt));
    });
  }
}

double mapRange(
    double value, double fromMin, double fromMax, double toMin, double toMax) {
  if (value > fromMax) return toMax;
  if (value < fromMin) return toMin;

  double leftSpan = fromMax - fromMin;
  double rightSpan = toMax - toMin;

  double valueScaled = (value - fromMin) / leftSpan;

  return toMin + (valueScaled * rightSpan);
}

class SuggestionsRow extends StatefulWidget {
  final String prompt;

  const SuggestionsRow({super.key, required this.prompt});

  @override
  State<StatefulWidget> createState() => SuggestionsRowState(prompt);
}

class SuggestionsRowState extends State<SuggestionsRow>
    with AutomaticKeepAliveClientMixin {
  final String prompt;
  final List<SuggestionCard> cards = List.empty(growable: true);

  SuggestionsRowState(this.prompt) {
    // Create the cards
    for (int i = 0; i < NUM_CARDS; i++) {
      cards.add(SuggestionCard(prompt: prompt, range: _randomRange()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.black12)),
      child: Column(children: [
        Padding(
          padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(prompt,
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),
          ),
        ),
        Container(
          height: 300,
          child: ListView.builder(
              addAutomaticKeepAlives: true,
              clipBehavior: Clip.none,
              physics: PagingScrollPhysics(itemDimension: 325 + 15 + 15),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: NUM_CARDS,
              itemBuilder: (content, index) {
                return Padding(
                    padding: EdgeInsets.fromLTRB(15, 5, 15, 10),
                    child: cards[index]);
              }),
        ),
      ]),
    );
  }

  Random rand = Random();

  DateTimeRange _randomRange() {
    return CalendarSuggestions.prunedFreeTimes[
        rand.nextInt(CalendarSuggestions.prunedFreeTimes.length)];
  }

  @override
  bool get wantKeepAlive => true;
}
