import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:turismo_app/bloc/bloc.dart';

import 'package:turismo_app/models/models.dart';

part 'filtered_establecimientos_event.dart';
part 'filtered_establecimientos_state.dart';

class FilteredEstablecimientosBloc extends Bloc<FilteredEstablecimientosEvent, FilteredEstablecimientosState> {
  final EstablecimientosBloc establecimientosBloc;
  StreamSubscription establecimientosSubscription;

  FilteredEstablecimientosBloc({@required this.establecimientosBloc}) 
    : super(
        establecimientosBloc.state is EstablecimientosSuccess
          ? FilteredEstablecimientosSuccess(
              (establecimientosBloc.state as EstablecimientosSuccess).alojamientos,
              (establecimientosBloc.state as EstablecimientosSuccess).gastronomicos
            )
          : FilteredEstablecimientosFetching()
      ) {
    establecimientosSubscription = establecimientosBloc.listen((state) {
      if (state is EstablecimientosSuccess) {
        add(UpdateFilteredEstablecimientos(
          (establecimientosBloc.state as EstablecimientosSuccess).alojamientos,
          (establecimientosBloc.state as EstablecimientosSuccess).gastronomicos
        ));
      }
    });
  }

  /* @override
  FilteredEstablecimientosState get initialState {
    return establecimientosBloc.state is EstablecimientosSuccess
      ? FilteredEstablecimientosSuccess(
          (establecimientosBloc.state as EstablecimientosSuccess).alojamientos,
          (establecimientosBloc.state as EstablecimientosSuccess).gastronomicos,
        ) 
      : FilteredEstablecimientosFetching();
  } */


  Stream<FilteredEstablecimientosState> mapEventToState(
    FilteredEstablecimientosEvent event
  ) async* {
    /* if (event is FetchFilteredEstablecimientos) {
      yield* _mapFilteredEstablecimientosLoadedToState();
    } else  */if (event is UpdateFilteredEstablecimientos) {
      yield* _mapUpdateFilteredEstablecimientosToState(event);
    }
  }

  /* Stream<FilteredEstablecimientosState> _mapFilteredEstablecimientosLoadedToState(
  ) async* {
    yield FilteredEstablecimientosFetching();

    try {
      yield FilteredEstablecimientosSuccess([], []);
    } catch (e) {
      print(e);
      yield FilteredEstablecimientosFailure();
    }
  } */

  Stream<FilteredEstablecimientosState> _mapUpdateFilteredEstablecimientosToState(
    UpdateFilteredEstablecimientos event
  ) async* {

    if (state is FilteredEstablecimientosSuccess){
            
    }
  } 

  @override 
  Future<void> close() {
    establecimientosSubscription.cancel();
    return super.close();
  }
}
