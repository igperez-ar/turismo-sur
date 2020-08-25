part of 'autenticacion_bloc.dart';

abstract class AutenticacionEvent extends Equatable {
  const AutenticacionEvent();
}

class AutenticacionLoggedIn extends AutenticacionEvent {
  final String username;
  final String password; 

  const AutenticacionLoggedIn({
    this.username,
    this.password
  });

  @override
  List<Object> get props => [this.username, this.password];
}

class AutenticacionRegister extends AutenticacionEvent {
  final String nombre;
  final String username;
  final String password;
  final String email;

  const AutenticacionRegister({
    this.nombre,
    this.username,
    this.password,
    this.email
  });

  @override
  List<Object> get props => [this.nombre, this.username, this.password, this.email];
}

class AutenticacionUpdate extends AutenticacionEvent {
  final String username;
  final Usuario newUser;

  const AutenticacionUpdate({
    this.username,
    this.newUser
  });

  @override
  List<Object> get props => [this.username, this.newUser];
}

class AutenticacionLoggedOut extends AutenticacionEvent {
  const AutenticacionLoggedOut();

  @override
  List<Object> get props => [];
}
