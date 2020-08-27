import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:turismo_app/bloc/bloc.dart';
import 'package:turismo_app/bloc/filtros/filtros_bloc.dart';
import 'package:turismo_app/models/models.dart';
import 'package:turismo_app/widgets/widgets.dart';


class FiltrosScreen extends StatefulWidget {

  /* final bool onFilter;

  const FiltrosScreen({
    Key key,
    this.onFilter,
  }) : super(key: key); */


  @override
  _FiltrosScreenState createState() => _FiltrosScreenState();
}

class _FiltrosScreenState extends State<FiltrosScreen> {
  FiltrosBloc _filtrosBloc;
  RangeValues _categorias;
  RangeValues _selectedCategorias;
  StreamSubscription _filtrosListener;
  Categoria _especial; 

  Map _activeFilters;
  Map<String, List> _filterData = {};
  

  @override 
  void initState() {
    super.initState();
    _filtrosBloc = BlocProvider.of<FiltrosBloc>(context);
  }

  @override 
  void dispose() {
    if (_filtrosListener != null) {
      _filtrosListener.cancel();
    }
    super.dispose();
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
                    values: _selectedCategorias ?? _categorias,
                    activeColor: Colors.teal,
                    min: 1,
                    max: 5,
                    divisions: 4,
                    labels: RangeLabels(
                      (_selectedCategorias ?? _categorias).start.ceil().toString(), 
                      (_selectedCategorias ?? _categorias).end.ceil().toString()),
                    onChanged: (RangeValues newValues) {
                      setState(() {
                        _selectedCategorias = newValues;
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
    
    return BlocBuilder<FiltrosBloc, FiltrosState>(
      builder: (context, state) {

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
                final Map<String,dynamic> arguments = ModalRoute.of(context).settings.arguments;
                final _esp = _activeFilters['categorias'].contains(_especial);

                _activeFilters['categorias'] = _filterData['categorias']
                  .where((element) => element.valor >= (_selectedCategorias ?? _categorias).start.round()
                                   && element.valor <= (_selectedCategorias ?? _categorias).end.round())
                  .toList();

                if (_esp)
                  _activeFilters['categorias'].add(_especial);
                
                _filtrosBloc.add(UpdateFiltrosActivos(_activeFilters));

                _filtrosListener = _filtrosBloc.listen((_state) {
                  if (_state is FiltrosSuccess) {
                    final bool favoritos = arguments['favoritos'];
                    final int estfiltrados = _state.activeFilters['filtrados']['establecimientos'];
                    final int favfiltrados = _state.activeFilters['filtrados']['favoritos'];
                    
                    if (favoritos ?? false) {
                      if (favfiltrados > 0)
                        SnackBarWidget.show(
                          arguments['scaffoldKey'], 
                          (favfiltrados == 1 
                            ? 'Se filtró 1 favorito.' 
                            : 'Se filtraron $favfiltrados favoritos.'
                          ), 
                          SnackType.success,
                          persistent: false
                        );
                      else 
                        arguments['scaffoldKey'].currentState.hideCurrentSnackBar();

                    } else { 
                      if (estfiltrados > 0) 
                        SnackBarWidget.show(
                          arguments['scaffoldKey'], 
                          (estfiltrados == 1 
                            ? 'Se filtró 1 establecimiento.' 
                            : 'Se filtraron $estfiltrados establecimientos.'
                          ), 
                          SnackType.success,
                          persistent: false
                        );
                      else
                        arguments['scaffoldKey'].currentState.hideCurrentSnackBar();
                    }
                    Navigator.pop(context);
                  } 
                });
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
                  _filtrosBloc.add(ResetFiltros());
                  final Map<String,dynamic> arguments = ModalRoute.of(context).settings.arguments;
                  arguments['scaffoldKey'].currentState.hideCurrentSnackBar();
                  Navigator.pop(context);
                }
              ),
            ],
          ),
          body: Builder( 
            builder: (context) {
              
              if (state is FiltrosFailure) {
                return EmptyWidget(
                  title: 'Ocurrió un problema inesperado. Intenta nuevamente más tarde.',
                  uri: 'assets/images/undraw_server_down.svg',
                );
              }

              if (state is FiltrosSuccess) {
                _activeFilters = state.activeFilters;
                final List<double> _values = (_activeFilters['categorias'] as List<Categoria>)
                  .where((element) => element.id != 6)
                  .map((e) => e.valor.toDouble())
                  .toList();
                _values.sort();

                _categorias = RangeValues(
                  _values.first,
                  _values.last
                );
                _filterData = state.filterData;
                _especial = _filterData['categorias'].firstWhere((element) => element.id == 6);
                
                return _renderContent();
              }
            
              return Center(
                child: CircularProgressIndicator()
              ); 
            }
          )
        );
      }
    );
  }
}