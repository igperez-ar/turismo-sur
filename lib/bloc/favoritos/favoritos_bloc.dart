import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:turismo_app/models/models.dart';
import 'package:turismo_app/repositories/repository.dart';

part 'favoritos_event.dart';
part 'favoritos_state.dart';

class FavoritosBloc extends Bloc<FavoritosEvent, FavoritosState> {
  @override
  FavoritosState get initialState => FavoritosInitial();

  @override
  Stream<FavoritosState> mapEventToState(
    FavoritosEvent event
  ) async* {
    if (event is FetchFavoritos) {
      yield* _mapFavoritosLoadedToState();
    } else if (event is AddFavorito) {
      yield* _mapFavoritoAddedToState(event);
    } else if (event is RemoveFavorito) {
      yield* _mapFavoritoRemovedToState(event);
    } else if (event is UpdateRecuerdos) {
      yield* _mapFavoritoUpdatedToState(event);
    } 
  }

  Stream<FavoritosState> _mapFavoritosLoadedToState() async* {
    yield FavoritosFetching();

    try {
      final List<Favorito> favoritos = []; 
      
      yield FavoritosSuccess(favoritos);
    } catch (e) {
      print(e);
      yield FavoritosFailure();
    }
  } 

  Stream<FavoritosState> _mapFavoritoAddedToState(
    AddFavorito event
  ) async* {
    if (state is FavoritosSuccess){
      final List<Favorito> updatedFavoritos = List
        .from((state as FavoritosSuccess).favoritos)
        ..add(event.favorito);
        
      yield FavoritosSuccess(updatedFavoritos);
    }
  } 

  Stream<FavoritosState> _mapFavoritoRemovedToState(
    RemoveFavorito event
  ) async* {
    if (state is FavoritosSuccess) {
      final List<Favorito> updatedFavoritos = (state as FavoritosSuccess).favoritos
        .where((element) => !(element.id == event.favorito.id
                           && element.tipo == event.favorito.tipo)
        ).toList();

      yield FavoritosSuccess(updatedFavoritos);
    }
  } 

  Stream<FavoritosState> _mapFavoritoUpdatedToState(
    UpdateRecuerdos event
  ) async* {
    if (state is FavoritosSuccess){
      final List<Favorito> updatedFavoritos = (state as FavoritosSuccess).favoritos;
      final index = updatedFavoritos.indexOf(event.favorito);

      updatedFavoritos[index] = event.favorito;
        
      yield FavoritosSuccess(updatedFavoritos);
    }
  } 
}
