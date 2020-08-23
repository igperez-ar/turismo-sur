import 'dart:convert';
import 'package:equatable/equatable.dart';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario extends Equatable{
  final int id;
  final String nombre;
  final String descripcion;
  final String email;
  final String foto;
  final String username;
  final String password;

  Usuario({
    this.id,
    this.nombre,
    this.descripcion,
    this.email,
    this.foto,
    this.username,
    this.password,
  });

  Usuario copyWith({
    String nombre, 
    String descripcion, 
    String email, 
    String foto, 
    String username, 
    String password
  }) {
    return Usuario(
      id: this.id, 
      nombre: nombre ?? this.nombre, 
      descripcion: descripcion ?? this.descripcion, 
      email: email ?? this.email, 
      foto: foto ?? this.foto, 
      username: username ?? this.username, 
      password: password ?? this.password,
    );
  }

  @override
  List<Object> get props => [
    id,
    nombre,
    descripcion,
    email,
    foto,
    username,
    password,
  ];

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
    id: json['id'],
    nombre: json['nombre'],
    descripcion: json['descripcion'],
    email: json['email'],
    foto: json['foto'],
    username: json['username'],
    password: json['password'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'nombre': nombre,
    'descripcion': descripcion,
    'email': email,
    'foto': foto,
    'username': username,
    'password': password,
  };
}
