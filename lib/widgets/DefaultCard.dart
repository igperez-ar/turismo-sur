import 'package:flutter/material.dart';
import 'package:turismo_app/widgets/Stars.dart';


class DefaultCard extends StatefulWidget{
  const DefaultCard({
    Key key, 
    @required this.name,
    @required this.address,
    @required this.category,
    @required this.image,
    @required this.onTap,
    this.liked = false
  }): super(key: key);

  final String name;
  final String address;
  final int category;
  final String image;
  final Function onTap;
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
    final _width = MediaQuery.of(context).size.width;

    return (
      GestureDetector(
        onTap: widget.onTap,
        child: Card(
          margin: EdgeInsets.only(top: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))
          ),
          elevation: 5.0, 
          child: Container(
            width: _width * 0.90,
            height: _width * 0.65,
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget> [
                      ClipRRect(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                        child: Image.network(
                          widget.image != null ? widget.image : 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRVX4RgUYvaDyHQaEiejmjMy0ZbuEPqGkOwsxq9oAmPl3MQJIRC&usqp=CAU',
                          fit: BoxFit.cover,
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
                            color: Color.fromRGBO(255, 255, 255, 0.90),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 3,
                                spreadRadius: 2, 
                                offset: Offset(2, 2),
                              )
                            ],
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
                        Text(widget.name, style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600],
                        ),),
                        Padding(
                          padding: EdgeInsets.only(top: 5, bottom: 10),
                          child: Text(widget.address, 
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                              Stars(count: widget.category),
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