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

class AutenticacionBloc extends Bloc<AutenticacionEvent, AutenticacionState> with HydratedMixin {

  final UsuarioRepository repository;

  AutenticacionBloc({
    @required this.repository
  }) : super(AutenticacionInitial()) {
    hydrate();
  }

  @override
  AutenticacionState fromJson(Map<String,dynamic> json) {
    try {
      print('HydratedAutentication loaded!');
      final Usuario usuario = Usuario.fromJson(jsonDecode(json['Autenticacion']));
      return AutenticacionAuthenticated(usuario);
      
    } catch (_) {
      print(_);
      return null;
    }
  }

  @override
  Map<String,dynamic> toJson(AutenticacionState state) {
    if (state is AutenticacionAuthenticated) {
      print('HydratedAutentication saved!');
      return {'Autenticacion': jsonEncode(state.usuario.toJson())};

    } else {
      return null;
    }
  }


  Stream<AutenticacionState> mapEventToState(
    AutenticacionEvent event
  ) async* {
    if (event is AutenticacionLoggedIn) {
      yield* _mapLoggedInToState(event);
    } else if (event is AutenticacionLoggedOut) {
      yield* _mapLoggedOutToState(event);
    } else if (event is AutenticacionRegister) {
      yield* _mapRegisterToState(event);
    } else if (event is AutenticacionUpdate) {
      yield* _mapUpdateToState(event);
    } 
  }

  Stream<AutenticacionState> _mapLoggedInToState(
    AutenticacionLoggedIn event
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
    AutenticacionLoggedOut event
  ) async* {
    this.clear();
    yield AutenticacionInitial();
  }

  Stream<AutenticacionState> _mapRegisterToState(
    AutenticacionRegister event
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

  Stream<AutenticacionState> _mapUpdateToState(
    AutenticacionUpdate event
  ) async* {

    yield AutenticacionLoading();

    try {
      final Usuario usuario = await repository.updateUsuario(event.username, event.newUser);

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
