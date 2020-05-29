import 'dart:async';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:turismo_app/views/Alojamiento.dart' as View;
import 'package:turismo_app/models/Alojamiento.dart';
import 'package:turismo_app/views/Filtros.dart';
import 'package:turismo_app/widgets/SmallCard.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Mapa extends StatefulWidget {
  final String title;
  final Future<List<Alojamiento>> alojamientos;
  final bool carrousel;

  const Mapa({
    Key key, 
    this.title = 'Mapa',
    @required this.alojamientos,
    this.carrousel = true
  }): super(key: key);

  @override
  State<Mapa> createState() => MapaState();
}

class MapaState extends State<Mapa> {
  String _mapStyle;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  GoogleMapController mapController;
  CarouselController carouselController = CarouselController();

  void _setMarkers() async {
    List<Alojamiento> _items = await widget.alojamientos;

    for (var item in _items) {
      MarkerId markerId = MarkerId(item.id.toString());

      Marker marker = Marker(
        markerId: markerId,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
        position: LatLng(item.lat, item.lng),
        onTap: () {carouselController.jumpToPage(
            _items.indexWhere((element) => element.id == item.id)
          );
        }
      );

      setState(() {
        markers[markerId] = marker;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _setMarkers();

    rootBundle.loadString('assets/map_style.txt').then((string) {
      _mapStyle = string;
    });
  }

  Widget _getMapWidget() {
    
    return Container(
      child: GoogleMap(    
        mapToolbarEnabled: false,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        mapType: MapType.normal,
        zoomControlsEnabled: false,
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
          mapController.setMapStyle(_mapStyle);
        },
        markers: Set<Marker>.of(markers.values),
        initialCameraPosition: CameraPosition(
          target: LatLng(-54.8, -68.3), 
          zoom: 15.0
        ),
      )
    );
  }

  Widget _buildCarousel(BuildContext context,List<Alojamiento> alojamientos) {

    return CarouselSlider(
        items: alojamientos.map<Widget>((item) {
          return SmallCard(
            name: item.nombre,
            address: item.domicilio,
            image: item.foto,
            category: item.categoria,
            clasification: item.clasificacion.nombre,
            onTap: () => Navigator.push(context,
              MaterialPageRoute(
                builder: (context) => View.Alojamiento(alojamiento: item)
              )
            ),
          );
          }
        ).toList(),
        carouselController: carouselController,
        options: CarouselOptions(
          height: 200,
          autoPlay: false,
          enlargeCenterPage: true,
          viewportFraction: 0.8,
          aspectRatio: 2.0,
          onPageChanged: (index, reason) {
            /* if (reason == CarouselPageChangedReason.manual)
              alojamientos */
          },
          initialPage: 0
        ),
    );
  }

  /* Widget _buildCarousel(BuildContext context, items) {

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          // you may want to use an aspect ratio here for tablet support
          height: 200.0,
          child: PageView.builder(
            // store this controller in a State to save the carousel scroll position
            controller: carouselController,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0),
                child: SmallCard(
                  name: items[index].nombre,
                  address: items[index].domicilio,
                  image: items[index].foto,
                  category: items[index].categoriaId != 6 ? items[index].categoriaId : 0,
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => View.Alojamiento())
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  } */

  /* Widget _buildCarouselItem(BuildContext context, int itemIndex) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.0),
      child: SmallCard(
        title: 'Hotel Mónaco',
        subtitle: 'San Martín 1335',
        imgUrl: 'https://suit.tur.ar/archivos/read/366/mdc',
        clasification: 1,
        route: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => View.Alojamiento())
        ),
      ),
    );
  } */

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
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            child: Stack(
              children: <Widget>[
                _getMapWidget(),
                (widget.carrousel ? 
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: FutureBuilder<List<Alojamiento>>(
                      future: widget.alojamientos, builder: (context, snapshot) {
                        if (snapshot.hasError) print(snapshot.error); 
                        return snapshot.hasData ? _buildCarousel(context, snapshot.data) 
                        
                        : Center(child: CircularProgressIndicator()); 
                      },
                    ),
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