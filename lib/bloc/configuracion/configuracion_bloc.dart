import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'configuracion_event.dart';
part 'configuracion_state.dart';

class ConfiguracionBloc extends Bloc<ConfiguracionEvent, ConfiguracionState> with HydratedMixin {

  ConfiguracionBloc() : super(ConfiguracionInitial()) {
    hydrate();
  }

  @override
  ConfiguracionState fromJson(Map<String, dynamic> json) {
    try {
      print('HydratedSettings loaded!');
      final String config = json['configuracion'];
      return ConfiguracionSuccess(jsonDecode(config));
      
    } catch (_) {
      print(_);
      return null;
    }
  }

  @override
  Map<String,dynamic> toJson(ConfiguracionState state) {
    if (state is ConfiguracionSuccess) {
      print('HydratedSettings saved!');
      return {'configuracion': jsonEncode(state.config)};

    } else {
      return null;
    }
  }


  Stream<ConfiguracionState> mapEventToState(
    ConfiguracionEvent event
  ) async* {
    if (event is FetchConfiguracion) {
      yield* _mapConfiguracionLoadedToState();
    } else if (event is UpdateConfiguracion) {
      yield* _mapConfiguracionUpdatedToState(event);
    } 
  }

  Stream<ConfiguracionState> _mapConfiguracionLoadedToState() async* {
    yield ConfiguracionFetching();

    try {
      final Map<String, Object> config = {
        'splash-inicial': true,
        'dark-mode': false,
      };
        
      yield ConfiguracionSuccess(config);
    } catch (e) {
      print(e);
      yield ConfiguracionFailure();
    }
  }

  Stream<ConfiguracionState> _mapConfiguracionUpdatedToState(
    UpdateConfiguracion event
  ) async* {

    if (state is ConfiguracionSuccess) {
      final Map<String, Object> settings = Map.from((state as ConfiguracionSuccess).config);

      for (var entry in event.config.entries) {
        settings.update(entry.key, (value) => entry.value);
      }

      yield ConfiguracionSuccess(settings);
    }
  }
}
