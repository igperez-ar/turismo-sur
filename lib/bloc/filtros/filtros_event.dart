part of 'filtros_bloc.dart';

abstract class FiltrosEvent extends Equatable {
  const FiltrosEvent();
}

class EstablecimientosLoaded extends FiltrosEvent {
  const EstablecimientosLoaded();

  @override
  List<Object> get props => [];
}

class UpdateFiltrosActivos extends FiltrosEvent {
  final Map<String, Object> newFilters;

  const UpdateFiltrosActivos(this.newFilters);

  @override
  List<Object> get props => [this.newFilters];
}

class ResetFiltros extends FiltrosEvent {
  const ResetFiltros();

  @override
  List<Object> get props => [];
} 