import 'package:flutter/material.dart';

import 'package:turismo_app/components/components.dart';
import 'package:turismo_app/models/models.dart';


class DefaultCard extends StatefulWidget{
  const DefaultCard({
    Key key, 
    @required this.name,
    @required this.address,
    @required this.image,
    @required this.onTap,
    @required this.type,
    this.liked = false,
    this.category,
    this.clasification,
    this.specialities,
    this.activities
  }): super(key: key);

  final String name;
  final String address;
  final String image;
  final Function onTap;
  final String type;
  final bool liked;

  final int category;
  final String clasification;

  final List<Especialidad> specialities;
  final List<Actividad> activities;

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
            color: Theme.of(context).cardColor,
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
                    Container(
                      alignment: Alignment.topRight,
                      margin: EdgeInsets.only(top:10, right:10),
                      child: FavButtonWidget(
                        liked: liked ,
                        onPress: _changeFavorite,
                      )
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(top:15, left:10),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
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
                        child: Text(
                          widget.type == 'ALOJAMIENTO' ? 
                            widget.clasification 
                          : widget.activities.map((e) => e.nombre).join(', '), 
                          style: Theme.of(context).accentTextTheme.headline1
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
                      Text(widget.name, 
                        style: Theme.of(context).textTheme.headline2,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5, bottom: 10),
                        child: Text(widget.address ?? 'Sin direccion', 
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headline3
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          ( widget.type == 'ALOJAMIENTO' ?
                              CategoryWidget(count: widget.category)
                            : Container()
                          ),
                          Row(
                            children: <Widget>[
                              Icon(Icons.location_on, color: Theme.of(context).iconTheme.color),
                              Padding(padding: EdgeInsets.only(left:5)),
                              Text('2 km de tu ubicación', 
                                style: Theme.of(context).textTheme.headline3
                              ),
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