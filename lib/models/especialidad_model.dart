import 'dart:convert';

import 'package:equatable/equatable.dart';

Especialidad especialidadFromJson(String str) => Especialidad.fromJson(json.decode(str));

String especialidadToJson(Especialidad data) => json.encode(data.toJson());

class Especialidad extends Equatable {
  final int id;
  final String nombre;

  Especialidad({
    this.id,
    this.nombre,
  });

  @override
  List<Object> get props => [
    id,
    nombre
  ];

  factory Especialidad.fromJson(Map<String, dynamic> json) => Especialidad(
    id: json['id'],
    nombre: json['nombre'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'nombre': nombre,
  };
}
