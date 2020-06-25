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

  const EstablecimientosSuccess({
    @required this.alojamientos,
    @required this.gastronomicos
  }); /* : assert(alojamientos != null); */

  @override
  List<Object> get props => [alojamientos, gastronomicos];
}

class EstablecimientosFailure extends EstablecimientosState {}