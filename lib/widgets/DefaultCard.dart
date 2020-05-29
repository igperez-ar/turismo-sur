/* import 'package:flutter/material.dart';
import 'package:turismo_app/widgets/FavButton.dart';
import 'package:turismo_app/widgets/Stars.dart';


class DefaultCard extends StatefulWidget{
  const DefaultCard({
    Key key, 
    @required this.name,
    @required this.address,
    @required this.category,
    @required this.clasification,
    @required this.image,
    @required this.onTap,
    this.liked = false
  }): super(key: key);

  final String name;
  final String address;
  final int category;
  final String clasification;
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
        child: Container(
          width: _width * 0.90,
          height: _width * 0.65,
          margin: EdgeInsets.only(top:20),
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
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget> [
                    ClipRRect(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
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
                        fit: BoxFit.cover,
                      ),
                    ),
                    Align(
                      alignment: Alignment(0.9, -0.75),
                      child: FavButton(
                        liked: liked ,
                        onPress: _changeFavorite,
                      )
                    ),
                    Align(
                      alignment: Alignment(-0.9, -0.7),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                          fontSize: 15
                        ),)
                      )
                    )
                  ], 
                ),
              ),
              Flexible(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Stack(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(widget.name, style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5, bottom: 10),
                            child: Text(widget.address, 
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                              Stars(count: widget.category),
                              Row(
                                children: <Widget>[
                                  Icon(Icons.location_on, color: Colors.teal[300]),
                                  Padding(padding: EdgeInsets.only(left:5)),
                                  Text('2 km de tu ubicación', style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.grey[600],
                                  ),),
                                ],
                              )
                          ],
                        )
                      )
                    ]
                  )
                )
              )
            ],
          ),      
        ),
      )
    );
  }
} */
import 'package:flutter/material.dart';
import 'package:turismo_app/widgets/FavButton.dart';
import 'package:turismo_app/widgets/Stars.dart';


class DefaultCard extends StatefulWidget{
  const DefaultCard({
    Key key, 
    @required this.name,
    @required this.address,
    @required this.category,
    @required this.clasification,
    @required this.image,
    @required this.onTap,
    this.liked = false
  }): super(key: key);

  final String name;
  final String address;
  final int category;
  final String clasification;
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
        child: Container(
          margin: EdgeInsets.only(top:20),
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[ 
              Container(
                width: _width,
                height: _width * 0.4,
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[ 
                    ClipRRect(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
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
                      alignment: Alignment(0.9, -0.75),
                      child: FavButton(
                        liked: liked ,
                        onPress: _changeFavorite,
                      )
                    ),
                    Align(
                      alignment: Alignment(-0.9, -0.7),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                            fontSize: 15
                          ),
                        )
                      )
                    )
                  ]
                )
              ),
              Flexible(
                fit: FlexFit.loose,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(widget.name, style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5, bottom: 10),
                        child: Text(widget.address, 
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16.0,
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
                              Padding(padding: EdgeInsets.only(left:5)),
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
                ),
              )
            ]
          )
        )
      )
    );
  }
}