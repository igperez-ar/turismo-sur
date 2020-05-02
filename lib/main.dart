import 'package:flutter/material.dart';
import 'package:turismo_app/views/Explorar.dart';
import 'package:turismo_app/views/Favoritos.dart';
import 'package:turismo_app/views/Mapa.dart';
import 'App.dart';
import 'package:turismo_app/views/Filtros.dart';
import 'dart:async'; 
import 'dart:convert'; 
import 'package:http/http.dart' as http; 
import 'package:turismo_app/models/Alojamiento.dart';


void main() => runApp(MyApp(/* alojamientos: fetchAlojamientos() */));

/* List<Alojamiento> parseAlojamientos(String responseBody) { 
   final parsed = json.decode(responseBody).cast<Map<String, dynamic>>(); 
   return parsed.map<Alojamiento>((json) => Alojamiento.fromJson(json)).toList(); 
} 

Future<List<Alojamiento>> fetchAlojamientos() async { 
   final response = await http.get('http://192.168.1.36:3000/alojamientos'); 
   if (response.statusCode == 200) { 
      return parseAlojamientos(response.body); 
   } else { 
      throw Exception('Unable to fetch products from the REST API'); 
   } 
} */

class MyApp extends StatelessWidget {
  /* final Future<List<Alojamiento>> alojamientos;
  MyApp({Key key, this.alojamientos}) : super(key: key); */
  
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
        /* '/mapa': (BuildContext context) => Mapa(places: ['', ''],),
        '/favoritos': (BuildContext context) => Favoritos(), */
        '/filtros': (BuildContext context) => Filtros()
      },
    );
  }
}
