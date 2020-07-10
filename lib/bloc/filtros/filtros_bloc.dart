import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:turismo_app/bloc/bloc.dart';

import 'package:turismo_app/models/models.dart';

part 'filtros_event.dart';
part 'filtros_state.dart';

class FiltrosBloc extends Bloc<FiltrosEvent, FiltrosState> {
  final EstablecimientosBloc estBloc;
  StreamSubscription estSubscription;

  FiltrosBloc({@required this.estBloc}) {
    estSubscription = estBloc.listen((state) {
      if (state is EstablecimientosSuccess) {
        //add(TodosUpdated((todosBloc.state as TodosLoadSuccess).todos));
      }
    });
  }

  @override
  FiltrosState get initialState => FiltrosInitial();/*  {
    return estBloc.state is EstablecimientosSuccess
      ? 
      :
  }; */

  @override
  Stream<FiltrosState> mapEventToState(
    FiltrosEvent event,
  ) async* {
    if (event is FetchFiltros) {
      yield* _mapFetchFiltrosToState(event); 
    } else if (event is EstablecimientosUpdated) {
      yield* _mapUpdateEstablecimientosToState(event);
    }
      
    /*   yield FiltrosFetching();
      try {
        final List<Alojamiento> alojamientos = await repository.fetchAlojamientos();
        final List<Gastronomico> gastronomicos = await repository.fetchGastronomicos();
        
        yield FiltrosSuccess(
          alojamientos: alojamientos,
          gastronomicos: gastronomicos
        );
      } catch (e) {
        print(e);
        yield FiltrosFailure();
      }
    } */
  }

  Stream<FiltrosState> _mapFetchFiltrosToState( 
    FetchFiltros event,
  ) async* {
    
  }

  Stream<FiltrosState> _mapUpdateEstablecimientosToState( 
    EstablecimientosUpdated event,
  ) async* {

  }

  /* Stream<FiltrosState> _mapUpdateEstablecimientosToState( 
    FiltrosFetching event,
  ) async* {

  } */
}
