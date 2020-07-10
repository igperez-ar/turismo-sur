import 'dart:convert';
import 'package:equatable/equatable.dart';


Categoria categoriaFromJson(String str) => Categoria.fromJson(json.decode(str));

String categoriaToJson(Categoria data) => json.encode(data.toJson());

class Categoria extends Equatable{
  final int id;
  final String nombre;
  final int valor;

  Categoria({
    this.id,
    this.nombre,
    this.valor,
  });

  @override
  List<Object> get props => [
    id,
    nombre,
    valor,
  ];

  factory Categoria.fromJson(Map<String, dynamic> json) => Categoria(
    id: json['id'],
    nombre: json['estrellas'],
    valor: json['valor'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'nombre': nombre,
    'valor': valor,
  };
}
