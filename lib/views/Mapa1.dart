import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:turismo_app/views/Alojamiento.dart';
import 'package:turismo_app/views/Filtros.dart';
import 'package:turismo_app/widgets/SmallCard.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Mapa extends StatefulWidget {
  @override
  State<Mapa> createState() => MapaState();
}

class MapaState extends State<Mapa> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _initialPosition = CameraPosition(
    target: LatLng(-54.8, -68.3), 
    zoom: 15.0
  );

  Widget _getMapWidget(double _width) {
    Completer<GoogleMapController> _controller = Completer();
    
    return Container(
      height: 490,
      width: _width,
      child: GoogleMap(    
        mapToolbarEnabled: true,
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        initialCameraPosition: _initialPosition,
      )
    );
  }

  Widget _buildCarousel(BuildContext context, int carouselIndex) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          // you may want to use an aspect ratio here for tablet support
          height: 190.0,
          child: PageView.builder(
            // store this controller in a State to save the carousel scroll position
            controller: PageController(viewportFraction: 0.9),
            itemBuilder: (BuildContext context, int itemIndex) {
              return _buildCarouselItem(context, carouselIndex, itemIndex);
            },
          ),
        )
      ],
    );
  }

  Widget _buildCarouselItem(BuildContext context, int carouselIndex, int itemIndex) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.0),
      child: SmallCard(
        title: 'Hotel Mónaco',
        subtitle: 'San Martín 1335',
        imgUrl: 'https://suit.tur.ar/archivos/read/366/mdc',
        clasification: 1,
        route: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => Alojamiento())
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa', 
          textAlign: TextAlign.center, 
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.white, size: 30.0,), 
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => Filtros())
            )
          )
        ],
        centerTitle: true,
        backgroundColor: Colors.teal[300],
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 490,
            width: Width,
            child: GoogleMap(    
              mapToolbarEnabled: true,
              mapType: MapType.normal,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              initialCameraPosition: _initialPosition,
            )
          ),
          /* _getMapWidget(Width), */
          _buildCarousel(context, 1),
          /* ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) {
                return _buildCarousel(context, index);
            }
          ), */
        ]
      )
    );
  }
}
/* import 'dart:async';

import 'package:flutter/material.dart';
import 'package:turismo_app/views/Alojamiento.dart';
import 'package:turismo_app/views/Filtros.dart';
import 'package:turismo_app/widgets/SmallCard.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Mapa extends StatelessWidget {
  CameraPosition _initialPosition = CameraPosition(target: LatLng(26.8206, 30.8025));
  Completer<GoogleMapController> _controller = Completer();


  void _onMapCreated(GoogleMapController controller) {
      _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    final Width = MediaQuery.of(context).size.width;
    final Height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa', 
          textAlign: TextAlign.center, 
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.white, size: 30.0,), 
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => Filtros())
            )
          )
        ],
        centerTitle: true,
        backgroundColor: Colors.teal[300],
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(    
            mapType: MapType.normal,
            onMapCreated: _onMapCreated,
            initialCameraPosition: _initialPosition,
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: ListView(
              padding: EdgeInsets.only(top: Height * 0.6, right: 20),
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                SmallCard(
                  title: 'Hotel Mónaco',
                  subtitle: 'San Martín 1335',
                  img_url: 'https://suit.tur.ar/archivos/read/366/mdc',
                  clasification: 1,
                  route: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Alojamiento())
                  ),
                ),
                SmallCard(
                  title: 'Hotel Mónaco',
                  subtitle: 'San Martín 1335',
                  img_url: 'https://suit.tur.ar/archivos/read/366/mdc',
                  clasification: 1,
                  route: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Alojamiento())
                  ),
                ),
                SmallCard(
                  title: 'Hotel Mónaco',
                  subtitle: 'San Martín 1335',
                  img_url: 'https://suit.tur.ar/archivos/read/366/mdc',
                  clasification: 1,
                  route: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Alojamiento())
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} */