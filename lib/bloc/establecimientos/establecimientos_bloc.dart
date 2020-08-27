import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:turismo_app/models/models.dart';
import 'package:turismo_app/repositories/repository.dart';

part 'establecimientos_event.dart';
part 'establecimientos_state.dart';

class EstablecimientosBloc extends Bloc<EstablecimientosEvent, EstablecimientosState> {
  final EstablecimientosRepository repository;

  EstablecimientosBloc({@required this.repository}) : super(EstablecimientosInitial());

  Stream<EstablecimientosState> mapEventToState(
    EstablecimientosEvent event
  ) async* {

    if (event is FetchEstablecimientos) {
      yield* _mapEstablecimientosLoadedToState();
    } else if (event is UpdateFilteredEstablecimientos) {
      yield* _mapEstablecimientoFilteredToState(event);
    }
  }

  Stream<EstablecimientosState> _mapEstablecimientosLoadedToState() async* {
    yield EstablecimientosFetching();

    try {
      final List<Alojamiento> alojamientos = await repository.fetchAlojamientos();
      final List<Gastronomico> gastronomicos = await repository.fetchGastronomicos();
      final List<Alojamiento> filteredAlojamientos = alojamientos;
      final List<Gastronomico> filteredGastronomicos = gastronomicos;
        
      yield EstablecimientosSuccess(
        alojamientos: alojamientos,
        gastronomicos: gastronomicos,
        filteredAlojamientos: filteredAlojamientos,
        filteredGastronomicos: filteredGastronomicos,
      );
    } catch (e) {
      print(e);
      yield EstablecimientosFailure();
    }
  }

  Stream<EstablecimientosState> _mapEstablecimientoFilteredToState(
    UpdateFilteredEstablecimientos event
  ) async* {

    if (state is EstablecimientosSuccess) {
      final successState = (state as EstablecimientosSuccess);
      yield EstablecimientosSuccess(
        alojamientos: successState.alojamientos,
        gastronomicos: successState.gastronomicos,
        filteredAlojamientos: event.newFilteredAlojamientos,
        filteredGastronomicos: event.newFilteredGastronomicos
      );
    }
  }
}
