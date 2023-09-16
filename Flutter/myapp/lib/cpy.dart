// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class HomeView extends StatefulWidget{
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>{
  @override
  Widget build(BuildContext context){
    // ignore: prefer_const_constructors
    return Scaffold(
      body: SafeArea(
      child:Container(
        color: Color.fromRGBO(102, 189, 137, 1),
        //color: Theme.of(context).secondaryColor,
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            topRow(),
            Text("Mo"),
            Text("Insert date"),
          Container(
              child: capsuleView(7),
            ),

          ],
        ),
      ),
      ),
    );
  }
}



 Widget hrizontalCapsuleListView() {
    return Container(
      width: 40,
      height: 150,
      child: ListView.builder(
        //controller: scrollController,
        scrollDirection: Axis.horizontal,
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: 31,
        itemBuilder: (BuildContext context, int index) {
          return capsuleView(index);
        },
      ),
    );
  }

 Widget capsuleView(int index) {
    return Container(
        // padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
        // child: GestureDetector(
        //   onTap: () {
        //     //setState(() {
        //       // currentDateTime = currentMonthList[index];
        //       Color.fromRGBO(0, 255, 0, 1);
        //     //});
        //   },
          //child: Container(
            width: 80,
            height: 140,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: <Color>[
                            Colors.red.withOpacity(0.8),
                            Colors.red.withOpacity(0.7),
                            Colors.red.withOpacity(0.6),
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(0.0, 1.0),
                    stops: const [0.0, 0.5, 1.0],
                    tileMode: TileMode.clamp),
                borderRadius: BorderRadius.circular(40),
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(4, 4),
                    blurRadius: 4,
                    spreadRadius: 2,
                    color: Colors.black12,
                  )
                ]),
            // child: Center(
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: <Widget>[
            //       Text(
            //         currentMonthList[index].day.toString(),
            //         style: TextStyle(
            //             fontSize: 48,
            //             fontWeight: FontWeight.bold,
            //             color:
            //                 (currentMonthList[index].day != currentDateTime.day)
            //                     ? HexColor("465876")
            //                     : Colors.white),
            //       ),
            //       Text(
            //         date_util.DateUtils
            //             .weekdays[currentMonthList[index].weekday - 1],
            //         style: TextStyle(
            //             fontSize: 20,
            //             fontWeight: FontWeight.bold,
            //             color:
            //                 (currentMonthList[index].day != currentDateTime.day)
            //                     ? HexColor("465876")
            //                     : Colors.white),
            //       )
            //     ],
              );

        
  }






//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             topRow(),
//           Container(
//             decoration: BoxDecoration(
//               color: Theme.of(context).primaryColor,
//             ),
//             //color: Color.fromRGBO(255, 0, 0, 1),
//             padding: EdgeInsets.all(16.0),
//             child: Column(children: <Widget>[
//                           Text(
//                 "Mo Hardcaoded",
//                 style: TextStyle(
//                 ),
//               ),
//               Container(
//                 width: 4.0,
//                 height: 4.0,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Colors.red,
//                 ),
//               ),
//             ],
//             ),
//           )
//         ],
//         ),
//       ),
//       ),
//     );
//   }
// }

class topRow extends StatelessWidget {
  const topRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
                  Row(
      children: <Widget>[
        Text(
          "Daily",
          style: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          )
        ),
        SizedBox(width: 8.0),
        Text(
          "meetings",
          style: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
    Spacer(),
        Text(
          "Jan",
            style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 1),
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
          ),
      ],
    );
  }
}