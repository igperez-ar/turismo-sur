import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:turismo_app/bloc/bloc.dart';

import 'package:turismo_app/models/models.dart';
import 'package:turismo_app/repositories/repository.dart';

part 'establecimientos_event.dart';
part 'establecimientos_state.dart';

class EstablecimientosBloc extends Bloc<EstablecimientosEvent, EstablecimientosState> {
  final EstablecimientosRepository repository;

  EstablecimientosBloc({@required this.repository}) : assert(repository != null);

  @override
  EstablecimientosState get initialState => EstablecimientosInitial();

  Map<String, List> _getFilterData(
    List<Alojamiento> alojamientos, List<Gastronomico> gastronomicos
  ) {

    Map<String, List> filterData = {
      'localidades': List<Localidad>(),
      'clasificaciones': List<Clasificacion>(),
      'categorias': List<Categoria>(),
      'actividades': List<Actividad>(),
      'especialidades': List<Especialidad>(),
    };

    alojamientos.forEach((e) { 
      if (e.localidad != null && !filterData['localidades'].contains(e.localidad))
        filterData['localidades'].add(e.localidad);

      if (e.clasificacion != null && !filterData['clasificaciones'].contains(e.clasificacion))
        filterData['clasificaciones'].add(e.clasificacion);

      if (e.categoria != null && !filterData['categorias'].contains(e.categoria))
        filterData['categorias'].add(e.categoria);
    });
    
    gastronomicos.forEach((e) {
      if (e.localidad != null && !filterData['localidades'].contains(e.localidad))
        filterData['localidades'].add(e.localidad);
      
      e.especialidades.forEach((element) {
        if (element != null && !filterData['especialidades'].contains(element))
          filterData['especialidades'].add(element);
      });

      e.actividades.forEach((element) {
        if (element != null && !filterData['actividades'].contains(element))
          filterData['actividades'].add(element);
      });
    });

    return filterData;
  }

  Stream<EstablecimientosState> mapEventToState(
    EstablecimientosEvent event
  ) async* {
    if (event is FetchEstablecimientos) {
      yield* _mapEstablecimientosLoadedToState();
    } else if (event is FilterEstablecimientos) {
      yield* _mapEstablecimientoFilteredToState(event);
    } /* else if (event is TodoUpdated) {
      yield* _mapTodoUpdatedToState(event);
    } else if (event is TodoDeleted) {
      yield* _mapTodoDeletedToState(event);
    } else if (event is ToggleAll) {
      yield* _mapToggleAllToState();
    } else if (event is ClearCompleted) {
      yield* _mapClearCompletedToState();
    } */
  }

  Stream<EstablecimientosState> _mapEstablecimientosLoadedToState() async* {
    yield EstablecimientosFetching();

    try {
      final List<Alojamiento> alojamientos = await repository.fetchAlojamientos();
      final List<Gastronomico> gastronomicos = await repository.fetchGastronomicos();
      final List<Alojamiento> filteredAlojamientos = alojamientos;
      final List<Gastronomico> filteredGastronomicos = gastronomicos;
      final Map<String, Object> filterData = _getFilterData(alojamientos, gastronomicos);
      final Map<String, Object> activeFilters = {
        'filtrados': 0,
        'palabras': List<String>(),
        'mostrar': Establecimiento.ambos,
        'localidades': List<Localidad>(),
        'clasificaciones': List<Clasificacion>(),
        'categorias': List<Categoria>.from(filterData['categorias']),
        'actividades': List<Actividad>(),
        'especialidades': List<Especialidad>()
      };
        
      yield EstablecimientosSuccess(
        alojamientos: alojamientos,
        gastronomicos: gastronomicos,
        filteredAlojamientos: filteredAlojamientos,
        filteredGastronomicos: filteredGastronomicos,
        filterData: filterData,
        activeFilters: activeFilters
      );
    } catch (e) {
      print(e);
      yield EstablecimientosFailure();
    }
  }

  Stream<EstablecimientosState> _mapEstablecimientoFilteredToState(
    FilterEstablecimientos event
  ) async* {

    if (state is EstablecimientosSuccess){
      final _state = (state as EstablecimientosSuccess);
      List<Alojamiento> _newAlojamientos;
      List<Gastronomico> _newGastronomicos;
      Map _filters = event.filters;

      /* try { */
        if ( _filters['mostrar'] == Establecimiento.alojamiento ||
             _filters['mostrar'] == Establecimiento.ambos ){
          _newAlojamientos = _state
            .alojamientos
            .where((element) => (
                (_filters['clasificaciones'].isNotEmpty 
                  ? _filters['clasificaciones'].contains(element.clasificacion)
                  : true
                )
              &&(_filters['categorias'].isNotEmpty 
                  ? _filters['categorias'].contains(element.categoria)
                  : true
                )
              &&(_filters['localidades'].isNotEmpty
                  ? _filters['localidades'].contains(element.localidad)
                  : true
                )
              &&(_filters['palabras'].isNotEmpty
                  ? _filters['palabras'].any(
                    (word) => (element.nombre
                        .toLowerCase()
                        .contains(word.toLowerCase()))
                    )
                  : true
                )
            ))
            .toList();
        } else {
          _newAlojamientos = [];
        }

        if ( _filters['mostrar'] == Establecimiento.gastronomico || 
             _filters['mostrar'] == Establecimiento.ambos){
          _newGastronomicos = _state
            .gastronomicos
            .where((element) => (
                (_filters['actividades'].isNotEmpty 
                  ? _filters['actividades'].any((act) => element.actividades.contains(act)) 
                  : true
                )
              &&(_filters['especialidades'].isNotEmpty
                  ? _filters['especialidades'].any((esp) => element.especialidades.contains(esp))
                  : true
                )
              &&(_filters['localidades'].isNotEmpty
                  ? _filters['localidades'].contains(element.localidad)
                  : true
                )
              &&(_filters['palabras'].isNotEmpty
                  ? _filters['palabras'].any(
                      (word) => (word
                        .toString()
                        .toLowerCase()
                        .contains(element.nombre.toLowerCase())))
                  : true
                )
            ))
            .toList();
        } else {
          _newGastronomicos = [];
        }

        _filters['filtrados'] = (_state.alojamientos.length + _state.gastronomicos.length)
                              - (_newAlojamientos.length + _newGastronomicos.length);

        yield EstablecimientosSuccess(
          alojamientos: _state.alojamientos,
          gastronomicos: _state.gastronomicos,
          filterData: _state.filterData,
          filteredAlojamientos: _newAlojamientos,
          filteredGastronomicos: _newGastronomicos,
          activeFilters: _filters
        );

      /* } catch (e) {
        print(e); */
        /* yield EstablecimientosFailure(); */
      /* } */
      
        
      
    }
  } 
}
