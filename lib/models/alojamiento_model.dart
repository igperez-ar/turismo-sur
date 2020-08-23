import 'dart:convert';
import 'package:equatable/equatable.dart';

import 'package:turismo_app/models/models.dart';

Alojamiento alojamientoFromJson(String str) => Alojamiento.fromJson(json.decode(str));

String alojamientoToJson(Alojamiento data) => json.encode(data.toJson());

String _parseNombre(String nombre, Clasificacion clasificacion) {
  if (clasificacion.id == 9 && nombre.length > 77)
    return nombre.replaceRange(0, nombre.lastIndexOf(')')+1, '').trim();

  return nombre.replaceAll(
    RegExp(r'albergue|apart|hotel|hoster+[íi]+a|cabañas|hospedaje|b&b|camping',
      caseSensitive: false), 
      ''
    ).trim();
}

class Alojamiento extends Equatable{
  final int id;
  final String nombre;
  final String domicilio;
  final double lat;
  final double lng;
  final String foto;
  final Categoria categoria;
  final Clasificacion clasificacion;
  final Localidad localidad;

  Alojamiento({
    this.id,
    this.nombre,
    this.domicilio,
    this.lat,
    this.lng,
    this.foto,
    this.categoria,
    this.clasificacion,
    this.localidad,
  });

  @override
  List<Object> get props => [
    id,
    nombre,
    domicilio,
    lat,
    lng,
    foto,
    categoria,
    clasificacion,
    localidad,
  ];

  factory Alojamiento.fromJson(Map<String, dynamic> json) => Alojamiento(
    id: json['id'],
    nombre: _parseNombre(json['nombre'], Clasificacion.fromJson(json['clasificacione'])),
    domicilio: json['domicilio'],
    lat: json['lat'].toDouble(),
    lng: json['lng'].toDouble(),
    foto: json['foto'],
    categoria: Categoria.fromJson(json['categoria']),
    clasificacion: Clasificacion.fromJson(json['clasificacione']),
    localidad: Localidad.fromJson(json['localidade']),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'nombre': nombre,
    'domicilio': domicilio,
    'lat': lat,
    'lng': lng,
    'foto': foto,
    'categoria': categoria.toJson(),
    'clasificacion': clasificacion.toJson(),
    'localidad': localidad.toJson(),
  };
}
