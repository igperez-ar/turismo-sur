import 'package:flutter/material.dart';
import 'package:turismo_app/widgets/FavButton.dart';
import 'package:turismo_app/widgets/MapCard.dart';
import 'package:turismo_app/widgets/Memories.dart';
import 'package:turismo_app/widgets/Stars.dart';
import 'package:turismo_app/widgets/DetailSection.dart';

class Alojamiento extends StatefulWidget {
   final bool liked;
   final alojamiento;

  const Alojamiento({
    Key key, 
    this.alojamiento,
    this.liked = false
  }): super(key: key);

  @override
  _AlojamientoState createState() => _AlojamientoState(liked: liked);
}

class _AlojamientoState extends State<Alojamiento> {
   bool liked;

  _AlojamientoState({this.liked});

  void _changeFavorite() {
    if (liked) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Confirmar'),
            content: Text('Esta acción eliminará los recuerdos añadidos a este lugar.'),
            actions: <Widget>[
              FlatButton(
                child: Text("Cancelar"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                padding: EdgeInsets.only(right: 20),
                child: Text("Aceptar"),
                onPressed: () {
                  setState(() {
                    liked = !liked;
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    } else {
      setState(() {
        liked = !liked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    
    return Scaffold(
      body: Center(
        child: ListView(
          children: <Widget>[ 
            Container( 
              height: 450.0,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(45)),
                    child: Image.network(
                      widget.alojamiento.foto != null ? 
                        widget.alojamiento.foto 
                        :'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRVX4RgUYvaDyHQaEiejmjMy0ZbuEPqGkOwsxq9oAmPl3MQJIRC&usqp=CAU',
                      fit: BoxFit.cover,
                      height: _width * 0.8,
                      width: _width,
                    ),
                  ),
                  /* Container(
                    height: _width * 0.8,
                    width: _width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(45)),
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [Color.fromRGBO(10, 10, 10, 0.8), Color.fromRGBO(50, 50, 50, 0.5), Color.fromRGBO(150, 150, 150, 0.05)]
                      )
                    ),
                  ), */
                  Align(
                    alignment: Alignment(0.8, 1.15),
                    child: FavButton(
                      liked: liked,
                      size: 60,
                      onPress: _changeFavorite,
                    ),
                  ),
                  Container(
                    alignment: Alignment(-1, -0.85),
                    child: MaterialButton(
                      height: 20,
                      child: Icon(Icons.arrow_back, color: Colors.white, size: 35,),
                      onPressed: () => Navigator.pop(context)
                    )
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 35, right: 20, left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Stars(count: widget.alojamiento.categoria, 
                    size: 30
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(widget.alojamiento.nombre, style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.location_on,
                        size: 30,
                        color: Colors.grey[600],
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        flex: 1,
                        child: Text(widget.alojamiento.domicilio, style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 17
                          ),
                          overflow: TextOverflow.clip,
                        )
                      )
                    ]
                  ),
                  /* DetailSection(
                    title:'Categoría',
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Hostería', style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 22
                        )
                      ),
                    ),
                  ), */
                  SizedBox(height: 30),
                  DetailSection(
                    title: "Ubicación:",
                    margin: false,
                    child: MapCard(
                      lat: widget.alojamiento.lat,
                      lng: widget.alojamiento.lng,
                    )
                  ),
                  (liked ? 
                    DetailSection(
                      title: 'Recuerdos:',
                      child: Memories(liked: false),
                      margin: false,
                    )
                  : Container()) 
                ],
              )
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey[50],
    );
  }
}