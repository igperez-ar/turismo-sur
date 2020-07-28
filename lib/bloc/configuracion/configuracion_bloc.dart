import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:turismo_app/bloc/bloc.dart';

import 'package:turismo_app/models/models.dart';

part 'configuracion_event.dart';
part 'configuracion_state.dart';

class ConfiguracionBloc extends HydratedBloc<ConfiguracionEvent, ConfiguracionState> {

  @override
  ConfiguracionState get initialState {
    return super.initialState ?? ConfiguracionInitial();
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

    if (state is ConfiguracionSuccess){
      final MapEntry newEntry = event.config.entries.first;
      final settings = Map<String, Object>.from((state as ConfiguracionSuccess).config
        .map((key, value) {
          return (key == newEntry.key ? newEntry : MapEntry(key, value));
        })
      );

      yield ConfiguracionSuccess(settings);
    }
  } 
}
