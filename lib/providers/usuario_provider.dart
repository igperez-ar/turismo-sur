import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:turismo_app/models/models.dart';
import 'package:turismo_app/providers/base_provider.dart';
import 'package:turismo_app/queries/queries.dart';

class GetUsuariosRequestFailure implements Exception {}

class UsuarioProvider {
    
  GraphQLClient _graphQLClient = BaseProvider.initailizeClient();

  Future<Usuario> getOne(String username) async {
    final result = await _graphQLClient.query(
      QueryOptions(
        documentNode: gql(QueryUsuario.getOne),
        fetchPolicy: FetchPolicy.networkOnly,
        variables: {
          'username': username
        }
      ),
    );
    
    if (result.hasException) {
      throw GetUsuariosRequestFailure();
    }
    final data = result.data['usuarios'] as List;
    
    if (data.isEmpty)
      return null;

    return Usuario.fromJson(data.first);
  }

  Future<Usuario> addUsuario(String nombre, String username, String password, String email) async {
    final result = await _graphQLClient.mutate(
      MutationOptions(
        documentNode: gql(QueryUsuario.addUsuario),
        variables: {
          'nombre': nombre,
          'username': username,
          'password': password,
          'email': email,
        }
      )
    );
    
    if (result.hasException) {
      throw GetUsuariosRequestFailure();
    }
    
    final data = result.data['insert_usuarios']['returning'] as List;
    return Usuario.fromJson(data.first);
  }

  Future<Usuario> updateUsuario(String username, Usuario newUser) async {
    final result = await _graphQLClient.mutate(
      MutationOptions(
        documentNode: gql(QueryUsuario.updateUsuario),
        variables: {
          'oldUsername': username,
          'nombre': newUser.nombre,
          'foto': newUser.foto,
          'descripcion': newUser.descripcion,
          'email': newUser.email,
          'newUsername': newUser.username,
          'password': newUser.password,
        }
      )
    );
    
    if (result.hasException) {
      throw GetUsuariosRequestFailure();
    }
    
    final data = result.data['update_usuarios']['returning'] as List;
    return Usuario.fromJson(data.first);
  }
}