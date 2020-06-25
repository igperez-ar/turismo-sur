import 'package:flutter/material.dart';

import 'dart:async'; 
import 'dart:convert'; 
import 'package:http/http.dart' as http;
import 'package:turismo_app/models/models.dart';
import 'package:turismo_app/components/components.dart';

Future<List<Localidad>> _fetchLocalidades() async { 
  final response = await http.get('http://192.168.1.35:3000/localidades'); 
  if (response.statusCode == 200) { 
    List jsonResponse = json.decode(response.body); 
    return jsonResponse.map((value) => Localidad.fromJson(value)).toList();
  } else { 
    throw Exception('Failed to load Localidades from API.'); 
  } 
}

Future<List<Clasificacion>> _fetchClasificaciones() async { 
   final response = await http.get('http://192.168.1.35:3000/clasificaciones'); 
   if (response.statusCode == 200) { 
      List jsonResponse = json.decode(response.body); 
      return jsonResponse.map((value) => Clasificacion.fromJson(value)).toList(); 
   } else { 
      throw Exception('Failed to load Clasificaciones from API.'); 
   } 
}

Future<List<Especialidad>> _fetchEspecialidades() async { 
   final response = await http.get('http://192.168.1.35:3000/especialidades'); 
   if (response.statusCode == 200) { 
      List jsonResponse = json.decode(response.body); 
      return jsonResponse.map((value) => Especialidad.fromJson(value)).toList(); 
   } else { 
      throw Exception('Failed to load Especialidades from API.'); 
   } 
}

Future<List<Actividad>> _fetchActividades() async { 
   final response = await http.get('http://192.168.1.35:3000/actividades'); 
   if (response.statusCode == 200) { 
      List jsonResponse = json.decode(response.body); 
      return jsonResponse.map((value) => Actividad.fromJson(value)).toList(); 
   } else { 
      throw Exception('Failed to load Actividades from API.'); 
   } 
}

class FiltrosScreen extends StatefulWidget {
  FiltrosScreen({Key key}) : super(key: key);

  @override
  _FiltrosScreenState createState() => _FiltrosScreenState();
}

class _FiltrosScreenState extends State<FiltrosScreen> {

  final Future<List<Localidad>> localidades = _fetchLocalidades();
  final Future<List<Clasificacion>> clasificaciones = _fetchClasificaciones();
  final Future<List<Especialidad>> especialidades = _fetchEspecialidades();
  final Future<List<Actividad>> actividades = _fetchActividades();

  RangeValues _categorias = RangeValues(1, 5);
  bool _catUnica = true;
  /* List<Localidad> _localidades = []; */
  /* List<Clasificacion> _clasificaciones = [];
  List<Especialidad> _especialidades = [];
  List<Actividad> _actividades = []; */

  bool alojamientos = false;
  bool gastronomia = false;

  List<String> _filters = <String>[];

 
  
  List<Widget> _getChipsWidgets(items) {
    return items.map<Widget>((item) {
      return ChipWidget(
        pressed: _filters.contains(item.nombre), 
        title: item.nombre, 
        onPress: (bool pressed) {
          setState(() {
            if (!pressed) {
              _filters.add(item.nombre);
            } else {
              _filters.removeWhere((String name) {
                return name == item.nombre;
              });
            }
          });
        }
      );
        /* return FilterChip(
          selectedShadowColor: Colors.white,
          backgroundColor: Colors.white,
          elevation: 3.8,
          pressElevation: 0,
          avatar: CircleAvatar(
            child: Text(item.nombre[0].toUpperCase()),
          ),
          label: Text(item.nombre),
          showCheckmark: false,
          selected: _filters.contains(item.nombre),
          onSelected: (bool selected) {
            setState(() {
              if (selected) {
                _filters.add(item.nombre);
              } else {
                _filters.removeWhere((String name) {
                  return name == item.nombre;
                });
              }
            });
          },
      ); */
    }).toList();
  }

  Widget _filter(String title, Widget _widget) {
    return (
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container (
            margin: EdgeInsets.only(bottom: 10),
            child: Text(title, style: TextStyle(
              color: Colors.grey[700],
              fontWeight: FontWeight.bold,
              fontSize: 18
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 30),
            child: _widget
          )
        ],
      )
    );
  }

  Widget _section(String title) {
    return (
      Container(
        margin: EdgeInsets.only(bottom: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title.toUpperCase(), style: TextStyle(
                color: Colors.grey[700],
                fontWeight: FontWeight.bold,
                fontSize: 21
              )
            ),
            Divider(thickness: 1.5, height: 15, color: Colors.grey[400],),
          ],
        )
      )
    );
  }

  void _changeShowOnly(String option) {
    setState(() {
      switch (option) {
        case 'alojamientos':
          gastronomia = false;
          alojamientos = !alojamientos;
        break;
        case 'gastronomia':
          alojamientos = false;
          gastronomia = !gastronomia;
        break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Filtros', 
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          padding: EdgeInsets.only(left:10),
          icon: Icon(Icons.check, color: Colors.white, size: 30), 
          onPressed: () => Navigator.pop(context)
        ),
        actions: <Widget>[
          /* IconButton(
            padding: EdgeInsets.only(right:10),
            icon: Icon(Icons.close, color: Colors.white, size: 32), 
            onPressed: () => Navigator.pop(context)
          ), */
          FlatButton(
            child: Text('RESET', style: TextStyle(
                color: Colors.white,
                fontSize: 18
              ),
              textAlign: TextAlign.center,
            ),
            onPressed: null
          ),
        ],
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          children: <Widget>[ 
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _section('general'),
                SearchBar(),
                SizedBox(height: 30),
                _filter('Mostrar sólo', 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FlatButtonWidget(
                        onPress: () => _changeShowOnly('alojamientos'), 
                        title: "Alojamientos",
                        pressed: alojamientos,
                      ),
                      FlatButtonWidget(
                        onPress: () => _changeShowOnly('gastronomia'), 
                        title: "Gastronomía",
                        pressed: gastronomia,
                      )
                    ],
                  )
                ),
                _filter(
                  'Localidad', 
                  FutureBuilder<List<Localidad>>(
                    future: localidades, builder: (context, snapshot) {
                      if (snapshot.hasError) print(snapshot.error); 
                      return snapshot.hasData ? 
                        Wrap(
                          runSpacing: 10,
                          spacing: 10,
                          children: _getChipsWidgets(snapshot.data)
                        )
                      
                      : Center(child: CircularProgressIndicator()); 
                    },
                  ),
                ),
                SizedBox(height: 30),
                _section('alojamientos'),
                _filter(
                  'Categoría', 
                  Column(
                    children: <Widget>[
                      RangeSlider(
                        values: _categorias,
                        min: 1,
                        max: 5,
                        divisions: 4,
                        labels: RangeLabels(_categorias.start.ceil().toString(), _categorias.end.ceil().toString()),
                        onChanged: (RangeValues newValues) {
                          setState(() {
                            _categorias = newValues;
                          });
                        },
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        child: CheckBoxWidget(
                          title: 'Categoría única',
                          checked: _catUnica, 
                          onPress: () =>
                            setState(() {
                              _catUnica = !_catUnica;
                            })
                        )
                      )
                    ]
                  )
                ),
                _filter(
                  'Clasificación',
                  FutureBuilder<List<Clasificacion>>(
                    future: clasificaciones, builder: (context, snapshot) {
                      if (snapshot.hasError) print(snapshot.error); 
                      return snapshot.hasData ? 
                        MultiSelect(options: snapshot.data)
                      
                      : Center(child: CircularProgressIndicator()); 
                    },
                  ),
                ),
                SizedBox(height: 30),
                _section('Gastronomía'),
                _filter(
                  'Actividad', 
                  FutureBuilder<List<Actividad>>(
                    future: actividades, builder: (context, snapshot) {
                      if (snapshot.hasError) print(snapshot.error); 
                      return snapshot.hasData ? 
                        MultiSelect(options: snapshot.data)
                      
                      : Center(child: CircularProgressIndicator()); 
                    },
                  ),
                ),
                _filter(
                  'Especialidad', 
                  FutureBuilder<List<Especialidad>>(
                    future: especialidades, builder: (context, snapshot) {
                      if (snapshot.hasError) print(snapshot.error); 
                      return snapshot.hasData ? 
                        MultiSelect(options: snapshot.data)
                      
                      : Center(child: CircularProgressIndicator()); 
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}