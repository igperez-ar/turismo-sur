import 'package:turismo_app/models/models.dart';
import 'package:turismo_app/queries/queries.dart' as queries;
import 'package:graphql/client.dart';

class GetGastronomicosRequestFailure implements Exception {}

class GastronomicoProvider {

  const GastronomicoProvider({
    GraphQLClient graphQLClient
  }) : assert(graphQLClient != null),
       _graphQLClient = graphQLClient;

  factory GastronomicoProvider.create() {
    final httpLink = HttpLink(uri:'https://graphql-turismo.herokuapp.com/v1/graphql');
    final link = Link.from([httpLink]);

    return GastronomicoProvider(
      graphQLClient: GraphQLClient(cache: InMemoryCache(), link: link),
    );
  }

  final GraphQLClient _graphQLClient;

  Future<List<Gastronomico>> fetchGastronomicos() async {
    final result = await _graphQLClient.query(
      QueryOptions(documentNode: gql(queries.getGastronomicos)),
    );
    if (result.hasException) {
      throw GetGastronomicosRequestFailure();
    }
    final data = result.data['gastronomicos'] as List;
    return data.map((e) => Gastronomico.fromJson(e)).toList();
  }
}