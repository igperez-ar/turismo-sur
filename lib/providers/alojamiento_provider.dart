import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import 'package:turismo_app/models/models.dart';

class AlojamientoProvider {
  final _baseUrl = 'http://192.168.1.35:3000';
  final http.Client httpClient;

  AlojamientoProvider({
    @required this.httpClient,
  }) : assert(httpClient != null);

  Future<List<Alojamiento>> fetchAlojamientos() async {
    final url = '$_baseUrl/alojamientos?select=id,nombre,domicilio,lat,lng,foto,clasificacion:clasificaciones(id,nombre),categoria:categoria_id,localidad:localidades(id,nombre)';
    final response = await this.httpClient.get(url);

    if (response.statusCode != 200) {
      throw new Exception('error getting alojamientos');
    }

    final jsons = jsonDecode(response.body);
    return jsons.map<Alojamiento>(
      (json) => Alojamiento.fromJson(json)
    ).toList(); 
  }
}