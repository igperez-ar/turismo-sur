import 'package:flutter/material.dart';
import 'package:turismo_app/views/Explorar.dart';
import 'package:turismo_app/views/Mapa.dart';
import 'package:turismo_app/views/Favoritos.dart';

import 'dart:async'; 
import 'dart:convert'; 
import 'package:http/http.dart' as http; 
import 'package:turismo_app/models/Alojamiento.dart';


List<Alojamiento> parseAlojamientos(String responseBody) { 
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
}

class App extends StatefulWidget {

  @override
  State createState() => _AppState();
}

class _AppState extends State<App> {
  int _currentIndex = 0;
  List<Widget> _children;

  @override
  void initState() {
    super.initState();
    final alojamientos = fetchAlojamientos();

    setState(() {
      _children = [
        Explorar(
          alojamientos: alojamientos
        ),
        Mapa(
          alojamientos: alojamientos,
        ),
        Favoritos(),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: changeTabIndex,
        backgroundColor: Colors.white,
        fixedColor: Colors.teal[400],
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Explorar'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            title: Text('Mapa'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            title: Text('Favoritos'),
          ),
        ],
      ), 
    );
  }

  void changeTabIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}