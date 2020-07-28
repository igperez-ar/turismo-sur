part of 'favoritos_bloc.dart';

abstract class FavoritosEvent extends Equatable {
  const FavoritosEvent();
}

class FetchFavoritos extends FavoritosEvent {
  const FetchFavoritos();

  @override
  List<Object> get props => [];
}

class AddFavorito extends FavoritosEvent {
  final Favorito favorito;

  const AddFavorito(this.favorito);

  @override
  List<Object> get props => [favorito];
}

class RemoveFavorito extends FavoritosEvent {
  final Favorito favorito;

  const RemoveFavorito(this.favorito);

  @override
  List<Object> get props => [favorito];
}

class UpdateRecuerdos extends FavoritosEvent {
  final Favorito favorito;
  final List<String> recuerdos;

  const UpdateRecuerdos(this.favorito, this.recuerdos);

  @override
  List<Object> get props => [favorito, recuerdos];
}
