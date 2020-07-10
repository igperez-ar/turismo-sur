import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:turismo_app/bloc/bloc.dart';
import 'package:turismo_app/models/models.dart';

import 'package:turismo_app/screens/screens.dart';
import 'package:turismo_app/components/components.dart';

class ExplorarScreen extends StatefulWidget {
  @override
  _ExplorarScreenState createState() => _ExplorarScreenState();
}

class _ExplorarScreenState extends State<ExplorarScreen> {
  EstablecimientosBloc _establecimientoBloc;
  FavoritosBloc _favoritoBloc;
  Position userPosition;

  Future<String> _getDistance(double lat, double lng) async {
    String distance;

    if (userPosition == null) { 
      Position newPosition = await Geolocator().getCurrentPosition();

      if (this.mounted)
        this.setState(() {
          userPosition = newPosition;
        });
    }

    if (userPosition != null) 
      distance = await Geolocator().distanceBetween(
        userPosition.latitude, userPosition.longitude, 
        lat, lng
      ).then((value) {
          if (value.round() >= 1000) 
            return ((value / 1000).toStringAsFixed(1).replaceFirst('.0', '') + ' km de tu ubicación');

          return (value.round().toString().replaceFirst('.0', '') + ' m de tu ubicación'); 
        });

    return distance;
  }

  Widget _getCardList(List<Alojamiento> alojamientos, List<Gastronomico> gastronomicos) {
    return ListView.builder(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
        itemCount: max(alojamientos.length, gastronomicos.length), 
        itemBuilder: (context, index) { 
          return Column(
            children: <Widget>[
              ( index < alojamientos.length 
                ? DefaultCard(
                    type: Establecimiento.alojamiento,
                    establecimiento: alojamientos[index],
                    distance: _getDistance(alojamientos[index].lat, alojamientos[index].lng),
                  )
                : Container()
              ),
              ( index < gastronomicos.length 
                ? DefaultCard(
                    type: Establecimiento.gastronomico,
                    establecimiento: gastronomicos[index],
                    distance: _getDistance(gastronomicos[index].lat, gastronomicos[index].lng),
                  )
                : Container()
              )
            ]
          ); 
        },
      );
  }

  @override 
  void initState() {
    super.initState();

    _establecimientoBloc = BlocProvider.of<EstablecimientosBloc>(context);
    _favoritoBloc = BlocProvider.of<FavoritosBloc>(context);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Explorar', 
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
          )
        ],
      ),
      body: Container(
        child: BlocBuilder<EstablecimientosBloc, EstablecimientosState>(
          builder: (context, state) {
            if (state is EstablecimientosInitial) {
              _establecimientoBloc.add(FetchEstablecimientos());
              _favoritoBloc.add(FetchFavoritos());
            }

            if (state is EstablecimientosFailure) {
              return Center(
                child: Text('failed to fetch content')
              );
            }

            if (state is EstablecimientosSuccess) {
              return _getCardList(
                state.filteredAlojamientos, 
                state.filteredGastronomicos
              );
            }
          
            return Center(
              child: CircularProgressIndicator()
            ); 
          }
        )
      )
    );
  }
}