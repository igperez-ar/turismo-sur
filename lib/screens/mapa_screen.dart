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
  /* final Future<List<Alojamiento>> alojamientos; */
  final bool carrousel;

  const MapaScreen({
    Key key, 
    this.title = 'Mapa',
    /* @required this.alojamientos, */
    this.carrousel = true
  }): super(key: key);

  @override
  State<MapaScreen> createState() => MapaScreenState();
}

class MapaScreenState extends State<MapaScreen> {
  String _normalMapStyle, _darkMapStyle;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  GoogleMapController mapController;
  CarouselController carouselController = CarouselController();
  List<Alojamiento> alojamientos = [];
  List<Gastronomico> gastronomicos = [];
  List<SmallCard> _cards = [];
  int counter;


  void _setMarkers(List _items, double marker_color, String marker_type) {
    for (var item in _items) {
      MarkerId markerId = MarkerId(counter.toString());

      Marker marker = Marker(
        markerId: markerId,
        icon: BitmapDescriptor.defaultMarkerWithHue(marker_color),
        position: LatLng(item.lat, item.lng),
        onTap: () {
          var numer = _cards.indexWhere((element) { 
            return element.id == item.id && element.type == marker_type;
          });
          carouselController.jumpToPage(
            numer
            /* type == 1 ?
              _items.indexWhere((element) => element.id == item.id)
            : _items.lastIndexWhere((element) => element.id == item.id) */
          );
        }
      );

      this.setState(() {
        markers[markerId] = marker;
      });

      counter++;
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

  void _onMapCreated(GoogleMapController controller) {
    this.setState(() {
      mapController = controller;
    });

    counter = 0;
    _setMarkers(alojamientos, BitmapDescriptor.hueOrange, 'ALOJAMIENTO');
    _setMarkers(gastronomicos, BitmapDescriptor.hueAzure, 'GASTRONOMICO');
  }

  Widget _getMapWidget() {
    return GoogleMap(    
      mapToolbarEnabled: false,
      myLocationButtonEnabled: true,
      myLocationEnabled: true,
      mapType: MapType.normal,
      zoomControlsEnabled: false,
      onMapCreated: _onMapCreated,
      markers: markers.values.toSet(),
      initialCameraPosition: CameraPosition(
        target: LatLng(-54.8, -68.3), 
        zoom: 15.0
      ),
    );
  }

  Widget _buildCarousel() {
    final int count = max(alojamientos.length, gastronomicos.length);

    for (var index = 0; index < count; index++) {
      if (index < alojamientos.length) 
        _cards.add(
          SmallCard(
            type: 'ALOJAMIENTO',
            id: alojamientos[index].id,
            name: alojamientos[index].nombre,
            address: alojamientos[index].domicilio,
            image: alojamientos[index].foto,
            category: alojamientos[index].categoria,
            clasification: alojamientos[index].clasificacion.nombre,
            onTap: () => Navigator.push(context,
              MaterialPageRoute(
                builder: (context) => AlojamientoScreen(alojamiento: alojamientos[index])
              )
            ),
          )
        );

      if (index < gastronomicos.length) 
        _cards.add(
          SmallCard(
            type: 'GASTRONOMICO',
            id: gastronomicos[index].id,
            name: gastronomicos[index].nombre,
            address: gastronomicos[index].domicilio,
            image: gastronomicos[index].foto,
            activities: gastronomicos[index].actividades,
            specialities: gastronomicos[index].especialidades,
            onTap: () {/* => Navigator.push(context,
              MaterialPageRoute(
                builder: (context) => gastronomicoscreen(alojamiento: gastronomicos[index])
              )
            ) */},
          )
        );
    }

    return CarouselSlider(
        items: _cards,/* alojamientos.map<Widget>((item) {
            return SmallCard(
              type: 'ALOJAMIENTO',
              name: item.nombre,
              address: item.domicilio,
              image: item.foto,
              category: item.categoria,
              clasification: item.clasificacion.nombre,
              onTap: () => Navigator.push(context,
                MaterialPageRoute(
                  builder: (context) => AlojamientoScreen(alojamiento: item)
                )
              ),
            );
          }
        ).toList(), */
        carouselController: carouselController,
        options: CarouselOptions(
          height: 200,
          autoPlay: false,
          enlargeCenterPage: true,
          viewportFraction: 0.8,
          onPageChanged: (index, reason) {
            /* if (reason == CarouselPageChangedReason.manual)
              alojamientos */
          },
          initialPage: 0
        ),
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
                onPressed: () => Navigator.push(context,
                  MaterialPageRoute(
                    builder: (context) => FiltrosScreen()
                  )
                )
              )
            ]
            : null
          ),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          _getMapWidget(),
          BlocBuilder<EstablecimientosBloc, EstablecimientosState>(
            builder: (context, state) {
              if (state is EstablecimientosInitial) {
                BlocProvider.of<EstablecimientosBloc>(context).add(FetchEstablecimientos());
              }

              if (state is EstablecimientosFailure) {
                return Container();
              }

              if (state is EstablecimientosSuccess) {
                alojamientos = state.alojamientos;
                gastronomicos = state.gastronomicos;

                return _buildCarousel();
              }
            
              return Center(
                child: CircularProgressIndicator()
              ); 
            }
          /* (widget.carrousel ? 
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
          ) */
          )
        ]
      )
    );
  }
}