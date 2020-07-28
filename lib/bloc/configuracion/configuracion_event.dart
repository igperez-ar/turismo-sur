part of 'configuracion_bloc.dart';

abstract class ConfiguracionEvent extends Equatable {
  const ConfiguracionEvent();
}

class FetchConfiguracion extends ConfiguracionEvent {
  const FetchConfiguracion();

  @override
  List<Object> get props => [];
}

class UpdateConfiguracion extends ConfiguracionEvent {
  final Map<String, Object> config;

  const UpdateConfiguracion(this.config);

  @override
  List<Object> get props => [config];
}
