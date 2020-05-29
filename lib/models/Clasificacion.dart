import 'dart:convert';

Clasificacion clasificacionFromJson(String str) => Clasificacion.fromJson(json.decode(str));

String clasificacionToJson(Clasificacion data) => json.encode(data.toJson());

class Clasificacion {
    int id;
    String nombre;

    Clasificacion({
        this.id,
        this.nombre,
    });

    factory Clasificacion.fromJson(Map<String, dynamic> json) => Clasificacion(
        id: json["id"],
        nombre: json["nombre"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
    };
}
