import 'dart:async';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:turismo_app/views/Alojamiento.dart';
import 'package:turismo_app/views/Filtros.dart';
import 'package:turismo_app/widgets/SmallCard.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Mapa extends StatefulWidget {
  final String title;
  final List<String> places;
  final bool carrousel;

  const Mapa({
    Key key, 
    this.title = 'Mapa',
    @required this.places,
    this.carrousel = true
  }): super(key: key);

  @override
  State<Mapa> createState() => MapaState();
}

class MapaState extends State<Mapa> {
  String _mapStyle;

  @override
  void initState() {
    super.initState();

    rootBundle.loadString('assets/map_style.txt').then((string) {
      _mapStyle = string;
    });
  }

  Widget _getMapWidget() {
    /* Completer<GoogleMapController> _controller = Completer(); */
    
    return Container(
      child: GoogleMap(    
        mapToolbarEnabled: false,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        mapType: MapType.normal,
        zoomControlsEnabled: false,
        onMapCreated: (GoogleMapController controller) {
          controller.setMapStyle(_mapStyle);
          /* _controller.complete(controller); */
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(-54.8, -68.3), 
          zoom: 15.0
        ),
      )
    );
  }

  Widget _buildCarrousel(BuildContext context, int carouselIndex) {
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
              return _buildCarrouselItem(context, carouselIndex, itemIndex);
            },
          ),
        )
      ],
    );
  }

  Widget _buildCarrouselItem(BuildContext context, int carouselIndex, int itemIndex) {
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
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, 
          textAlign: TextAlign.center, 
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: 
          (widget.carrousel ? 
            <Widget>[
              IconButton(
                icon: Icon(Icons.filter_list, color: Colors.white, size: 30.0,), 
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Filtros())
                )
              )
            ]
            : null
          ),
        centerTitle: true,
        backgroundColor: Colors.teal[300],
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: (widget.carrousel ? _height - 140 : _height - 84),
            width: _width,
            child: Stack(
              children: <Widget>[
                _getMapWidget(),
                (widget.carrousel ? 
                  Align(
                    alignment: Alignment.bottomLeft,
                    child:_buildCarrousel(context, 1),
                  )
                  : Container()
                )
              ]
            )
          )
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