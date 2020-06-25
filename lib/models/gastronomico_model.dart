import 'dart:convert';
import 'package:equatable/equatable.dart';

import 'package:turismo_app/models/models.dart';

Gastronomico gastronomicoFromJson(String str) => Gastronomico.fromJson(json.decode(str));

String gastronomicoToJson(Gastronomico data) => json.encode(data.toJson());

class Gastronomico extends Equatable{
  final int id;
  final String nombre;
  final String domicilio;
  final double lat;
  final double lng;
  final String foto;
  final List<Actividad> actividades;
  final List<Especialidad> especialidades;
  final Localidad localidad;

  Gastronomico({
    this.id,
    this.nombre,
    this.domicilio,
    this.lat,
    this.lng,
    this.foto,
    this.actividades,
    this.especialidades,
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
    actividades,
    especialidades,
    localidad,
  ];

  factory Gastronomico.fromJson(Map<String, dynamic> json) => Gastronomico(
    id: json['id'],
    nombre: json['nombre'],
    domicilio: json['domicilio'],
    lat: json['lat'].toDouble(),
    lng: json['lng'].toDouble(),
    foto: json['foto'],
    actividades: List<Actividad>.from(
      json['actividad_gastronomicos'].map((x) => Actividad.fromJson(x['actividade']))
    ),
    especialidades: List<Especialidad>.from(
      json['especialidad_gastronomicos'].map((x) => Especialidad.fromJson(x['especialidade']))
    ),
    localidad: json['localidade'] != null ? Localidad.fromJson(json['localidade']) : null,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'nombre': nombre,
    'domicilio': domicilio,
    'lat': lat,
    'lng': lng,
    'foto': foto,
    'actividades': List<dynamic>.from(actividades.map((x) => x.toJson())),
    'especialidades': List<dynamic>.from(especialidades.map((x) => x.toJson())),
    'localidad': localidad.toJson(),
  };
}
