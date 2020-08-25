import 'dart:async';

import 'package:turismo_app/providers/providers.dart';
import 'package:turismo_app/models/models.dart';

class UsuarioRepository {
  
  final UsuarioProvider _provider = UsuarioProvider();

  Future<Usuario> getOne(String username) async {
    return await _provider.getOne(username);
  }

  Future<Usuario> addUsuario(String nombre, String username, String password, String email) async {
    return await _provider.addUsuario(nombre, username, password, email);
  }

  Future<Usuario> updateUsuario(String username, Usuario newUser) async {
    return await _provider.updateUsuario(username, newUser);
  }
}