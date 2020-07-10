import 'dart:convert';
import 'package:equatable/equatable.dart';

import 'package:turismo_app/models/models.dart';

Favorito favoritoFromJson(String str) => Favorito.fromJson(json.decode(str));

String favoritoToJson(Favorito data) => json.encode(data.toJson());


class Favorito extends Equatable{
  final int id;
  final Establecimiento tipo;
  final List<String> recuerdos;

  Favorito({
    this.id,
    this.tipo,
    this.recuerdos
  });

  @override
  List<Object> get props => [
    id,
    tipo,
  ];

  factory Favorito.fromJson(Map<String, dynamic> json) => Favorito(
    id: json['id'],
    tipo: json['tipo'],
    recuerdos: json['recuerdos']
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'tipo': tipo,
    'recuerdos': recuerdos,
  };
}
