/* import 'package:flutter/material.dart';
import 'package:turismo_app/components/components.dart';

class AlojamientoScreen extends StatefulWidget {
   final bool liked;
   final alojamiento;

  const AlojamientoScreen({
    Key key, 
    this.alojamiento,
    this.liked = false
  }): super(key: key);

  @override
  _AlojamientoScreenState createState() => _AlojamientoScreenState(liked: liked);
}

class _AlojamientoScreenState extends State<AlojamientoScreen> {
   bool liked;

  _AlojamientoScreenState({this.liked});

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
              /* color: Theme.of(context).cardColor, */
              child: Stack(
                fit: StackFit.loose,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(45)),
                    child: Image.network(
                      widget.alojamiento.foto != null ? 
                        widget.alojamiento.foto 
                        :'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRVX4RgUYvaDyHQaEiejmjMy0ZbuEPqGkOwsxq9oAmPl3MQJIRC&usqp=CAU',
                      fit: BoxFit.cover,
                      height: 425,
                      width: _width,
                    ),
                  ),
                  Align(
                    alignment: Alignment(0.8, 1),
                    child: FavButtonWidget(
                      liked: liked,
                      size: Size.big,
                      onPress: _changeFavorite,
                    ),
                  ),
                  Align(
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
              padding: EdgeInsets.only(right: 15, left: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    /* color: Theme.of(context).cardColor, */
                    padding: EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        CategoryWidget(count: widget.alojamiento.categoria, 
                          size: 30
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(widget.alojamiento.nombre, 
                            style: Theme.of(context).textTheme.headline1 
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
                      ]
                    ),
                  ),
                  SizedBox(height: 40),
                  DetailSectionWidget(
                    title: "Ubicación:",
                    /* margin: false, */
                    child: MapCardWidget(
                      lat: widget.alojamiento.lat,
                      lng: widget.alojamiento.lng,
                    )
                  ),
                  DetailSectionWidget(
                    title: "Calificaciones y reseñas:",
                    /* margin: false, */
                    child: ScoreReviewWidget()
                  ),
                  (liked ? 
                    DetailSectionWidget(
                      title: 'Recuerdos:',
                      child: MemoriesWidget(liked: false),
                      /* margin: false, */
                    )
                  : Container()) 
                ],
              )
            ),
          ],
        ),
      ),
    );
  }
}




/* Container(
  height: _width * 0.8,
  width: _width,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(45)),
    gradient: LinearGradient(
      begin: Alignment.bottomCenter,
      end: Alignment(0, 0),
      colors: [Colors.grey[50], Color.fromRGBO(150, 150, 150, 0.01)]
    )
  ),
), */ */