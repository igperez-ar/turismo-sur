import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:turismo_app/models/models.dart';
import 'package:turismo_app/providers/base_provider.dart';
import 'package:turismo_app/queries/queries.dart';

class GetUsuariosRequestFailure implements Exception {}

class UsuarioProvider {
    
  GraphQLClient _graphQLClient = BaseProvider.create();
  final QueryUsuario _uQuery = QueryUsuario();

  Future<Usuario> getOne(String username) async {
    final result = await _graphQLClient.query(
      QueryOptions(documentNode: gql(_uQuery.getOne(username))),
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
        documentNode: gql(_uQuery.addUsuario(nombre, username, password, email)),
      )
    );
    
    if (result.hasException) {
      throw GetUsuariosRequestFailure();
    }
    
    final data = result.data['insert_usuarios']['returning'] as List;
    return Usuario.fromJson(data.first);
  }
}