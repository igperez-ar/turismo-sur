part of 'filtered_establecimientos_bloc.dart';

abstract class FilteredEstablecimientosState extends Equatable {
  const FilteredEstablecimientosState();

  @override
  List<Object> get props => [];
}

/* class FilteredEstablecimientosInitial extends FilteredEstablecimientosState {} */

class FilteredEstablecimientosFetching extends FilteredEstablecimientosState {}

class FilteredEstablecimientosSuccess extends FilteredEstablecimientosState {
  final List<Alojamiento> alojamientos;
  final List<Gastronomico> gastronomicos;

  const FilteredEstablecimientosSuccess(
    this.alojamientos,
    this.gastronomicos
  ); 

  @override
  List<Object> get props => [
    alojamientos,
    gastronomicos
  ];
}

class FilteredEstablecimientosFailure extends FilteredEstablecimientosState {}