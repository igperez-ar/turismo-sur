import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:turismo_app/models/models.dart';
import 'package:turismo_app/repositories/usuario_repository.dart';

part 'autenticacion_event.dart';
part 'autenticacion_state.dart';

class AutenticacionBloc extends Bloc<AutenticacionEvent, AutenticacionState> /* with HydratedMixin */ {

  final UsuarioRepository repository;

  AutenticacionBloc({
    @required this.repository
  }) : super(AutenticacionInitial()); /* {
    hydrate();
  } */

  /* @override
  AutenticacionState fromJson(Map<String, dynamic> json) {
    try {
      print('HydratedSettings loaded!');
      final String config = json['Autenticacion'];
      return AutenticacionSuccess(jsonDecode(config));
      
    } catch (_) {
      print(_);
      return null;
    }
  }

  @override
  Map<String,dynamic> toJson(AutenticacionState state) {
    if (state is AutenticacionSuccess) {
      print('HydratedSettings saved!');
      return {'Autenticacion': jsonEncode(state.config)};

    } else {
      return null;
    }
  } */


  Stream<AutenticacionState> mapEventToState(
    AutenticacionEvent event
  ) async* {
    if (event is LoggedIn) {
      yield* _mapLoggedInToState(event);
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState(event);
    } else if (event is Register) {
      yield* _mapRegisterToState(event);
    } 
  }

  Stream<AutenticacionState> _mapLoggedInToState(
    LoggedIn event
  ) async* {

    yield AutenticacionLoading();

    try {
      final Usuario usuario = await repository.getOne(event.username);
        
      if (usuario != null && usuario.password == event.password) {
        print('Successful autentication! Welcome back ${event.username}');
        yield AutenticacionAuthenticated(usuario);

      } else {
        yield AutenticacionUnauthenticated('Las datos ingresados son incorrectos.');
      }

    } catch (e) {
      print(e);
      yield AutenticacionUnauthenticated('Ocurrió un error inesperado.');
    }
  }

  Stream<AutenticacionState> _mapLoggedOutToState(
    LoggedOut event
  ) async* {

    yield AutenticacionInitial();
  }

  Stream<AutenticacionState> _mapRegisterToState(
    Register event
  ) async* {

    yield AutenticacionLoading();

    try {
      final Usuario usuario = await repository.addUsuario(event.nombre, event.username, event.password, event.email);

      if (usuario == null) { 
        throw Exception();
      
      } else {
        yield AutenticacionAuthenticated(usuario);
      }

    } catch (e) {
      print(e);
      yield AutenticacionUnauthenticated('Ocurrió un error inesperado');
    }
  }
}
