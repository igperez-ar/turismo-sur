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

  EstablecimientosBloc({@required this.repository}) : assert(repository != null);

  @override
  EstablecimientosState get initialState => EstablecimientosInitial();

  @override
  Stream<EstablecimientosState> mapEventToState(
    EstablecimientosEvent event,
  ) async* {
    if (event is FetchEstablecimientos) {
      yield EstablecimientosFetching();
      try {
        final List<Alojamiento> alojamientos = await repository.fetchAlojamientos();
        final List<Gastronomico> gastronomicos = await repository.fetchGastronomicos();
        
        yield EstablecimientosSuccess(
          alojamientos: alojamientos,
          gastronomicos: gastronomicos
        );
      } catch (e) {
        print(e);
        yield EstablecimientosFailure();
      }
    }
  }
}
