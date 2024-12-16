import 'package:flutter/material.dart';

class MyAppThemes {
  //Light theme
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0XFFFFFFFF),
    colorScheme: const ColorScheme.light(
      //text
      primary: Color(0XFF272727),
      //hint text
      inversePrimary: Color(0x80272727),
      //texctfield,containers/cards
      secondary: Color(0XFFF4F4F4),
      //buttons,cta
      tertiary: Color(0XFF8E6CEF),
      //other elements
      surface: Color(0XFFFFFFFF),
    ),
  );
//dark theme
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0XFF1D182A),
    colorScheme: const ColorScheme.light(
      primary: Color(0XFFFFFFFF),
      inversePrimary: Color(0x80FFFFFF),
      secondary: Color(0XFF342F3F),
      tertiary: Color(0XFF8E6CEF),
      surface: Color(0XFF1D182A),
    ),
  );
}
