import 'dart:convert';
import 'package:equatable/equatable.dart';

Destacable destacableFromJson(String str) => Destacable.fromJson(json.decode(str));

String destacableToJson(Destacable data) => json.encode(data.toJson());

class Destacable extends Equatable{
  final int id;
  final String nombre;
  final String foto;

  Destacable({
    this.id,
    this.nombre,
    this.foto,
  });

  Destacable copyWith({
    String nombre, 
    String foto, 
  }) {
    return Destacable(
      id: this.id, 
      nombre: nombre ?? this.nombre, 
      foto: foto ?? this.foto, 
    );
  }

  @override
  List<Object> get props => [
    id,
    nombre,
    foto,
  ];

  factory Destacable.fromJson(Map<String, dynamic> json) => Destacable(
    id: json['id'],
    nombre: json['nombre'],
    foto: json['foto'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'nombre': nombre,
    'foto': foto,
  };
}
