import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants.dart';

final Shader linearGradient = const LinearGradient(colors: <Color>[
  Color.fromRGBO(102, 189, 137, 1),
  Color.fromRGBO(168, 200, 181, 1)
], begin: Alignment.topLeft, end: Alignment.bottomRight)
    .createShader(const Rect.fromLTWH(0.0, 0.0, 500.0, 70.0));

class HeroWidget extends StatelessWidget {
  const HeroWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.fromLTRB(
            MediaQuery.of(context).size.width * 0.025, 0, 0, 0),
        child: Image.asset('assets/full-logo-removebg-preview.png',
            width: MediaQuery.of(context).size.width * 0.8),
      ),
    );
  }
}
