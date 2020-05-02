import 'dart:async';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:turismo_app/views/Mapa.dart';


class MapCard extends StatefulWidget {
  final String title;

  MapCard({
    Key key, 
    @required this.title
  }): super(key: key);

  @override
  _MapCardState createState() => _MapCardState();
}

class _MapCardState extends State<MapCard> {
 
  String _mapStyle;

  @override
  void initState() {
    super.initState();

    rootBundle.loadString('assets/map_style.txt').then((string) {
      _mapStyle = string;
    });
  }

  Widget _getMapWidget(double _width) {
    /* Completer<GoogleMapController> _controller = Completer(); */
    
    return Container(
      child: GoogleMap(    
        mapType: MapType.normal,
        scrollGesturesEnabled: false,
        rotateGesturesEnabled: false,
        tiltGesturesEnabled: false,
        zoomGesturesEnabled: false,
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
  
  @override
  Widget build(BuildContext context) {
    final Width = MediaQuery.of(context).size.width;

    return (
      Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
        ),
        elevation: 5.0,
        child: Container(
          width: Width * 0.90,
          height: Width * 0.60,
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border(bottom: 
                    BorderSide(
                      color: Colors.grey,
                      width: 1
                    )
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.location_on, color: Colors.grey[500], size: 30,),
                    Padding(padding: EdgeInsets.only(left: 5)),
                    Text(widget.title, style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Stack(
                  children: <Widget> [
                    _getMapWidget(Width),
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
                            color: Colors.white,
                            boxShadow: [BoxShadow(
                              color: Color.fromRGBO(100, 100, 100, 0.6),
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
            ],
          ),      
        ),
      )
    );
  }
}