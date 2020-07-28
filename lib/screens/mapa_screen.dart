import 'dart:math';

import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_app/bloc/bloc.dart';
import 'package:turismo_app/screens/screens.dart';
import 'package:turismo_app/models/models.dart';
import 'package:turismo_app/components/components.dart';

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
  String _normalMapStyle, _darkMapStyle;
  GoogleMapController mapController;
  CarouselController carouselController = CarouselController();


  void _setMarkers(List items, markers, double markerColor, 
    Establecimiento markerType, List<SmallCard> cards) {

    for (var item in items) {
      MarkerId markerId = MarkerId(UniqueKey().toString());

      Marker marker = Marker(
        markerId: markerId,
        icon: BitmapDescriptor.defaultMarkerWithHue(markerColor),
        infoWindow: InfoWindow.noText,
        position: LatLng(item.lat, item.lng),
        onTap: () {
          var numer = cards.indexWhere((element) { 
            return element.establecimiento.id == item.id && element.type == markerType;
          });
          carouselController.jumpToPage(
            numer
          );
        }
      );

      markers[markerId] = marker;
    }
  }

  @override
  void initState() {
    super.initState();

    rootBundle.loadString('assets/normal_map_style.json').then((string) {
      _normalMapStyle = string;
    });
    rootBundle.loadString('assets/dark_map_style.json').then((string) {
      _darkMapStyle = string;
    });
  }

  Set<Marker> _getMarkers(Map<MarkerId, Marker> markers, List<Alojamiento> aloj, 
    List<Gastronomico> gast, List<SmallCard> cards) {
    
    _setMarkers(aloj, markers, BitmapDescriptor.hueOrange, Establecimiento.alojamiento, cards);
    _setMarkers(gast, markers, BitmapDescriptor.hueAzure, Establecimiento.gastronomico, cards);

    return markers.values.toSet();
  }

  Widget _buildCarousel(List<SmallCard> cards, List<Alojamiento> aloj, List<Gastronomico> gast) {
    final int count = max(aloj.length, gast.length);

    for (var index = 0; index < count; index++) {
      if (index < aloj.length) 
        cards.add(
          SmallCard(
            type: Establecimiento.alojamiento,
            establecimiento: aloj[index],
          )
        );

      if (index < gast.length) 
        cards.add(
          SmallCard(
            type: Establecimiento.gastronomico,
            establecimiento: gast[index],
          )
        );
    }

    return CarouselSlider(
        items: cards,
        carouselController: carouselController,
        options: CarouselOptions(
          height: 190,
          autoPlay: false,
          enlargeCenterPage: true,
          viewportFraction: 0.8,
          onPageChanged: (index, reason) {
            if (reason == CarouselPageChangedReason.manual) {
              final item = cards[index].establecimiento;
              mapController.animateCamera(
                CameraUpdate.newLatLngZoom(LatLng(item.lat, item.lng), 20.0)
              );
            }
          },
          initialPage: 0
        ),
    );
  }

  Widget _buildContent(aloj, gast) {
    Map<MarkerId, Marker> markers = {};
    List<SmallCard> cards = [];

    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        GoogleMap(    
          mapToolbarEnabled: false,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          mapType: MapType.normal,
          zoomControlsEnabled: false,
          onMapCreated: (controller) {
            setState(() {
              mapController = controller;
            });
          },
          markers: _getMarkers(markers, aloj, gast, cards),
          initialCameraPosition: CameraPosition(
            /* -54.8, -68.3 */
            target: markers.values.first.position, 
            zoom: 15.0
          ),
        ),
        _buildCarousel(cards, aloj, gast),
      ]
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    if (mapController != null ) {
      if (isDark) {
          mapController.setMapStyle(_darkMapStyle);
      }
      else {
          mapController.setMapStyle(_normalMapStyle);
      }
    }

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
            return Container();
          }

          if (state is EstablecimientosSuccess) {

            return _buildContent(
              state.filteredAlojamientos, 
              state.filteredGastronomicos
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