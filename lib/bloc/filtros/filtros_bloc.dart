import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:turismo_app/bloc/bloc.dart';
import 'package:turismo_app/models/models.dart';

part 'filtros_event.dart';
part 'filtros_state.dart';

class FiltrosBloc extends Bloc<FiltrosEvent, FiltrosState> {
  final EstablecimientosBloc establecimientosBloc;
  final FavoritosBloc favoritosBloc;
  StreamSubscription establecimientosSubscription;

  FiltrosBloc({@required this.establecimientosBloc, @required this.favoritosBloc}) 
    : super(initialState(establecimientosBloc.state)) {
      establecimientosSubscription = establecimientosBloc.listen((_state) { 
        if (this.state is FiltrosInitial && _state is EstablecimientosSuccess) {
          add(EstablecimientosLoaded());
        }
      });
  }

  static FiltrosState initialState(EstablecimientosState _state) {

    if (_state is EstablecimientosSuccess) {
      final _filterData = _getFilterData(
        _state.alojamientos, 
        _state.gastronomicos, 
      );
      return FiltrosSuccess(
        filterData: _filterData,
        activeFilters: {
          'filtrados': {
            'establecimientos': 0,
            'favoritos': 0
          },
          'palabras': List<String>(),
          'mostrar': Establecimiento.ambos,
          'localidades': List<Localidad>(),
          'clasificaciones': List<Clasificacion>(),
          'categorias': List<Categoria>.from(_filterData['categorias']),
          'actividades': List<Actividad>(),
          'especialidades': List<Especialidad>()
        }
      );
    }

    if (_state is EstablecimientosFailure) {
      return FiltrosFailure();
    }

    return FiltrosInitial();
  }

  static Map<String, List> _getFilterData(
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
    if (event is EstablecimientosLoaded) {
      yield* _mapFiltrosLoadedToState();
    } else if (event is UpdateFiltrosActivos) {
      yield* _mapUpdateActiveFiltersToState(event);
    } else if (event is ResetFiltros) {
      yield* _mapFiltrosResetToState();
    }
  }

  Stream<FiltrosState> _mapFiltrosLoadedToState() async* {

    yield FiltrosLoading();

    if (establecimientosBloc.state is EstablecimientosSuccess) {
      final establecimientoState = (establecimientosBloc.state as EstablecimientosSuccess);
      final Map<String, Object> filterData = _getFilterData(
        establecimientoState.alojamientos, 
        establecimientoState.gastronomicos
      );
      final Map<String, Object> activeFilters = {
        'filtrados': {
          'establecimientos': 0,
          'favoritos': 0
        },
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
    }
  }

  Stream<FiltrosState> _mapUpdateActiveFiltersToState(
    UpdateFiltrosActivos event
  ) async* {

    yield FiltrosLoading();

    if (state is FiltrosSuccess && establecimientosBloc.state is EstablecimientosSuccess){
      final filtrosState = (state as FiltrosSuccess);
      final favoritoState = (favoritosBloc.state);
      final establecimientosState = (establecimientosBloc.state as EstablecimientosSuccess);
      List<Alojamiento> newAlojamientos;
      List<Gastronomico> newGastronomicos;
      Map newFilters = event.newFilters;

      if ( newFilters['mostrar'] == Establecimiento.alojamiento ||
           newFilters['mostrar'] == Establecimiento.ambos ){
        newAlojamientos = establecimientosState
          .alojamientos
          .where((element) => (
              (newFilters['clasificaciones'].isNotEmpty 
                ? newFilters['clasificaciones'].contains(element.clasificacion)
                : true
              )
            &&(newFilters['categorias'].isNotEmpty 
                ? newFilters['categorias'].contains(element.categoria)
                : true
              )
            &&(newFilters['localidades'].isNotEmpty
                ? newFilters['localidades'].contains(element.localidad)
                : true
              )
            &&(newFilters['palabras'].isNotEmpty
                ? newFilters['palabras'].any(
                  (word) => (element.nombre
                      .toLowerCase()
                      .contains(word.toLowerCase()))
                  )
                : true
              )
          ))
          .toList();
      } else {
        newAlojamientos = [];
      }

      if ( newFilters['mostrar'] == Establecimiento.gastronomico || 
           newFilters['mostrar'] == Establecimiento.ambos){
        newGastronomicos = establecimientosState
          .gastronomicos
          .where((element) => (
              (newFilters['actividades'].isNotEmpty 
                ? newFilters['actividades'].any((act) => element.actividades.contains(act)) 
                : true
              )
            &&(newFilters['especialidades'].isNotEmpty
                ? newFilters['especialidades'].any((esp) => element.especialidades.contains(esp))
                : true
              )
            &&(newFilters['localidades'].isNotEmpty
                ? newFilters['localidades'].contains(element.localidad)
                : true
              )
            &&(newFilters['palabras'].isNotEmpty
                ? newFilters['palabras'].any(
                    (word) => (word
                      .toString()
                      .toLowerCase()
                      .contains(element.nombre.toLowerCase())))
                : true
              )
          ))
          .toList();
      } else {
        newGastronomicos = [];
      }

      newFilters['filtrados']['establecimientos'] = (
        establecimientosState.alojamientos.length + 
        establecimientosState.gastronomicos.length
      ) - (newAlojamientos.length + newGastronomicos.length);

      if (favoritoState is FavoritosSuccess) {
        final int newCount = favoritoState.favoritos
          .where((element) {
            if (element.tipo == Establecimiento.alojamiento 
             && newAlojamientos.any((e) => e.id == element.id)) 
              return true;

            if (element.tipo == Establecimiento.gastronomico 
             && newGastronomicos.any((e) => e.id == element.id))
              return true;

            return false;
          })
          .toList()
          .length;
        newFilters['filtrados']['favoritos'] = favoritoState.favoritos.length - newCount; 

      } else {
        newFilters['filtrados']['favoritos'] = 0;
      }

      establecimientosBloc.add(
        UpdateFilteredEstablecimientos(
          newAlojamientos, 
          newGastronomicos
        )
      );

      yield FiltrosSuccess(
        filterData: filtrosState.filterData,
        activeFilters: newFilters
      );
    }
  } 

  Stream<FiltrosState> _mapFiltrosResetToState() async* {

    if (state is FiltrosSuccess) {
      final _state = (state as FiltrosSuccess);
      final Map<String, Object> resetActiveFilters = {
        'filtrados': {
          'establecimientos': 0,
          'favoritos': 0
        },
        'palabras': List<String>(),
        'mostrar': Establecimiento.ambos,
        'localidades': List<Localidad>(),
        'clasificaciones': List<Clasificacion>(),
        'categorias': List<Categoria>.from(_state.filterData['categorias']),
        'actividades': List<Actividad>(),
        'especialidades': List<Especialidad>()
      }; 

      this.add(UpdateFiltrosActivos(resetActiveFilters));
    }
  }  

  @override 
  Future<void> close() {
    establecimientosSubscription.cancel();
    return super.close();
  }
}
