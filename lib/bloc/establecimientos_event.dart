part of 'establecimientos_bloc.dart';

abstract class EstablecimientosEvent extends Equatable {
  const EstablecimientosEvent();
}

class FetchEstablecimientos extends EstablecimientosEvent {
  const FetchEstablecimientos();

  @override
  List<Object> get props => [];
}
