import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:turismo_app/models/models.dart';
import 'package:turismo_app/repositories/repository.dart';

part 'alojamiento_event.dart';
part 'alojamiento_state.dart';

class AlojamientoBloc extends Bloc<AlojamientoEvent, AlojamientoState> {
  final AlojamientoRepository repository;

  AlojamientoBloc({@required this.repository}) : assert(repository != null);

  @override
  AlojamientoState get initialState => AlojamientoInitial();

  @override
  Stream<AlojamientoState> mapEventToState(
    AlojamientoEvent event,
  ) async* {
    if (event is FetchAlojamientos) {
      yield AlojamientoFetching();
      try {
        final List<Alojamiento> alojamientos = await repository.fetchAlojamientos();
        yield AlojamientoSuccess(alojamientos: alojamientos);
      } catch (_) {
        yield AlojamientoFailure();
      }
    }
  }
}
