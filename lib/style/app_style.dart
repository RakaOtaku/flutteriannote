import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyle{

  static Color mainColor = Color.fromARGB(255, 152, 168, 248);
  static Color accentColor = Color.fromARGB(255, 179, 192, 255);


  static List<Color> cardsColor = [
    Colors.pink,
    Colors.lightBlue,
    Colors.red,
    Colors.green,
    Colors.grey,
    Colors.cyan
  ];


   static TextStyle mainTitle = GoogleFonts.inter(
    fontSize: 18.0,
    fontWeight: FontWeight.normal
   );

   static TextStyle mainContent = GoogleFonts.inter(
    fontSize: 14.0,
    fontWeight: FontWeight.normal
   );
}