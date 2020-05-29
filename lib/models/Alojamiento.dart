// To parse this JSON data, do
//
//     final alojamiento = alojamientoFromJson(jsonString);

import 'dart:convert';

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

class Alojamiento {
    int id;
    String nombre;
    String domicilio;
    double lat;
    double lng;
    String foto;
    int categoria;
    Clasificacion clasificacion;
    Clasificacion localidad;

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

    factory Alojamiento.fromJson(Map<String, dynamic> json) => Alojamiento(
        id: json['id'],
        nombre: _parseNombre(json['nombre'], Clasificacion.fromJson(json['clasificacion'])),
        domicilio: json['domicilio'],
        lat: json['lat'].toDouble(),
        lng: json['lng'].toDouble(),
        foto: json['foto'],
        categoria: json['categoria'],
        clasificacion: Clasificacion.fromJson(json['clasificacion']),
        localidad: Clasificacion.fromJson(json['localidad']),
    );

    Map<String, dynamic> toJson() => {
        'id': id,
        'nombre': nombre,
        'domicilio': domicilio,
        'lat': lat,
        'lng': lng,
        'foto': foto,
        'categoria': categoria,
        'clasificacion': clasificacion.toJson(),
        'localidad': localidad.toJson(),
    };
}

class Clasificacion {
    int id;
    String nombre;

    Clasificacion({
        this.id,
        this.nombre,
    });

    factory Clasificacion.fromJson(Map<String, dynamic> json) => Clasificacion(
        id: json['id'],
        nombre: json['nombre'],
    );

    Map<String, dynamic> toJson() => {
        'id': id,
        'nombre': nombre,
    };
}
