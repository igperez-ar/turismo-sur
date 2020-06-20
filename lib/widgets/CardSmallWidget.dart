import 'package:flutter/material.dart';
import 'package:turismo_app/widgets/FavButtonWidget.dart';
import 'package:turismo_app/widgets/CategoryWidget.dart';

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
          width: _width * 0.85,
          height: _width * 0.4,
          margin: EdgeInsets.symmetric(vertical:10),
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
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget> [
                    ClipRRect(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                      child: Container(
                        color: Colors.white,
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
                    ),
                    Container(
                      alignment: Alignment.bottomLeft,
                      margin: EdgeInsets.only(left:10, bottom:10),
                      child: FavButtonWidget(
                        liked: liked,
                        onPress: _changeFavorite,
                      )
                    ),
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
                        Container(
                          margin: EdgeInsets.only(bottom:5),
                          child: Text(widget.clasification, 
                            style: Theme.of(context).accentTextTheme.headline1,
                            maxLines: 1,
                          )
                        ),
                        Text(widget.name, 
                          maxLines: 3, 
                          overflow: TextOverflow.ellipsis, 
                          style: Theme.of(context).textTheme.headline2
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Text(widget.address, 
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.headline3
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: CategoryWidget(count: widget.category)
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