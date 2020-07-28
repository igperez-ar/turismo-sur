part of 'configuracion_bloc.dart';

abstract class ConfiguracionState extends Equatable {
  const ConfiguracionState();

  @override
  List<Object> get props => [];
}

class ConfiguracionInitial extends ConfiguracionState {}

class ConfiguracionFetching extends ConfiguracionState {}

class ConfiguracionSuccess extends ConfiguracionState {
  final Map<String, Object> config;

  const ConfiguracionSuccess(this.config); 

  @override
  List<Object> get props => [config];
}

class ConfiguracionFailure extends ConfiguracionState {}