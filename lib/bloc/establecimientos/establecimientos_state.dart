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

  const EstablecimientosSuccess({
    this.alojamientos,
    this.gastronomicos,
    this.filteredAlojamientos,
    this.filteredGastronomicos,
  }); 

  @override
  List<Object> get props => [
    alojamientos,
    gastronomicos,
    filteredAlojamientos,
    filteredGastronomicos,
  ];
}

class EstablecimientosFailure extends EstablecimientosState {}