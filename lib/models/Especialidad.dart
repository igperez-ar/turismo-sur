import 'dart:convert';

Especialidad especialidadFromJson(String str) => Especialidad.fromJson(json.decode(str));

String especialidadToJson(Especialidad data) => json.encode(data.toJson());

class Especialidad {
    int id;
    String nombre;

    Especialidad({
        this.id,
        this.nombre,
    });

    factory Especialidad.fromJson(Map<String, dynamic> json) => Especialidad(
        id: json["id"],
        nombre: json["nombre"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
    };
}
