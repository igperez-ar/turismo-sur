part of 'filtros_bloc.dart';

abstract class FiltrosEvent extends Equatable {
  const FiltrosEvent();
}

class FetchFiltros extends FiltrosEvent {
  const FetchFiltros();

  @override
  List<Object> get props => [];
}

class UpdateFiltrosActivos extends FiltrosEvent {
  final Map<String, Object> newFilters;

  const UpdateFiltrosActivos(this.newFilters);

  @override
  List<Object> get props => [newFilters];
}
