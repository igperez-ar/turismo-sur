import 'package:dashed_container/dashed_container.dart';
import 'package:flutter/material.dart';

class Memories extends StatelessWidget {
  const Memories({
    Key key, 
    @required this.liked,
  }): super(key: key);

  final bool liked;

  Widget _getMemories() {
    return Container(

    );
  }

  Widget _getEmptyMemories(double _width) {
    
    return Container(
      alignment: Alignment.topCenter,
      margin: EdgeInsets.only(left: 20, right: 20, top: 10),
      child: DashedContainer(
        dashColor: Colors.grey[500], 
        strokeWidth: 2,
        dashedLength: 10,
        blankLength: 10,
        borderRadius: 20,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 60),
          height: _width * 0.50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.photo_library, size: 60, color: Colors.grey[600],),
              Padding(padding: EdgeInsets.only(top: 10)),
              Text('presiona aquí para agregar recuerdos del lugar'.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Width = MediaQuery.of(context).size.width;

    if (liked) {
      return _getMemories();

    } else {
      return _getEmptyMemories(Width);
    }
  }
}