part of 'autenticacion_bloc.dart';

abstract class AutenticacionEvent extends Equatable {
  const AutenticacionEvent();
}

class LoggedIn extends AutenticacionEvent {
  final String username;
  final String password; 

  const LoggedIn({
    this.username,
    this.password
  });

  @override
  List<Object> get props => [this.username, this.password];
}

class Register extends AutenticacionEvent {
  final String nombre;
  final String username;
  final String password;
  final String email;

  const Register({
    this.nombre,
    this.username,
    this.password,
    this.email
  });

  @override
  List<Object> get props => [this.nombre, this.username, this.password, this.email];
}

class LoggedOut extends AutenticacionEvent {
  const LoggedOut();

  @override
  List<Object> get props => [];
}
