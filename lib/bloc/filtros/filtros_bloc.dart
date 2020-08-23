import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:turismo_app/bloc/bloc.dart';
import 'package:turismo_app/bloc/filtered_establecimientos/filtered_establecimientos_bloc.dart';
import 'package:turismo_app/models/models.dart';

part 'filtros_event.dart';
part 'filtros_state.dart';

class FiltrosBloc extends Bloc<FiltrosEvent, FiltrosState> {
  final FilteredEstablecimientosBloc filteredEstablecimientosBloc;
  StreamSubscription establecimientosSubscription;

  FiltrosBloc({@required this.filteredEstablecimientosBloc}) : super(FiltrosInitial());

  Map<String, List> _getFilterData(
    List<Alojamiento> alojamientos, List<Gastronomico> gastronomicos
  ) {

    Map<String, List> filterData = {
      'localidades':     List<Localidad>(),
      'clasificaciones': List<Clasificacion>(),
      'categorias':      List<Categoria>(),
      'actividades':     List<Actividad>(),
      'especialidades':  List<Especialidad>(),
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

  Stream<FiltrosState> mapEventToState(
    FiltrosEvent event
  ) async* {
    if (event is FetchFiltros) {
      yield* _mapFiltrosLoadedToState();
    } /* else if (event is UpdateFiltrosActivos) {
      yield* _mapUpdateActiveFiltersToState(event);
    } */
  }

  Stream<FiltrosState> _mapFiltrosLoadedToState() async* {
    yield FiltrosFetching();

    if (filteredEstablecimientosBloc.state is FilteredEstablecimientosSuccess) {
      try {
        final filteredState = (filteredEstablecimientosBloc.state as FilteredEstablecimientosSuccess);
        final Map<String, Object> filterData = _getFilterData(filteredState.alojamientos, filteredState.gastronomicos);
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
          
        yield FiltrosSuccess(
          filterData: filterData,
          activeFilters: activeFilters
        );
      } catch (e) {
        print(e);
        yield FiltrosFailure();
      }
    }
  }

/*   Stream<FiltrosState> _mapUpdateActiveFiltersToState(
    UpdateFiltrosActivos event
  ) async* {

    if (state is FiltrosSuccess){
      final _state = (state as FiltrosSuccess);
      List<Alojamiento> _newAlojamientos;
      List<Gastronomico> _newGastronomicos;
      Map _filters = event.newFilters;

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

        yield FiltrosSuccess(
          filterData: _state.filterData,
          activeFilters: _filters
        );

      /* } catch (e) {
        print(e); */
        /* yield FiltrosFailure(); */
      /* } */
      
        
      
    }
  } 
 */
  @override 
  Future<void> close() {
    establecimientosSubscription.cancel();
    return super.close();
  }
}
