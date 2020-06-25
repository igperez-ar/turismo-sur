import 'dart:async';

import 'package:meta/meta.dart';

import 'package:turismo_app/providers/providers.dart';
import 'package:turismo_app/models/models.dart';

class EstablecimientosRepository {
  final AlojamientoProvider alojamientoProvider;
  final GastronomicoProvider gastronomicoProvider;

  EstablecimientosRepository({
    @required this.alojamientoProvider,
    @required this.gastronomicoProvider,
  });/* : assert(EstablecimientosProvider != null); */

  Future<List<Alojamiento>> fetchAlojamientos() async {
    return await alojamientoProvider.fetchAlojamientos();
  }

  Future<List<Gastronomico>> fetchGastronomicos() async {
    return await gastronomicoProvider.fetchGastronomicos();
  }
}