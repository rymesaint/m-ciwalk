import 'package:ciwalk/src/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme = ThemeData(
  fontFamily: GoogleFonts.notoSans().fontFamily,
  backgroundColor: Colors.white,
  primaryColor: primaryColor,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: primaryColor,
    ),
  ),
  splashColor: primaryColor,
  splashFactory: InkSplash.splashFactory,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    titleTextStyle: const TextStyle(
      color: Colors.black,
    ),
    iconTheme: const IconThemeData(
      color: Colors.black,
    ),
    elevation: 0,
    actionsIconTheme: IconThemeData(
      color: primaryColor,
    ),
  ),
  radioTheme: RadioThemeData(
    fillColor: MaterialStateProperty.all(primaryColor),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: primaryColor,
  ),
  bottomAppBarColor: primaryColor,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    unselectedItemColor: unselectedColor,
    selectedItemColor: primaryColor,
    selectedLabelStyle: const TextStyle(
      fontSize: 12,
    ),
    unselectedLabelStyle: const TextStyle(
      fontSize: 12,
    ),
    type: BottomNavigationBarType.fixed,
  ),
);
