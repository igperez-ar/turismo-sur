import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:turismo_app/models/models.dart';

Calificacion calificacionFromJson(String str) => Calificacion.fromJson(json.decode(str));

String calificacionToJson(Calificacion data) => json.encode(data.toJson());

class Calificacion extends Equatable{
  final int id;
  final int puntaje;
  final String comentario;
  final Usuario usuario;
  final Destacable destacable;
  final String createdAt;

  Calificacion({
    this.id,
    this.puntaje,
    this.comentario,
    this.usuario,
    this.destacable,
    this.createdAt,
  });

  Calificacion copyWith({
    int puntaje, 
    String comentario, 
    Usuario usuario, 
    Destacable destacable, 
    String createdAt, 
  }) {
    return Calificacion(
      id: this.id, 
      puntaje: puntaje ?? this.puntaje, 
      comentario: comentario ?? this.comentario, 
      usuario: usuario ?? this.usuario, 
      destacable: destacable ?? this.destacable, 
      createdAt: createdAt ?? this.createdAt, 
    );
  }

  @override
  List<Object> get props => [
    id,
    puntaje,
    comentario,
    usuario,
    destacable,
    createdAt,
  ];

  factory Calificacion.fromJson(Map<String, dynamic> json) => Calificacion(
    id: json['id'],
    puntaje: json['puntaje'],
    comentario: json['comentario'],
    usuario: Usuario.fromJson(json['usuario']),
    destacable: (json['destacable'] != null ? Destacable.fromJson(json['destacable']) : null),
    createdAt: json['created_at'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'puntaje': puntaje,
    'comentario': comentario,
    'usuario': usuario,
    'destacable': destacable,
    'createdAt': createdAt,
  };
}
