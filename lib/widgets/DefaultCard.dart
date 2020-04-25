import 'package:flutter/material.dart';
import 'package:turismo_app/widgets/Stars.dart';


class DefaultCard extends StatefulWidget{
  const DefaultCard({
    Key key, 
    @required this.title,
    @required this.subtitle,
    @required this.clasification,
    @required this.imgUrl,
    @required this.route,
    this.liked = false
  }): super(key: key);

  final String title;
  final String subtitle;
  final int clasification;
  final String imgUrl;
  final Function route;
  final bool liked;

  @override
  _DefaultCardState createState() => _DefaultCardState(liked: liked);
}


class _DefaultCardState extends State<DefaultCard> {
  bool liked;

  _DefaultCardState({this.liked});

  void _changeFavorite() {
    /* También validar si tiene recuerdos */
    if (liked) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Confirmar'),
            content: Text('Esta acción eliminará los recuerdos añadidos a este lugar.'),
            actions: <Widget>[
              FlatButton(
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
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
    final Width = MediaQuery.of(context).size.width;

    return (
      GestureDetector(
        onTap: widget.route,
        child: Card(
          margin: EdgeInsets.only(top: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))
          ),
          elevation: 5.0,
          child: Container(
            width: Width * 0.90,
            height: Width * 0.60,
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Stack(
                    children: <Widget> [
                      ClipRRect(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                        child: Image.network(
                          widget.imgUrl,
                          fit: BoxFit.cover,
                          height: Width * 0.37,
                          width: Width,
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          width: 40,
                          height: 40,
                          margin: EdgeInsets.only(top: 15, right: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Color.fromRGBO(255, 255, 255, 0.85),
                          ),
                          child: IconButton(
                              icon: Icon(
                                liked ? Icons.favorite : Icons.favorite_border, 
                                color: Colors.teal[300],
                              ), 
                              onPressed: _changeFavorite,
                            ),
                        )
                      )
                    ], 
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.only(left: 12, top: 10, right: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(widget.title, style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600],
                        ),),
                        Text(widget.subtitle, style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.grey[600],
                        ),),
                        Padding(padding: EdgeInsets.only(top: 8)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                              Stars(count: 1),
                              Row(
                                children: <Widget>[
                                  Icon(Icons.location_on, color: Colors.teal[300]),
                                  Text('2 km de tu ubicación', style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.grey[600],
                                  ),),
                                ],
                              )
                          ],
                        )
                      ],
                    ),
                  )
                )
              ],
            ),      
          ),
        ),
      )
    );
  }
}