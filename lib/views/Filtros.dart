import 'package:flutter/material.dart';

class Filtros extends StatefulWidget {
  Filtros({Key key}) : super(key: key);

  @override
  _FiltrosState createState() => _FiltrosState();
}

class _FiltrosState extends State<Filtros> {
  String localidad = 'Todas';
  String categoria = 'Todas';
  RangeValues clasificacion = RangeValues(0, 5);
  String actividad = 'Todas';
  String especialidad = 'Todas';

  bool alojamientos = false;
  bool gastronomia = false;

  List<String> _filters = <String>[];

  List<String> _options = <String>[
      'Ushuaia',
      'Rio Grande',
      'Tolhuin',
      'Esquel',
      'Bahía Blanca',
 ];
 
  List<Widget> _optionWidgets() {
    List<Widget> _children = <Widget>[];

    for (String option in _options) {
      _children.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
          child: FilterChip(
            backgroundColor: Colors.white,
            elevation: 5,
            avatar: CircleAvatar(
              child: Text(option[0].toUpperCase()),
            ),
            label: Text(option),
            showCheckmark: false,
            selected: _filters.contains(option),
            onSelected: (bool selected) {
              setState(() {
                if (selected) {
                  _filters.add(option);
                } else {
                  _filters.removeWhere((String name) {
                    return name == option;
                  });
                }
              });
            },
          ),
        )
      );
    } 

    return _children;
  }

  Widget _dropdown(List<String> options, String _value, Function _onChanged) {
    final _width = MediaQuery.of(context).size.width;

    return Container(
      width: _width * 0.55,
      height: 40,
      padding: EdgeInsets.symmetric(horizontal: 15),
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 1,color: Colors.grey[400]),
        borderRadius: BorderRadius.all(Radius.circular(15))
      ),
      child: DropdownButton<String>(
        value: _value,
        isExpanded: true,
        underline: SizedBox(),
        icon: Icon(Icons.keyboard_arrow_down),
        iconSize: 30,
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: 16
        ),
        items: options.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(), 
        onChanged: _onChanged,
      )
    );
  }

  Widget _filter(String title, Widget _widget) {
    return (
      Padding(
        padding: EdgeInsets.only(top: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title, style: TextStyle(
                color: Colors.grey[700],
                fontWeight: FontWeight.bold,
                fontSize: 20
              ),
            ),
            _widget
          ],
        )
      )
    );
  }

  Widget _section(String title) {
    final _width = MediaQuery.of(context).size.width;

    return (
      Padding(
        padding: EdgeInsets.only(top: 10),
        child: Column(
          children: <Widget>[
            Text(title, style: TextStyle(
                color: Colors.grey[500],
                fontSize: 22,
                fontWeight: FontWeight.bold
              ),
            ),
            Divider(
              color: Colors.grey[500],
              thickness: 1.2,
              indent: _width * 0.15,
              endIndent: _width * 0.15,
            )
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
    final _width = MediaQuery.of(context).size.width;
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Filtros', 
          textAlign: TextAlign.center, 
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 30,), 
          onPressed: () => Navigator.pop(context)
        ),
        centerTitle: true,
        backgroundColor: Colors.teal[300],
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          children: <Widget>[ 
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text('Mostrar sólo', style: TextStyle(
                      color: Colors.grey[700],
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                    ),
                  )
                ),
                Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () => _changeShowOnly('alojamientos'),
                      child: Container(
                        width: _width * 0.45,
                        height: 40,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text('Alojamientos', style: TextStyle(
                              fontSize: 16
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[500],
                              blurRadius: 5,
                              spreadRadius: 0,
                              offset: Offset(2, 2),
                            )
                          ],
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(15), bottomLeft: Radius.circular(15)),
                          color: alojamientos ? Colors.grey[400] : Colors.white,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _changeShowOnly('gastronomia'),
                      child: Container(
                        width: _width * 0.45,
                        height: 40,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text('Gastronomía', style: TextStyle(
                              fontSize: 16
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[500],
                              blurRadius: 5,
                              spreadRadius: 0,
                              offset: Offset(2, 2),
                            )
                          ],
                          borderRadius: BorderRadius.only(topRight: Radius.circular(15), bottomRight: Radius.circular(15)),
                          color: gastronomia ? Colors.grey[400] : Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
                /* _filter(
                  'Localidad', 
                  _dropdown(
                    ['Todas', 'Ushuaia', 'Tolhuin', 'Rio Grande'],
                    localidad,
                    (String newValue) {setState(() {localidad = newValue;});}
                  )
                ), */
                _filter(
                  'Localidad', 
                  Wrap(
                    children: _optionWidgets()
                    ),
                ),
                _section('Alojamientos'),
                _filter(
                  'Categoría', 
                  _dropdown(
                    ['Todas', 'Ushuaia', 'Tolhuin', 'Rio Grande'],
                    categoria,
                    (String newValue) {setState(() {categoria = newValue;});}
                  )
                ),
                _filter(
                  'Clasificación',
                  RangeSlider(
                    values: clasificacion,
                    min: 0,
                    max: 5,
                    divisions: 5,
                    labels: RangeLabels(clasificacion.start.toString(), clasificacion.end.toString()),
                    onChanged: (RangeValues newValues) {
                      setState(() {
                        clasificacion = newValues;
                      });
                    },
                  )
                ),
                _section('Gastronomía'),
                _filter(
                  'Actividad', 
                  _dropdown(
                    ['Todas', 'Ushuaia', 'Tolhuin', 'Rio Grande'],
                    actividad,
                    (String newValue) {setState(() {actividad = newValue;});}
                  )
                ),
                _filter(
                  'Especialidad', 
                  _dropdown(
                    ['Todas', 'Ushuaia', 'Tolhuin', 'Rio Grande'],
                    especialidad,
                    (String newValue) {setState(() {especialidad = newValue;});}
                  )
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Color.fromRGBO(238, 238, 242, 1),
    );
  }
}