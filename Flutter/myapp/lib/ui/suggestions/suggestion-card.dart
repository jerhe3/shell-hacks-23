import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/api/chat_api.dart';

class SuggestionCard extends StatefulWidget {

  final String prompt;
  final DateTimeRange range;

  const SuggestionCard({super.key, required this.prompt, required this.range});

  @override
  State<StatefulWidget> createState() => SuggestionCardState(range, prompt);

}

class SuggestionCardState extends State<SuggestionCard> {

  GPTHandler gptHandler = GPTHandler();

  final String prompt;
  final DateTimeRange range;

  SuggestionCardState(this.range, this.prompt);


  // DEFAULT
  Widget _returnCard = Padding(padding: EdgeInsets.all(100), child: CircularProgressIndicator(),); 


  
  generateReturnCard(String openaiPrompt) async {

    String weekday = DateFormat.E().format(range.start);
    String month = DateFormat.MMM().format(range.start);

    String start = DateFormat.Hm().format(range.start);
    String end = DateFormat.Hm().format(range.end);

    String response = await gptHandler.ask(openaiPrompt);

    print(response);

    response.replaceAll(p, replace)

    String title = response.split('\n')[0];
    String desc = response.split

  setState(() {
    _returnCard = Padding(
          padding: EdgeInsets.fromLTRB(0,0,0,10),
          child: Column(
            children: [
              Container(
                width: 325,
                height: 175,
                child: Image.asset('assets/miami.jpeg', fit: BoxFit.cover),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            constraints: BoxConstraints(minWidth: 200, maxWidth: 200, minHeight: 90),
                            decoration: BoxDecoration(border:BorderDirectional(end: BorderSide(color: Colors.black12, width: 2))),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(title, style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.bold),),
                                  SizedBox(height: 3,),
                                  Text("This is a very long description that will be very cool to read.", style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal), softWrap: true, overflow: TextOverflow.visible,),
                                ],
                              ),
                            )
                          ),
                          Container(
                            constraints: BoxConstraints(minHeight: 90, minWidth: 95),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(weekday + " • " + month, style: TextStyle(fontSize: 15.0),),
                                  Text(range.start.day.toString(), style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),),
                                  Text(start+"-"+end, style: TextStyle(fontSize: 15.0),),
                                ],
                              ),
                            ),
                            )
                          ]
                        ),
                    ],
                  ),
              )
            ],
          ),
        );
  });
    
  }

  @override
  Widget build(Object context) async {

    // OPEN AI PROMPT !!!!
    String openai = "I have an open time slot between ${DateFormat.jm().format(range.start)} and ${DateFormat.jm().format(range.end)} this ${DateFormat.EEEE().format(range.start)}. I live in downtown Miami. I am in the mood for $prompt. Give me something fun to do.";

    generateReturnCard(openai);

    return SizedBox(width: 325, height: 275, 
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Color.fromRGBO(245, 245, 245, 1.0),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 10)],
        ),
        child: _returnCard
      ),
    );
  }

}