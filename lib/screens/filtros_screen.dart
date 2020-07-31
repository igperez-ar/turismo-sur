import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:turismo_app/bloc/bloc.dart';
import 'package:turismo_app/models/models.dart';
import 'package:turismo_app/components/components.dart';
import 'package:turismo_app/screens/favoritos_screen.dart';


class FiltrosScreen extends StatefulWidget {
  FiltrosScreen({Key key}) : super(key: key);

  @override
  _FiltrosScreenState createState() => _FiltrosScreenState();
}

class _FiltrosScreenState extends State<FiltrosScreen> {
  EstablecimientosBloc _establecimientoBloc;
  RangeValues _categorias;
  Categoria _especial; 

  Map _activeFilters;
  Map<String, List> _filterData = {};

  @override 
  void initState() {
    super.initState();

    _establecimientoBloc = BlocProvider.of<EstablecimientosBloc>(context);

    if (_establecimientoBloc.state is EstablecimientosSuccess) {
      final List<Categoria> values = (_establecimientoBloc.state as EstablecimientosSuccess).activeFilters['categorias'];
      _categorias = RangeValues(
        values
          .where((e) => e.id != 6)
          .map((e) => e.valor.toDouble())
          .reduce((curr, next) => curr <= next ? curr : next), 
        values
          .where((e) => e.id != 6)
          .map((e) => e.valor.toDouble())
          .reduce((curr, next) => curr >= next ? curr : next)
      );
    }
  }
  
  List<Widget> _getChipsWidgets(items) {
    return items.map<Widget>((item) => ChipWidget(
      pressed: _activeFilters['localidades'].contains(item), 
      title: item.nombre, 
      onPress: (bool pressed) {
          setState(() {
            if (!pressed) {
              _activeFilters['localidades'].add(item);
            } else {
              _activeFilters['localidades'].remove(item);
            }
          });
        }
      )
    ).toList();
  }
  

  Widget _filter(String title, Widget _widget) {
    return (
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container (
            margin: EdgeInsets.only(bottom: 10),
            child: Text(title, style: TextStyle(
              color: Theme.of(context).textTheme.headline2.color,
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
                color: Theme.of(context).textTheme.headline2.color,
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

  void _changeShowOnly(Establecimiento option) {
    setState(() {
      if (option == _activeFilters['mostrar']) {
        _activeFilters['mostrar'] = Establecimiento.ambos;

      } else if (option == Establecimiento.alojamiento) {
        _activeFilters['mostrar'] = Establecimiento.alojamiento;

      } else if (option == Establecimiento.gastronomico) {
        _activeFilters['mostrar'] = Establecimiento.gastronomico;
      }
    });
  }

  Widget _renderContent() {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      children: <Widget>[ 
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _section('general'),
            SearchBar(
              words: _activeFilters['palabras'],
            ),
            SizedBox(height: 30),
            _filter('Mostrar sólo', 
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButtonWidget(
                    onPress: () => _changeShowOnly(Establecimiento.alojamiento), 
                    title: "Alojamientos",
                    pressed: _activeFilters['mostrar'] == Establecimiento.alojamiento,
                  ),
                  FlatButtonWidget(
                    onPress: () => _changeShowOnly(Establecimiento.gastronomico), 
                    title: "Gastronomía",
                    pressed: _activeFilters['mostrar'] == Establecimiento.gastronomico,
                  )
                ],
              )
            ),
            _filter(
              'Localidad', 
              Wrap(
                runSpacing: 10,
                spacing: 10,
                children: _getChipsWidgets(_filterData['localidades'])
              )
            ),
            SizedBox(height: 30),
            _section('alojamientos'),
            _filter(
              'Categoría', 
              Column(
                children: <Widget>[
                  RangeSlider(
                    values: _categorias,
                    activeColor: Colors.teal,
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
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_activeFilters['categorias'].contains(_especial))
                            _activeFilters['categorias'].remove(_especial);
                          else
                            _activeFilters['categorias'].add(_especial);
                        });
                      },
                      child: Row(
                        children: <Widget>[
                          Checkbox(
                            value: _activeFilters['categorias'].contains(_especial), 
                            onChanged: (value) {
                              setState(() {
                                if (_activeFilters['categorias'].contains(_especial))
                                  _activeFilters['categorias'].remove(_especial);
                                else
                                  _activeFilters['categorias'].add(_especial);
                              });
                            },
                            activeColor: Colors.teal,
                          ),
                          Text(_especial.nombre)
                        ],
                      )
                    )
                  )
                ]
              )
            ),
            _filter(
              'Clasificación',
              MultiSelect(
                options: _filterData['clasificaciones'],
                selected: _activeFilters['clasificaciones']
              )
            ),
            SizedBox(height: 30),
            _section('Gastronomía'),
            _filter(
              'Actividad', 
              MultiSelect(
                options: _filterData['actividades'],
                selected: _activeFilters['actividades']
              )
            ),
            _filter(
              'Especialidad', 
              MultiSelect(
                options: _filterData['especialidades'],
                selected: _activeFilters['especialidades']
              )
            ),
          ],
        ),
      ],
    );
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
          onPressed: () { 
            final _esp = _activeFilters['categorias'].contains(_especial);

            _activeFilters['categorias'] = _filterData['categorias']
              .where((element) => element.valor >= _categorias.start.round()
                               && element.valor <= _categorias.end.round())
              .toList();

            if (_esp)
              _activeFilters['categorias'].add(_especial);
            
            _establecimientoBloc.add(FilterEstablecimientos(_activeFilters));
            Navigator.pop(context);
          }
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('RESET', style: TextStyle(
                color: Colors.white,
                fontSize: 18
              ),
              textAlign: TextAlign.center,
            ),
            onPressed: () {
              _establecimientoBloc.add(ResetFiltros());
              Navigator.pop(context);
            }
          ),
        ],
      ),
      body: BlocBuilder<EstablecimientosBloc, EstablecimientosState>(
        builder: (context, state) {
          
          if (state is EstablecimientosInitial) {
            _establecimientoBloc.add(FetchEstablecimientos());
          }

          if (state is EstablecimientosFailure) {
            return EmptyWidget(
              title: 'Ocurrió un problema inesperado. Intenta nuevamente más tarde.',
              uri: 'assets/images/undraw_server_down.svg',
            );
          }

          if (state is EstablecimientosSuccess) {
            _activeFilters = state.activeFilters;
            _filterData = state.filterData;
            _especial = _filterData['categorias'].firstWhere((element) => element.id == 6);
            
            return _renderContent();
          }
        
          return Center(
            child: CircularProgressIndicator()
          ); 
        }
      ),
    );
  }
}