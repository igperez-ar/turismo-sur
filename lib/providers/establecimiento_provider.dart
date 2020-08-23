import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:turismo_app/models/models.dart';
import 'package:turismo_app/providers/base_provider.dart';
import 'package:turismo_app/queries/queries.dart';

class GetEstablecimientosRequestFailure implements Exception {}

class EstablecimientoProvider {
    
  GraphQLClient _graphQLClient = BaseProvider.create();
  final QueryGastronomico _gQuery = QueryGastronomico();
  final QueryAlojamiento _aQuery = QueryAlojamiento();

  Future<List<Gastronomico>> fetchGastronomicos() async {
    final result = await _graphQLClient.query(
      QueryOptions(documentNode: gql(_gQuery.getAll())),
    );
    
    if (result.hasException) {
      throw GetEstablecimientosRequestFailure();
    }
    final data = result.data['gastronomicos'] as List;
    return data.map((e) => Gastronomico.fromJson(e)).toList();
  }

  Future<List<Alojamiento>> fetchAlojamientos() async {
    final result = await _graphQLClient.query(
      QueryOptions(documentNode: gql(_aQuery.getAll())),
    );

    if (result.hasException) {
      throw GetEstablecimientosRequestFailure();
    }
    final data = result.data['alojamientos'] as List;
    return data.map((e) => Alojamiento.fromJson(e)).toList();
  }
}