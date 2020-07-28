part of 'establecimientos_bloc.dart';

abstract class EstablecimientosEvent extends Equatable {
  const EstablecimientosEvent();
}

class FetchEstablecimientos extends EstablecimientosEvent {
  const FetchEstablecimientos();

  @override
  List<Object> get props => [];
}

class FilterEstablecimientos extends EstablecimientosEvent {
  final Map<String, Object> filters;

  const FilterEstablecimientos(this.filters);

  @override
  List<Object> get props => [filters];
}

class ResetFiltros extends EstablecimientosEvent {
  const ResetFiltros();

  @override
  List<Object> get props => [];
}
