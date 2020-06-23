import 'dart:async';
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

  void _setMarkers(_items) {
    /* List<Alojamiento> _items = await widget.alojamientos; */

    for (var item in _items) {
      MarkerId markerId = MarkerId(item.id.toString());

      Marker marker = Marker(
        markerId: markerId,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
        position: LatLng(item.lat, item.lng),
        onTap: () {
          carouselController.jumpToPage(
            _items.indexWhere((element) => element.id == item.id)
          );
        }
      );

      this.setState(() {
        markers[markerId] = marker;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    BlocListener<AlojamientoBloc, AlojamientoState>(
      listener: (context, state) {
        if (state is AlojamientoSuccess)
          _setMarkers(state.alojamientos);
      }
    );
    rootBundle.loadString('assets/normal_map_style.json').then((string) {
      _normalMapStyle = string;
    });
    rootBundle.loadString('assets/dark_map_style.json').then((string) {
      _darkMapStyle = string;
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
          this.setState(() {
            mapController = controller;
          });
          /* mapController.setMapStyle(_normalMapStyle); */
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
                builder: (context) => AlojamientoScreen(alojamiento: item)
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
                    MaterialPageRoute(builder: (context) => Filtros())
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
          BlocBuilder<AlojamientoBloc, AlojamientoState>(
            builder: (context, state) {
              if (state is AlojamientoInitial) {
                BlocProvider.of<AlojamientoBloc>(context).add(FetchAlojamientos());
              }

              if (state is AlojamientoFailure) {
                return Center(
                  child: Text('failed to fetch alojamientos')
                );
              }

              if (state is AlojamientoSuccess) {
                if (state.alojamientos.isEmpty) {
                  return Center(
                    child: Text('alojamientos VACIO')
                  );
                }
                /* _setMarkers(state.alojamientos); */
                return _buildCarousel(context, state.alojamientos);
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