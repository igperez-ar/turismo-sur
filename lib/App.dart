import 'package:flutter/material.dart';
import 'package:turismo_app/views/Alojamiento.dart';
import 'package:turismo_app/views/Explorar.dart';
import 'package:turismo_app/views/Gastronomico.dart';
import 'package:turismo_app/views/Mapa.dart';
import 'package:turismo_app/views/Favoritos.dart';

class App extends StatefulWidget {

  @override
  State createState() => _AppState();
}

class _AppState extends State<App> {
  int _currentIndex = 0;
  
  final List<Widget> _children = [
    Explorar(),
    Mapa(
      places: ['s'],
    ),
    Favoritos(),
  ];

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
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void changeTabIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}