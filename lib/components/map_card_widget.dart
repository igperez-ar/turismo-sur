import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
/* import 'package:turismo_app/screens/MapaScreen.dart'; */


class MapCardWidget extends StatefulWidget {
  final double lat;
  final double lng;

  MapCardWidget({
    Key key, 
    @required this.lat,
    @required this.lng,
  }): super(key: key);

  @override
  _MapCardWidgetState createState() => _MapCardWidgetState();
}

class _MapCardWidgetState extends State<MapCardWidget> {
  String _normalMapStyle, _darkMapStyle;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{}; 
  GoogleMapController mapController;

  @override
  void initState() {
    super.initState();

    _add(widget.lat, widget.lng);

    rootBundle.loadString('assets/normal_map_style.json').then((string) {
      _normalMapStyle = string;
    });
    rootBundle.loadString('assets/dark_map_style.json').then((string) {
      _darkMapStyle = string;
    });
  }

  void _add(double lat, double lng) {
    var markerIdVal = 'marker';
    final MarkerId markerId = MarkerId(markerIdVal);

    final Marker marker = Marker(
      markerId: markerId,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
      position: LatLng(lat, lng)
    );

    setState(() {
      markers[markerId] = marker;
    });
  }

  Widget _getMapWidget(double _width) {
    /* Completer<GoogleMapController> _controller = Completer(); */
    
    return Container(
      child: GoogleMap(    
        mapType: MapType.normal,
        scrollGesturesEnabled: false,
        rotateGesturesEnabled: false,
        zoomGesturesEnabled: true,
        zoomControlsEnabled: false,
        mapToolbarEnabled: false,
        minMaxZoomPreference: MinMaxZoomPreference(12.0, 15.0),
        onMapCreated: (GoogleMapController controller) {
          /* controller.setMapStyle(_normalMapStyle); */
          this.setState(() {
            mapController = controller;
          });
          /* _controller.complete(controller); */
        },
        markers: Set<Marker>.of(markers.values),
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.lat, widget.lng), 
          zoom: 12.0
        ),
      )
    );
  }
  
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    if (mapController != null ) {
      if (isDark) {
          mapController.setMapStyle(_darkMapStyle);
      }
      else {
          mapController.setMapStyle(_normalMapStyle);
      }
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        /* boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
            spreadRadius: 1,
            offset: Offset(3, 3)
          )
        ] */
      ),
      child: Container(
        width: _width * 0.90,
        height: _width * 0.60,
        child: Stack(
          children: <Widget> [
            _getMapWidget(_width),
            Container(
              margin: EdgeInsets.only(bottom: 10, right: 10),
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () => {}/* Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Mapa(
                      title: widget.title,
                      alojamientos: ['s'],
                      carrousel: false,
                    ))
                ) */,
                child: Container (
                  alignment: Alignment.center,
                  width: 100,
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey[600],
                      width: 1
                    ),
                    borderRadius: BorderRadius.circular(50),
                    color: Theme.of(context).cardColor,
                    boxShadow: [BoxShadow(
                      color: Colors.black12,
                      offset: Offset(3, 3),
                      blurRadius: 3
                    )],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.zoom_in, color: Colors.grey[600]),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2),
                        child: Text('Ampliar', style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 15
                          ), 
                        ), 
                      ) 
                    ],
                  ) 
                ),
              ),
            )
          ], 
        )
      ),
    );
  }
}