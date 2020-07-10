import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_app/bloc/bloc.dart';
import 'package:turismo_app/components/components.dart';
import 'package:turismo_app/models/models.dart';
import 'package:turismo_app/screens/screens.dart';


class SmallCard extends StatefulWidget{
  /* final int id; */
  final Establecimiento type;
  final establecimiento;
  /* final String name;
  final String address;
  final String image;
  final Function onTap;
  final bool liked;

  final String clasification;
  final int category;

  final List<Especialidad> specialities;
  final List<Actividad> activities; */

  const SmallCard({
    Key key, 
    /* this.id, */
    @required this.type,
    @required this.establecimiento,
    /* @required this.name,
    @required this.address,
    @required this.image,
    @required this.onTap,
    this.liked = false,
    this.clasification,
    this.category,
    this.activities,
    this.specialities */
  }): super(key: key);

  @override
  _SmallCardState createState() => _SmallCardState(/* liked: liked */);
}

class _SmallCardState extends State<SmallCard> { 
  /* FavoritosBloc _favoritoBloc; */
  bool liked;

  /* _SmallCardState({this.liked}); */

  @override 
  void initState() {
    super.initState();

    /* _favoritoBloc = BlocProvider.of<FavoritosBloc>(context);

    if (_favoritoBloc.state is FavoritosSuccess) {
      if ((_favoritoBloc.state as FavoritosSuccess)
            .favoritos
            .any((element) => element.id == widget.establecimiento.id 
                          && element.tipo == widget.type
            )
      ){
        this.setState(() {
          liked = true;
        });
                
      } else {
        this.setState(() {
          liked = false;
        }); 
      }       
    }*/
  }

  /* void _changeFavorite() {
    final Favorito _favorito = Favorito(
      id: widget.establecimiento.id, 
      tipo: widget.type,
      recuerdos: []
    );
    
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
                  _favoritoBloc.add(RemoveFavorito(_favorito));
                  setState(() {
                    liked = false;
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    } else {
      _favoritoBloc.add(AddFavorito(_favorito));
      setState(() {
        liked = true;
      });
    }
  } */

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
                      /* liked: liked,
                      onPress: _changeFavorite, */
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