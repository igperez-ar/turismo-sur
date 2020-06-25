import 'dart:convert';

import 'package:equatable/equatable.dart';

Clasificacion clasificacionFromJson(String str) => Clasificacion.fromJson(json.decode(str));

String clasificacionToJson(Clasificacion data) => json.encode(data.toJson());

class Clasificacion extends Equatable {
  final int id;
  final String nombre;

  Clasificacion({
    this.id,
    this.nombre,
  });

  @override
  List<Object> get props => [
    id,
    nombre
  ];

  factory Clasificacion.fromJson(Map<String, dynamic> json) => Clasificacion(
    id: json["id"],
    nombre: json["nombre"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nombre": nombre,
  };
}
