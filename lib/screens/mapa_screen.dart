import 'dart:math';

import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_app/bloc/bloc.dart';
import 'package:turismo_app/screens/screens.dart';
import 'package:turismo_app/models/models.dart';
import 'package:turismo_app/widgets/widgets.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MapaScreen extends StatefulWidget {
  final String title;
  final bool carrousel;

  const MapaScreen({
    Key key, 
    this.title = 'Mapa',
    this.carrousel = true
  }): super(key: key);

  @override
  State<MapaScreen> createState() => MapaScreenState();
}

class MapaScreenState extends State<MapaScreen> {

  List<SmallCard> _getCards(List<Alojamiento> alojamientos, List<Gastronomico> gastronomicos) {
    final List<SmallCard> cards = [];
    final int count = max(alojamientos.length, gastronomicos.length);

    for (var index = 0; index < count; index++) {
      if (index < alojamientos.length) 
        cards.add(
          SmallCard(
            type: Establecimiento.alojamiento,
            establecimiento: alojamientos[index],
          )
        );

      if (index < gastronomicos.length) 
        cards.add(
          SmallCard(
            type: Establecimiento.gastronomico,
            establecimiento: gastronomicos[index],
          )
        );
    }

    return cards;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, 
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: 
          (widget.carrousel ? 
            <Widget>[
              IconButton(
                icon: Icon(Icons.filter_list, color: Colors.white, size: 30.0,), 
                onPressed: () => Navigator.pushNamed(context, '/filtros'),
              )
            ]
            : null
          ),
      ),
      body: BlocBuilder<EstablecimientosBloc, EstablecimientosState>(
        builder: (context, state) {
          if (state is EstablecimientosInitial) {
            BlocProvider.of<EstablecimientosBloc>(context).add(FetchEstablecimientos());
          }

          if (state is EstablecimientosFailure) {
            return MapCarousel(
              cards: []
            );
          }

          if (state is EstablecimientosSuccess) {

            return MapCarousel(
              cards: _getCards(
                state.filteredAlojamientos, 
                state.filteredGastronomicos
              ),
            );
          }
        
          return Center(
            child: CircularProgressIndicator()
          ); 
        }
      )
    );
  }
}