import 'dart:async';

import 'package:turismo_app/providers/providers.dart';
import 'package:turismo_app/models/models.dart';

class EstablecimientosRepository {
  
  final EstablecimientoProvider _provider = EstablecimientoProvider();

  Future<List<Gastronomico>> fetchGastronomicos() async {
    return await _provider.fetchGastronomicos();
  }

  Future<List<Alojamiento>> fetchAlojamientos() async {
    return await _provider.fetchAlojamientos();
  }
}