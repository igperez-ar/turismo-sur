import 'package:dashed_container/dashed_container.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:turismo_app/bloc/bloc.dart';
import 'package:turismo_app/components/components.dart';
import 'package:turismo_app/components/map_carousel.dart';
import 'package:turismo_app/models/models.dart';


class FavoritosScreen extends StatefulWidget {
  @override
  _FavoritosScreenState createState() => _FavoritosScreenState();
}

class _FavoritosScreenState extends State<FavoritosScreen> {
  bool showMap = false;

  Widget _emptyFavs() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30,vertical: 30),
      child: DashedContainer(
        dashColor: Colors.grey[400], 
        strokeWidth: 2,
        dashedLength: 10,
        blankLength: 10,
        borderRadius: 20,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 50),
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.sentiment_dissatisfied, size: 55, color: Colors.grey[600],),
              Padding(padding: EdgeInsets.only(top: 10)),
              Text('marca contenidos como favoritos para que aparezcan aquí'.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      )
    );
  }

  List<SmallCard> _getFavoritos(
    List<Favorito> favoritos, List<Alojamiento> alojamientos, List<Gastronomico> gastronomicos
  ) {
    final List<SmallCard> _children = [];

    for (var item in favoritos) {
      var establecimiento;
      int index;

      if (item.tipo == Establecimiento.alojamiento) {
        index = alojamientos.indexWhere((element) => element.id == item.id);
        establecimiento = index >= 0 ? alojamientos[index] : null;
      } else {
        index = gastronomicos.indexWhere((element) => element.id == item.id);
        establecimiento = index >= 0 ? gastronomicos[index] : null;
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

  /* Widget _favsNotFound() {
    return Center(
      child: Container(
        padding: EdgeInsets.only(left: 40, right: 40, top: 70),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: SvgPicture.asset('assets/images/undraw_taken.svg',
                fit: BoxFit.contain,
              )
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 30, bottom: 50, left: 30, right: 30),
                    child: Text(
                      'No se encontraron favoritos para los filtros seleccionados.',
                      style: Theme.of(context).textTheme.headline4,
                      textAlign: TextAlign.center,
                      
                    )
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                    onPressed: () => Navigator.pushNamed(context, '/filtros'), 
                    child: Text('Ir a filtros', style: TextStyle(color: Colors.white),)
                  )
                ],
              )
            )
          ],
        )
      )
    );
  } */

  @override
  Widget build(BuildContext context) {

    return Scaffold(
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
            onPressed: () => Navigator.pushNamed(context, '/filtros'),
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
                            'action': () => Navigator.pushNamed(context, '/filtros')
                          },
                        );
                      }

                      int countFiltered = favState.favoritos.length - cardsFavoritos.length;

                      return ListView(
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        children: <Widget>[
                          (countFiltered > 0
                            ? Container(
                                child: Text( countFiltered == 1 
                                  ? 'Se filtró 1 establecimiento.'
                                  : 'Se filtraron $countFiltered establecimientos.',
                                  style: Theme.of(context).textTheme.headline3,
                                )
                              )
                            : Container()
                          ),
                          Column(
                            children: cardsFavoritos,
                          )
                        ],
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