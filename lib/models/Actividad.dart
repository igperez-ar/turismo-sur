import 'dart:convert';

Actividad actividadFromJson(String str) => Actividad.fromJson(json.decode(str));

String actividadToJson(Actividad data) => json.encode(data.toJson());

class Actividad {
    int id;
    String nombre;

    Actividad({
        this.id,
        this.nombre,
    });

    factory Actividad.fromJson(Map<String, dynamic> json) => Actividad(
        id: json["id"],
        nombre: json["nombre"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
    };
}
