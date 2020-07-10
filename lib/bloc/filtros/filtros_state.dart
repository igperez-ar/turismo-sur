part of 'filtros_bloc.dart';

abstract class FiltrosState extends Equatable {
  const FiltrosState();

  @override
  List<Object> get props => [];
}

class FiltrosInitial extends FiltrosState {}

class FiltrosFetching extends FiltrosState {}

class FiltrosSuccess extends FiltrosState {
  final List<Alojamiento> filteredAlojamientos;
  final List<Gastronomico> filteredGastronomicos;

  const FiltrosSuccess({
    @required this.filteredAlojamientos,
    @required this.filteredGastronomicos
  });

  @override
  List<Object> get props => [filteredAlojamientos, filteredGastronomicos];
}

class FiltrosFailure extends FiltrosState {}