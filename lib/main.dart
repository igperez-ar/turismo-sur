import 'package:flutter/material.dart';
import 'App.dart';
import 'package:turismo_app/views/Filtros.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Main',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => App(),
        '/filtros': (BuildContext context) => Filtros()
      },
    );
  }
}
