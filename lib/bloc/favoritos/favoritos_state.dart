part of 'favoritos_bloc.dart';

abstract class FavoritosState extends Equatable {
  const FavoritosState();

  @override
  List<Object> get props => [];
}

class FavoritosInitial extends FavoritosState {}

class FavoritosFetching extends FavoritosState {}

class FavoritosSuccess extends FavoritosState {
  final List<Favorito> favoritos;

  const FavoritosSuccess(this.favoritos); 

  @override
  List<Object> get props => [favoritos];
}

class FavoritosFailure extends FavoritosState {}