import 'dart:async'; 
import 'dart:convert'; 
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http; 

import 'package:flutter/material.dart';
import 'package:turismo_app/bloc/alojamiento_bloc.dart';

import 'package:turismo_app/models/Alojamiento.dart';
import 'package:turismo_app/screens/screens.dart';

/* List<Alojamiento> parseAlojamientos(String responseBody) { 
   final parsed = json.decode(responseBody).cast<Map<String, dynamic>>(); 
   return parsed.map<Alojamiento>((json) => Alojamiento.fromJson(json)).toList(); 
} 

Future<List<Alojamiento>> fetchAlojamientos() async { 
   final response = await http.get('http://192.168.1.35:3000/alojamientos?select=id,nombre,domicilio,lat,lng,foto,clasificacion:clasificaciones(id,nombre),categoria:categoria_id,localidad:localidades(id,nombre)'); 
   if (response.statusCode == 200) { 
      return parseAlojamientos(response.body); 
   } else { 
      throw Exception('Unable to fetch products from the REST API'); 
   } 
} */

class RootScreen extends StatefulWidget {

  @override
  State createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _currentIndex = 0;
  List<Widget> _children;
  /* AlojamientoBloc _alojamientoBloc; */

  void changeTabIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    /* _alojamientoBloc = BlocProvider.of<AlojamientoBloc>(context); */

    _children = [
      ExplorarScreen(),
      MapaScreen(),
      /* ExplorarScreen(
        alojamientos: alojamientos
      ),
      MapaScreen(
        alojamientos: alojamientos,
      ), */
      ChatScreen(),
      PerfilScreen()
    ];
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              spreadRadius: 2,
              offset: Offset(0,-1)
            )
          ]
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: changeTabIndex,
          backgroundColor: Theme.of(context).bottomAppBarColor,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Theme.of(context).iconTheme.color,
          selectedIconTheme: IconThemeData(size: 32),
          selectedLabelStyle: TextStyle(height: 0),
          showSelectedLabels: false,
          elevation: 15,
          unselectedLabelStyle: TextStyle(height: 1.2, fontSize: 13),
          iconSize: 26,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              title: Text('Explorar'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              title: Text('Mapa'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              title: Text('Chat'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Perfil'),
            ),
          ],
        ), 
      )
    );
  }
}