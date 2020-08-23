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

class MapCarousel extends StatefulWidget {
  final List cards;

  const MapCarousel({
    Key key, 
    this.cards,
  }): super(key: key);

  @override
  State<MapCarousel> createState() => MapCarouselState();
}

class MapCarouselState extends State<MapCarousel> {
  String _normalMapStyle, _darkMapStyle;
  GoogleMapController mapController;
  CarouselController carouselController = CarouselController();


  Set<Marker> _getMarkers() {
    Map<MarkerId, Marker> markers = {};

    for (var item in widget.cards) {
      MarkerId markerId = MarkerId(UniqueKey().toString());

      Marker marker = Marker(
        markerId: markerId,
        icon: BitmapDescriptor.defaultMarkerWithHue(item.type == Establecimiento.alojamiento
          ? BitmapDescriptor.hueOrange
          : BitmapDescriptor.hueAzure
        ),
        position: LatLng(item.establecimiento.lat, item.establecimiento.lng),
        onTap: () {
          final page = widget.cards.indexOf(item);
          carouselController.jumpToPage(page);
        }
      );

      markers[markerId] = marker;
    }

    return markers.values.toSet();
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

  Widget _buildCarousel() {

    return CarouselSlider(
        items: widget.cards.map((e) => Padding(
            padding: EdgeInsets.only(bottom: 15),
            child: e,
          ) 
        ).toList(),
        carouselController: carouselController,
        options: CarouselOptions(
          height: 210,
          autoPlay: false,
          enlargeCenterPage: true,
          viewportFraction: 0.8,
          onPageChanged: (index, reason) {
            if (reason == CarouselPageChangedReason.manual) {
              final item = widget.cards[index].establecimiento;
              mapController.animateCamera(
                CameraUpdate.newLatLngZoom(LatLng(item.lat, item.lng), 17.0)
              );
            }
          },
          initialPage: 0
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
     Set<Marker> markers = _getMarkers();

    if (mapController != null ) {
      if (isDark) {
          mapController.setMapStyle(_darkMapStyle);
      }
      else {
          mapController.setMapStyle(_normalMapStyle);
      }
    }

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
          markers: markers,
          initialCameraPosition: CameraPosition(
            target: markers.isNotEmpty ? markers.first.position : LatLng(-54.8, -68.3), 
            zoom: 15.0
          ),
        ),
        _buildCarousel(),
      ]
    );
  }
}