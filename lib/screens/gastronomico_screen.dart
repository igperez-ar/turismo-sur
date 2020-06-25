import 'package:flutter/material.dart';
import 'package:turismo_app/components/components.dart';

class Gastronomicos extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    
    return Scaffold(
      body: Center(
        child: ListView(
          children: <Widget>[ 
            Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(50)),
                  child: Image.network(
                    'https://suit.tur.ar/archivos/read/366/mdc',
                    fit: BoxFit.cover,
                    height: _width * 0.8,
                    width: _width,
                  ),
                ),
                Container(
                  height: _width * 0.8,
                  width: _width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(50)),
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Color.fromRGBO(10, 10, 10, 0.8), Color.fromRGBO(50, 50, 50, 0.5), Color.fromRGBO(150, 150, 150, 0.05)]
                    )
                  ),
                  child: Container(
                    alignment: Alignment.bottomLeft,
                    padding: EdgeInsets.only(left: 20, bottom: 20),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: _width * 0.75,
                          margin: EdgeInsets.only(right: 10),
                          child: Text('137 Pizza & Pasta', style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          height: 70,
                          child: Icon(Icons.favorite, size: 30, color: Colors.grey[500])
                        )
                      ],
                    ),
                  ),
                ),
                AppBar(
                  title: Text('Flecha atrás'),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: <Widget>[
                  DetailSectionWidget(
                    title:'Actividad',
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Restaurante', style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 22
                        )
                      ),
                    ),
                  ),
                  DetailSectionWidget(
                    title: 'Especialidad',
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Pizza pasta y minutas', style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 22,
                        ),
                      ), 
                    ),
                  ),
                  /* DetailSectionWidget(
                    title: 'Ubicación',
                    child: MapCardWidget(),
                    margin: false, 
                  ), */
                ],
              )
            ),
          ],
        ),
      ),
      backgroundColor: Color.fromRGBO(238, 238, 242, 1),
    );
  }
}