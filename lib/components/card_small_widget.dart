import 'package:flutter/material.dart';
import 'package:turismo_app/components/components.dart';
import 'package:turismo_app/models/models.dart';
import 'package:turismo_app/screens/screens.dart';


class SmallCard extends StatefulWidget{

  final Establecimiento type;
  final establecimiento;

  const SmallCard({
    Key key, 
    @required this.type,
    @required this.establecimiento,
  }): super(key: key);

  @override
  _SmallCardState createState() => _SmallCardState();
}

class _SmallCardState extends State<SmallCard> { 

  Widget _getWidget() {
    if (widget.type == Establecimiento.alojamiento)
      return Container(
        margin: EdgeInsets.only(bottom:5),
        child: Text(
          widget.establecimiento.clasificacion.nombre, 
          style: Theme.of(context).accentTextTheme.headline1,
          maxLines: 1,
        )
      );
                        
    if (widget.establecimiento.actividades.isNotEmpty) {
      var more = widget.establecimiento.actividades.length - 1;
      return Container(
        margin: EdgeInsets.only(bottom:5),
        child: Text(
          widget.establecimiento.actividades[0].nombre + (more > 0 ? '  |  +$more' : ''), 
          style: Theme.of(context).accentTextTheme.headline1,
          maxLines: 1,
        )
      );
    }

    return Container();
  }
  
  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
      onTap: () => Navigator.push(context,
        MaterialPageRoute(
          builder: (context) => EstablecimientoScreen(
            type: widget.type,
            establecimiento: widget.establecimiento
          )
        )
      ),
      child: Container(
        height: 150,
        margin: EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              spreadRadius: 1,
              offset: Offset(2, 2)
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
                        widget.establecimiento.foto != null ? widget.establecimiento.foto : 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRVX4RgUYvaDyHQaEiejmjMy0ZbuEPqGkOwsxq9oAmPl3MQJIRC&usqp=CAU',
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
                        fit: widget.establecimiento.foto != null ? BoxFit.cover : BoxFit.contain
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment(-1, -1),
                    child: FavButtonWidget(
                      id: widget.establecimiento.id,
                      type: widget.type,
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
                      _getWidget(),
                      Text(widget.establecimiento.nombre, 
                        maxLines: 3, 
                        overflow: TextOverflow.ellipsis, 
                        style: Theme.of(context).textTheme.headline2
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Text(widget.establecimiento.domicilio ?? 'Sin dirección', 
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headline3
                        ),
                      ),
                    ],
                  ),
                  ( widget.type == Establecimiento.alojamiento ?
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: CategoryWidget(count: widget.establecimiento.categoria.valor)
                      )
                    : Container() 
                  ) 
                ],
              ),
            )
            ),
          ],
        ),
      ),
    );
  }
}