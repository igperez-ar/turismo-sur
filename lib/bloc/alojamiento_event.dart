part of 'alojamiento_bloc.dart';

abstract class AlojamientoEvent extends Equatable {
  const AlojamientoEvent();
}

class FetchAlojamientos extends AlojamientoEvent {
  const FetchAlojamientos();

  @override
  List<Object> get props => [];
}
