import 'dart:convert';
import 'package:equatable/equatable.dart';

Mensaje mensajeFromJson(String str) => Mensaje.fromJson(json.decode(str));

String mensajeToJson(Mensaje data) => json.encode(data.toJson());

class Mensaje extends Equatable{
  final int id;
  final String nombre;
  final String email;
  final String foto;
  final String username;
  final String password;

  Mensaje({
    this.id,
    this.nombre,
    this.email,
    this.foto,
    this.username,
    this.password,
  });

  @override
  List<Object> get props => [
    id,
    nombre,
    email,
    foto,
    username,
    password,
  ];

  factory Mensaje.fromJson(Map<String, dynamic> json) => Mensaje(
    id: json['id'],
    nombre: json['nombre'],
    email: json['email'],
    foto: json['foto'],
    username: json['username'],
    password: json['password'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'nombre': nombre,
    'email': email,
    'foto': foto,
    'username': username,
    'password': password,
  };
}
