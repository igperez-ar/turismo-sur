import 'dart:convert';

Localidad localidadFromJson(String str) => Localidad.fromJson(json.decode(str));

String localidadToJson(Localidad data) => json.encode(data.toJson());

class Localidad {
    int id;
    String nombre;

    Localidad({
        this.id,
        this.nombre,
    });

    factory Localidad.fromJson(Map<String, dynamic> json) => Localidad(
        id: json["id"],
        nombre: json["nombre"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
    };
}
