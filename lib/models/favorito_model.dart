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
    recuerdos
  ];

  factory Favorito.fromJson(Map<String, dynamic> json) => Favorito(
    id: json['id'],
    tipo: Establecimiento.values[json['tipo']],
    recuerdos: jsonDecode(json['recuerdos']).map<String>((e) => e.toString()).toList() 
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'tipo': tipo.index,
    'recuerdos': jsonEncode(recuerdos),
  };
}
