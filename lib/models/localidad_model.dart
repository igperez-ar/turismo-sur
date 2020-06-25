import 'dart:convert';

import 'package:equatable/equatable.dart';

Localidad localidadFromJson(String str) => Localidad.fromJson(json.decode(str));

String localidadToJson(Localidad data) => json.encode(data.toJson());

class Localidad extends Equatable {
  final int id;
  final String nombre;

  Localidad({
    this.id,
    this.nombre,
  });

  @override
  List<Object> get props => [
    id,
    nombre
  ];

  factory Localidad.fromJson(Map<String, dynamic> json) => Localidad(
    id: json['id'],
    nombre: json['nombre'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'nombre': nombre,
  };
}
