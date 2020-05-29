import 'package:flutter/material.dart';
import 'package:turismo_app/widgets/FavButton.dart';
import 'package:turismo_app/widgets/Stars.dart';

class SmallCard extends StatefulWidget{
  final String name;
  final String address;
  final String clasification;
  final int category;
  final String image;
  final Function onTap;
  final bool liked;

  const SmallCard({
    Key key, 
    @required this.name,
    @required this.address,
    @required this.clasification,
    @required this.category,
    @required this.image,
    @required this.onTap,
    this.liked = false
  }): super(key: key);

  @override
  _SmallCardState createState() => _SmallCardState(liked: liked);
}


class _SmallCardState extends State<SmallCard> { 
  bool liked;

  _SmallCardState({this.liked});

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
    
    return (
      GestureDetector(
        onTap: widget.onTap,
        child: Container(
          width: _width * 0.8,
          height: _width * 0.4,
          margin: EdgeInsets.symmetric(vertical:10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 5,
                spreadRadius: 1,
                offset: Offset(3, 3)
              )
            ]
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget> [
                    ClipRRect(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                      child: Image.network(
                        widget.image != null ? widget.image : 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRVX4RgUYvaDyHQaEiejmjMy0ZbuEPqGkOwsxq9oAmPl3MQJIRC&usqp=CAU',
                        filterQuality: FilterQuality.low,
                        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
                          if (loadingProgress == null)
                            return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                                  : null,
                            ),
                          );
                        },
                        fit: widget.image != null ? BoxFit.cover : BoxFit.contain
                      ),
                    ),
                    Align(
                      alignment: Alignment(-0.8, 0.9),
                      child: FavButton(
                        liked: liked,
                        onPress: _changeFavorite,
                      )
                    ),
                    Align(
                      alignment: Alignment(-0.8, -0.9),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        /* constraints: BoxConstraints(maxWidth: 130), */
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5,
                              spreadRadius: 2, 
                              offset: Offset(2, 2),
                            )
                          ]
                        ),
                        child: Text(widget.clasification, style: TextStyle(
                            color: Colors.teal[400],
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          maxLines: 2,
                        )
                      )
                    )
                  ], 
                ),
              ),
              Expanded(
                flex: 6,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Stack(
                  children: <Widget>[ 
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(widget.name, 
                          maxLines: 3, 
                          overflow: TextOverflow.ellipsis, 
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Text(widget.address, 
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.grey[600],
                              ),
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Stars(count: widget.category)
                    )  
                  ],
                ),
              )
              ),
            ],
          ),
        ),
      )
    );
  }
}