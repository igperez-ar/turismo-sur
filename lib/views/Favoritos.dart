import 'package:flutter/material.dart';
import 'package:dashed_container/dashed_container.dart';

class Favoritos extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Favoritos', 
          textAlign: TextAlign.center, 
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal[300],
      ),
      body: Container(
        alignment: Alignment.topCenter,
        margin: EdgeInsets.all(30),
        child: DashedContainer(
          dashColor: Colors.grey[500], 
          strokeWidth: 2,
          dashedLength: 10,
          blankLength: 10,
          borderRadius: 20,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            height: _width * 0.50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.sentiment_dissatisfied, size: 60, color: Colors.grey[600],),
                Padding(padding: EdgeInsets.only(top: 10)),
                Text('marca contenidos como favoritos para que aparezcan aquí'.toUpperCase(),
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
      ),
      backgroundColor: Color.fromRGBO(238, 238, 242, 1),
    );
  }
}