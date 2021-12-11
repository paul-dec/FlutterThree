import 'package:flutter/material.dart';

abstract class ThemeColor {
  static const Color xBlue = Color(0xff0d1137);

  static const Color xPurple = Color(0xffe52165);
}

abstract class ThemeText {
  static const TextStyle whiteText = TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontStyle: FontStyle.normal,
  );

  static const TextStyle whiteTextBold = TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.bold
  );

  static const TextStyle whiteTextItalic = TextStyle(
    color: Colors.white,
    fontSize: 14,
    fontStyle: FontStyle.italic,
  );

  static const TextStyle xPurpleTextItalic = TextStyle(
    color: ThemeColor.xPurple,
    fontSize: 14,
    fontStyle: FontStyle.italic,
  );
}