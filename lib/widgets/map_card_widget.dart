import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:turismo_app/models/models.dart';


class MapCardWidget extends StatefulWidget {
  final double lat;
  final double lng;
  final Establecimiento type;

  MapCardWidget({
    Key key, 
    @required this.lat,
    @required this.lng,
    @required this.type
  }): super(key: key);

  @override
  _MapCardWidgetState createState() => _MapCardWidgetState();
}

class _MapCardWidgetState extends State<MapCardWidget> {
  String _normalMapStyle, _darkMapStyle;
  GoogleMapController _mapController;

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

  Set<Marker> _getMarker() {
    final Map<MarkerId, Marker> markers = {}; 
    final MarkerId markerId = MarkerId(UniqueKey().toString());

    final Marker marker = Marker(
      markerId: markerId,
      icon: BitmapDescriptor.defaultMarkerWithHue( 
        widget.type == Establecimiento.alojamiento
          ? BitmapDescriptor.hueOrange
          : BitmapDescriptor.hueAzure
      ),
      position: LatLng(widget.lat, widget.lng)
    );

    markers[markerId] = marker;

    return markers.values.toSet();
  }

  Widget _getMapWidget(double _width) {
    
    return GoogleMap(    
      mapType: MapType.normal,
      scrollGesturesEnabled: false,
      rotateGesturesEnabled: false,
      zoomGesturesEnabled: true,
      zoomControlsEnabled: true,
      mapToolbarEnabled: false,
      minMaxZoomPreference: MinMaxZoomPreference(12.0, 15.0),
      onMapCreated: (GoogleMapController controller) {
        setState(() {
          _mapController = controller;
        });
      },
      markers: _getMarker(),
      initialCameraPosition: CameraPosition(
        target: LatLng(widget.lat, widget.lng), 
        zoom: 12.0
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    if (_mapController != null ) {
      if (isDark) {
          _mapController.setMapStyle(_darkMapStyle);
      }
      else {
          _mapController.setMapStyle(_normalMapStyle);
      }
    }

    return Container(
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5))
      ),
      child: _getMapWidget(_width)
    );
  }
}