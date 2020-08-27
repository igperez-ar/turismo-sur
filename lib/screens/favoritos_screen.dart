import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:turismo_app/bloc/bloc.dart';
import 'package:turismo_app/widgets/widgets.dart';
import 'package:turismo_app/models/models.dart';


class FavoritosScreen extends StatefulWidget {
  @override
  _FavoritosScreenState createState() => _FavoritosScreenState();
}

class _FavoritosScreenState extends State<FavoritosScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int filtered;
  bool showMap = false;

  List<SmallCard> _getFavoritos(
    List<Favorito> favoritos, List<Alojamiento> alojamientos, List<Gastronomico> gastronomicos
  ) {
    final List<SmallCard> _children = [];

    for (var item in favoritos) {
      var establecimiento;

      if (item.tipo == Establecimiento.alojamiento) {
        establecimiento = alojamientos.singleWhere(
          (element) => element.id == item.id,
          orElse: () => null  
        );

      } else {
        establecimiento = gastronomicos.singleWhere(
          (element) => element.id == item.id,
          orElse: () => null  
        );
      }

      if (establecimiento != null)
        _children.add(
          SmallCard(
            type: item.tipo,
            establecimiento: establecimiento,
          )
        );
    }

    return _children;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Favoritos', 
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.filter_list, color: Colors.white, size: 30.0,), 
            onPressed: () => Navigator.pushNamed(
              context, '/filtros', 
              arguments: {
                'scaffoldKey': _scaffoldKey,
                'favoritos': true
              }
            ),
          ),
          IconButton(
            icon: Icon(showMap ? Icons.format_list_bulleted : Icons.map, size: 30.0,), 
            onPressed: () { 
              setState(() {
                showMap = !showMap;
              });
            } 
          )
        ],
      ),
      body: BlocBuilder<EstablecimientosBloc, EstablecimientosState>(
        builder: (context, estState) {

            if (estState is EstablecimientosFailure) {
              return EmptyWidget(
                title: 'Ocurrió un problema inesperado. Intenta nuevamente más tarde.',
                uri: 'assets/images/undraw_server_down.svg',
              );
            }

            if (estState is EstablecimientosSuccess) {
              return BlocBuilder<FavoritosBloc, FavoritosState>(
                builder: (context, favState) {

                  if (favState is FavoritosSuccess) {
                    List<SmallCard> cardsFavoritos = _getFavoritos(
                      favState.favoritos,
                      estState.filteredAlojamientos, 
                      estState.filteredGastronomicos,
                    );
                    
                    if (!showMap) {
                      if (favState.favoritos.isEmpty)
                        return EmptyWidget(
                          title: 'Marca contenidos como favoritos para que aparezcan aquí.',
                          uri: 'assets/images/undraw_empty.svg',
                        );

                      if (cardsFavoritos.isEmpty) {
                        return EmptyWidget(
                          title: 'No se encontraron favoritos para los filtros seleccionados.',
                          uri: 'assets/images/undraw_taken.svg',
                          button: {
                            'title': 'Ir a filtros',
                            'action': () => Navigator.pushNamed(context, '/filtros', arguments: {'scaffoldKey': _scaffoldKey})
                          },
                        );
                      }

                      return ListView(
                        reverse: true,
                        shrinkWrap: true,
                        padding: EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 5),
                        children: cardsFavoritos,
                      );
                    } else {

                      return MapCarousel(
                        cards: cardsFavoritos
                      );
                    }
                  }

                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ); 
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      )
    );
  }
}