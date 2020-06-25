import 'dart:convert';

import 'package:equatable/equatable.dart';

Actividad actividadFromJson(String str) => Actividad.fromJson(json.decode(str));

String actividadToJson(Actividad data) => json.encode(data.toJson());

class Actividad extends Equatable {
  final int id;
  final String nombre;

  Actividad({
    this.id,
    this.nombre,
  });

  @override
  List<Object> get props => [
    id,
    nombre
  ];

  factory Actividad.fromJson(Map<String, dynamic> json) => Actividad(
    id: json['id'],
    nombre: json['nombre'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'nombre': nombre,
  };
}
