import 'dart:async';
import 'dart:convert';

/* import 'package:bloc/bloc.dart'; */
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

import 'package:turismo_app/models/models.dart';
import 'package:turismo_app/repositories/repository.dart';

part 'favoritos_event.dart';
part 'favoritos_state.dart';

class FavoritosBloc extends Bloc<FavoritosEvent, FavoritosState> with HydratedMixin {

  FavoritosBloc() : super(FavoritosInitial()) {
    hydrate();
  }

  @override
  FavoritosState fromJson(Map<String, dynamic> json) {
    try {
      print('HydratedFavorites loaded!');
      final List favoritos = json['favoritos'];
      return FavoritosSuccess(
        favoritos.map((e) => Favorito.fromJson(jsonDecode(e))).toList()
      );
      
    } catch (_) {
      print(_);
      return null;
    }
  }

  @override
  Map<String,dynamic> toJson(FavoritosState state) {
    if (state is FavoritosSuccess) {
      print('HydratedFavorites saved!');
      return {'favoritos': state.favoritos.map((e) => jsonEncode(e.toJson())).toList()};

    } else {
      return null;
    }
  }


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
      final List<Favorito> updatedFavoritos = (state as FavoritosSuccess)
        .favoritos
        .where((element) => !(element.id == event.favorito.id
                         && element.tipo == event.favorito.tipo))
        .toList();

      yield FavoritosSuccess(updatedFavoritos);
    }
  } 

  Stream<FavoritosState> _mapFavoritoUpdatedToState(
    UpdateRecuerdos event
  ) async* {
    if (state is FavoritosSuccess){
      final List<Favorito> updatedFavoritos = List.from((state as FavoritosSuccess).favoritos);
      final index = updatedFavoritos.indexOf(event.favorito);
      final favorito = Favorito(
        id: event.favorito.id,
        tipo: event.favorito.tipo,
        recuerdos: event.recuerdos
      );

      updatedFavoritos[index] = favorito;
        
      yield FavoritosSuccess(updatedFavoritos);
    }
  } 
}
