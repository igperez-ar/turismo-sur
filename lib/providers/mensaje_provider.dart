import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:turismo_app/models/models.dart';
import 'package:turismo_app/providers/base_provider.dart';
import 'package:turismo_app/queries/queries.dart';

class SendMensajesRequestFailure implements Exception {}

class MensajeProvider {
    
  GraphQLClient _graphQLClient = BaseProvider.initailizeClient();

  Future<void> addMensaje({String contenido, int grupo, int miembro}) async {
    final result = await _graphQLClient.mutate(
      MutationOptions(
        documentNode: gql(QueryMensajes.addMensaje),
        variables: {
          'contenido': contenido,
          'grupo': grupo,
          'miembro': miembro,
        }
      ),
    );
    
    if (result.hasException) {
      print(result.exception);
      throw SendMensajesRequestFailure();
    }
  }
}