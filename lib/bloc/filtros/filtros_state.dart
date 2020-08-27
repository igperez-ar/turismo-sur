part of 'filtros_bloc.dart';

abstract class FiltrosState extends Equatable {
  const FiltrosState();

  @override
  List<Object> get props => [];
}

class FiltrosInitial extends FiltrosState {}

class FiltrosLoading extends FiltrosState {}

class FiltrosSuccess extends FiltrosState {
  final Map<String,dynamic> filterData;
  final Map<String,dynamic> activeFilters;

  const FiltrosSuccess({
    this.filterData,
    this.activeFilters
  }); 

  @override
  List<Object> get props => [
    filterData,
    activeFilters
  ];
}

class FiltrosFailure extends FiltrosState {}