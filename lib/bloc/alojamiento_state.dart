part of 'alojamiento_bloc.dart';

abstract class AlojamientoState extends Equatable {
  const AlojamientoState();

  @override
  List<Object> get props => [];
}

class AlojamientoInitial extends AlojamientoState {}

class AlojamientoFetching extends AlojamientoState {}

class AlojamientoSuccess extends AlojamientoState {
  final List<Alojamiento> alojamientos;

  const AlojamientoSuccess({@required this.alojamientos}) : assert(alojamientos != null);

  @override
  List<Object> get props => [alojamientos];
}

class AlojamientoFailure extends AlojamientoState {}