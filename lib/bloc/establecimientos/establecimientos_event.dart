part of 'establecimientos_bloc.dart';

abstract class EstablecimientosEvent extends Equatable {
  const EstablecimientosEvent();
}

class FetchEstablecimientos extends EstablecimientosEvent {
  const FetchEstablecimientos();

  @override
  List<Object> get props => [];
}

class UpdateFilteredEstablecimientos extends EstablecimientosEvent {
  final List<Alojamiento> newFilteredAlojamientos;
  final List<Gastronomico> newFilteredGastronomicos;

  const UpdateFilteredEstablecimientos(
    this.newFilteredAlojamientos,
    this.newFilteredGastronomicos
  );

  @override
  List<Object> get props => [
    this.newFilteredAlojamientos,
    this.newFilteredGastronomicos
  ];
}
