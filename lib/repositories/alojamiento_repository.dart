import 'dart:async';

import 'package:meta/meta.dart';

import 'package:turismo_app/providers/providers.dart';
import 'package:turismo_app/models/models.dart';

class AlojamientoRepository {
  final AlojamientoProvider alojamientoProvider;

  AlojamientoRepository({@required this.alojamientoProvider})
      : assert(AlojamientoProvider != null);

  Future<List<Alojamiento>> fetchAlojamientos() async {
    return await alojamientoProvider.fetchAlojamientos();
  }
}