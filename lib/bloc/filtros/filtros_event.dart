part of 'filtros_bloc.dart';

abstract class FiltrosEvent extends Equatable {
  const FiltrosEvent();
}

class FetchFiltros extends FiltrosEvent {
  const FetchFiltros();

  @override
  List<Object> get props => [];
}

class EstablecimientosUpdated extends FiltrosEvent {
  const EstablecimientosUpdated();

  @override
  List<Object> get props => [];
}
