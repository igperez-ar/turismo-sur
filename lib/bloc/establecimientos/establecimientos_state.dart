part of 'establecimientos_bloc.dart';

abstract class EstablecimientosState extends Equatable {
  const EstablecimientosState();

  @override
  List<Object> get props => [];
}

class EstablecimientosInitial extends EstablecimientosState {}

class EstablecimientosFetching extends EstablecimientosState {}

class EstablecimientosSuccess extends EstablecimientosState {
  final List<Alojamiento> alojamientos;
  final List<Gastronomico> gastronomicos;
  final List<Alojamiento> filteredAlojamientos;
  final List<Gastronomico> filteredGastronomicos;
  final Map<String, Object> filterData;
  final Map<String, Object> activeFilters;

  const EstablecimientosSuccess({
    this.alojamientos,
    this.gastronomicos,
    this.filteredAlojamientos,
    this.filteredGastronomicos,
    this.filterData,
    this.activeFilters
  }); 

  @override
  List<Object> get props => [
    alojamientos,
    gastronomicos,
    filteredAlojamientos,
    filteredGastronomicos,
    filterData,
    activeFilters
  ];
}

class EstablecimientosFailure extends EstablecimientosState {}