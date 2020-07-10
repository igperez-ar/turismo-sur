import 'package:flutter/material.dart';

class AppTheme {

  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.teal,
    appBarTheme: AppBarTheme(
      color: Colors.teal[300],
    ),
    primaryColorDark: Colors.teal[100],
    accentTextTheme: TextTheme(
      headline1: TextStyle(
        color: Colors.teal[400],
        fontWeight: FontWeight.bold,
        fontSize: 15
      )
    ),
    bottomAppBarColor: Colors.white,
    cardColor: Colors.white,
    scaffoldBackgroundColor: Colors.grey[50],
    primaryIconTheme: IconThemeData(
      color: Colors.white
    ),
    iconTheme: IconThemeData(
      color: Colors.teal[300]
    ),
    disabledColor: Colors.grey[300],
    textTheme: TextTheme(
      headline1: TextStyle(
        color: Colors.grey[800],
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
      headline2: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        color: Colors.grey[700],
      ),
      headline3: TextStyle(
        fontSize: 16.0,
        color: Colors.grey[600],
      ),
      headline4: TextStyle(
        fontSize: 18,
        color: Colors.grey[800]
      ),
    ),
    accentColor: Colors.teal
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.black38,
    primaryIconTheme: IconThemeData(
      color: Colors.white
    ),
    iconTheme: IconThemeData(
      color: Colors.tealAccent
    ),
    primaryColorDark: Colors.teal[700],
    accentTextTheme: TextTheme(
      headline1: TextStyle(
        color: Colors.tealAccent,
        fontWeight: FontWeight.bold,
        fontSize: 15
      )
    ),
    bottomAppBarColor: Colors.black12,
    disabledColor: Colors.grey,
    textTheme: TextTheme(
      headline1: TextStyle(
        color: Colors.grey[400],
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
      headline2: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        color: Colors.grey[300],
      ),
      headline3: TextStyle(
        fontSize: 16.0,
        color: Colors.grey[500],
      ),
      headline4: TextStyle(
        fontSize: 18,
        color: Colors.grey[300]
      ),
    ),
    accentColor: Colors.teal
  );

}