import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Font{
  static TextStyle neueEinstellung (){
    return const TextStyle(
      fontFamily:'Neue Einstellung'
    );
  }

  static TextStyle neueEinstellung2(){
    return const TextStyle(
        fontFamily:'Neue Einstellung',
        fontWeight: FontWeight.w500,
        fontSize: 14,
      color: Colors.teal
    );
  }

  static TextStyle neueEinstellung3(){
    return const TextStyle(
        fontFamily:'Neue Einstellung',
        fontWeight: FontWeight.w500,
        fontSize: 14,
        color: Colors.black87
    );
  }
  static TextStyle neueEinstellung4(){
    return const TextStyle(
        fontFamily:'Neue Einstellung',
        fontWeight: FontWeight.w500,
        fontSize: 14,
        color: Colors.amber
    );
  }

  static TextStyle sacramento(){
    return GoogleFonts.sacramento(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        color: Colors.amber
    );/*const TextStyle(
        fontFamily:'Neue Einstellung',

    );*/
  }
}





