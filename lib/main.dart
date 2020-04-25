import 'package:flutter/material.dart';
import 'package:turismo_app/views/Filtros.dart';
import 'App.dart';

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
      /* home: App(), */
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => App(),
        '/filtros': (BuildContext context) => Filtros()
      },
    );
  }
}
