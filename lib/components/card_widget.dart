import 'package:flutter/material.dart';
import 'package:turismo_app/components/components.dart';
import 'package:turismo_app/models/models.dart';
import 'package:turismo_app/screens/screens.dart';


class DefaultCard extends StatefulWidget{
  
  final establecimiento;
  final Establecimiento type;
  final Future<String> distance;

  const DefaultCard({
    Key key, 
    @required this.establecimiento,
    @required this.type,
    this.distance
  }): super(key: key);

  @override
  _DefaultCardState createState() => _DefaultCardState();
}


class _DefaultCardState extends State<DefaultCard> {
  bool liked;
  String distance;

  @override
  void initState() {
    super.initState();

    _updateDistance();
  }

  void _updateDistance() async {
    String newDistance = await widget.distance;

    if (mounted)
      setState(() {
        distance = newDistance;
      });
  }

  Widget _getWidget() {
    Widget _getChip(child) => Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.only(top:10, left:10),
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
        child: child,
      )
    );

    if (widget.type == Establecimiento.alojamiento)
      return _getChip(
        Text(
          widget.establecimiento.clasificacion.nombre,
          style: Theme.of(context).accentTextTheme.headline1
        )
      );
    
    if (widget.establecimiento.actividades.isNotEmpty) {
      var more = widget.establecimiento.actividades.length;
      
      if (more > 1) {
        more = more - 2;
        return _getChip( 
          Text(
          (widget.establecimiento.actividades[0].nombre + ', ' + 
            widget.establecimiento.actividades[1].nombre + (more > 0 ? '  |  +$more' : '')),
            style: Theme.of(context).accentTextTheme.headline1
          )
        );
      }
      
      return _getChip( 
        Text(
          widget.establecimiento.actividades[0].nombre,
          style: Theme.of(context).accentTextTheme.headline1
        )
      );
    }

    return Container();
  }
  
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;

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
        margin: EdgeInsets.only(top:20),
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
                  Align(
                    alignment: Alignment(0.95, -1),
                    child: FavButtonWidget(
                      id: widget.establecimiento.id,
                      type: widget.type,
                    )
                  ),
                  _getWidget()
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
                    Text(widget.establecimiento.nombre, 
                      style: Theme.of(context).textTheme.headline2,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5, bottom: 10),
                      child: Text(widget.establecimiento.localidad.nombre ?? 'Sin direccion', 
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headline3
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        ( widget.type == Establecimiento.alojamiento ?
                            CategoryWidget(count: widget.establecimiento.categoria.valor)
                          : Container()
                        ),
                        Row(
                          children: <Widget>[
                            Icon(Icons.location_on, color: Theme.of(context).iconTheme.color),
                            Padding(padding: EdgeInsets.only(left:5)),
                            Text(
                              distance ?? 'Cargando...',
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
    );
  }
}