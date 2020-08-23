part of 'filtered_establecimientos_bloc.dart';

abstract class FilteredEstablecimientosEvent extends Equatable {
  const FilteredEstablecimientosEvent();
}

/* class FetchFilteredEstablecimientos extends FilteredEstablecimientosEvent {
  const FetchFilteredEstablecimientos();

  @override
  List<Object> get props => [];
} */

class UpdateFilteredEstablecimientos extends FilteredEstablecimientosEvent {
  final List<Alojamiento> newAlojamientos;
  final List<Gastronomico> newGastronomicos;

  const UpdateFilteredEstablecimientos(
    this.newAlojamientos,
    this.newGastronomicos
  );

  @override
  List<Object> get props => [
    newAlojamientos,
    newGastronomicos
  ];
}
