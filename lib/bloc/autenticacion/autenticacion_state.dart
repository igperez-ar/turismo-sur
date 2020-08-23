part of 'autenticacion_bloc.dart';

abstract class AutenticacionState extends Equatable {
  const AutenticacionState();

  @override
  List<Object> get props => [];
}

class AutenticacionInitial extends AutenticacionState {}

class AutenticacionLoading extends AutenticacionState {}

class AutenticacionAuthenticated extends AutenticacionState {
  final Usuario usuario;

  const AutenticacionAuthenticated(this.usuario); 

  @override
  List<Object> get props => [this.usuario];
}

class AutenticacionUnauthenticated extends AutenticacionState {
  final String error;

  const AutenticacionUnauthenticated(this.error);

  @override
  List<Object> get props => [this.error];
}