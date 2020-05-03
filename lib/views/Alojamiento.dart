import 'package:flutter/material.dart';
import 'package:turismo_app/widgets/DefaultCard.dart';
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
            Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(50)),
                  child: Image.network(
                    widget.alojamiento.foto != null ? 
                      widget.alojamiento.foto 
                      :'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRVX4RgUYvaDyHQaEiejmjMy0ZbuEPqGkOwsxq9oAmPl3MQJIRC&usqp=CAU',
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
                          child: Text(widget.alojamiento.nombre, style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          height: 70,
                          child: GestureDetector(
                            onTap: _changeFavorite,
                            child: Icon(
                              liked ? Icons.favorite : Icons.favorite_border, 
                              size: 30, 
                              color: Colors.grey[500],
                            )
                          )
                        )
                      ],
                    ),
                  ),
                ),
                MaterialButton(
                  height: 70,
                  minWidth: 70,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)
                  ),
                  child: Icon(Icons.arrow_back, color: Colors.white, size: 35,),
                  onPressed: () => Navigator.pop(context)
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: <Widget>[
                  DetailSection(
                    title:'Categoría',
                    content: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Hostería', style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 22
                        )
                      ),
                    ),
                  ),
                  DetailSection(
                    title: 'Clasificación',
                    content: Stars(count: widget.alojamiento.categoriaId != 6 ? 
                      widget.alojamiento.categoriaId : 0, 
                      size: 35
                    ), 
                  ),
                  DetailSection(
                    title: 'Ubicación',
                    content: MapCard(
                      title: widget.alojamiento.domicilio,
                      lat: widget.alojamiento.lat,
                      lng: widget.alojamiento.lng,
                    ), 
                    margin: false,
                  ),
                  (liked ? 
                    DetailSection(
                      title: 'Recuerdos',
                      content: Memories(liked: false),
                      margin: false,
                    )
                  : Container())
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