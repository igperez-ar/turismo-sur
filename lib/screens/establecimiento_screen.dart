import 'package:dashed_container/dashed_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_app/bloc/bloc.dart';
import 'package:turismo_app/widgets/widgets.dart';
import 'package:turismo_app/models/models.dart';

class EstablecimientoScreen extends StatefulWidget {
   final establecimiento;
   final Establecimiento type;

  const EstablecimientoScreen({
    Key key, 
    this.establecimiento,
    this.type,
  }): super(key: key);

  @override
  _EstablecimientoScreenState createState() => _EstablecimientoScreenState();
}

class _EstablecimientoScreenState extends State<EstablecimientoScreen> {

  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;

  @override
  void initState() {
    _scrollController.addListener(_listenToScrollChange);
    super.initState();
  }

  void _listenToScrollChange() {
    if (_scrollController.offset >= 350.0) {
      setState(() {
        _isScrolled = true;
      });
    } else {
      setState(() {
        _isScrolled = false;
      });
    }
  }

  List<Widget> _getWidget() {
    Widget _getChip(String title) => Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 2,
            spreadRadius: 1, 
            offset: Offset(2, 2),
          )
        ]
      ),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 15
        )
      ),
    );

    if (widget.type == Establecimiento.alojamiento) {
      if (widget.establecimiento.clasificacion != null &&
          widget.establecimiento.clasificacion != '')
        return [_getChip(widget.establecimiento.clasificacion.nombre)];

    } else {
      if (widget.establecimiento.actividades.isNotEmpty) {
        return widget.establecimiento.actividades.map<Widget>(
          (actividad) => _getChip(actividad.nombre)
        ).toList();
      }
    }

    return [];
  }

  Widget _checkItem(String title) {
    final _width = MediaQuery.of(context).size.width;

    return Container(
      width: _width / 2.5,
      child: Row(
        children: <Widget>[
          Container(
            width: 25,
            height: 25,
            margin: EdgeInsets.only(right: 10),
            decoration: BoxDecoration( 
              color: Colors.teal[300],
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 2,
                  spreadRadius: 1, 
                  offset: Offset(1, 1),
                )
              ],
            ) 
          ),
          Expanded(
            child: Text(
              title,
              overflow: TextOverflow.clip,
            )
          )
        ],
      )
    );  
  }

  Widget _getEspecialidades() {
    double _width = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.only(bottom: 50),
      child: Column(
        children: [
          Text(
            'Especialidades'.toUpperCase(),
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: Colors.grey[600],
              /* fontStyle: FontStyle.italic */
            ),
          ),
          SizedBox(height: 15),
          DashedContainer(
            dashColor: Colors.grey[400], 
            strokeWidth: 2,
            dashedLength: 10,
            blankLength: 10,
            borderRadius: 20,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              width: _width,
              child: Wrap(
                runSpacing: 12,
                spacing: 10,
                children: 
                  widget.establecimiento.especialidades.map<Widget>(
                    (esp) => _checkItem(esp.nombre)
                  ).toList()
              ),
            ),
          )
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;

    /* return Material(
      child: CustomScrollView(
      controller: _scrollController,
      slivers: <Widget>[
        SliverAppBar(
          expandedHeight: 450.0,
          pinned: true,
          title: AnimatedOpacity(
            duration: Duration(milliseconds: 300),
            opacity: _isScrolled ? 1.0 : 0.0,
            curve: Curves.ease,
            child: Text('Las Hayas'),
          ),
          flexibleSpace: FlexibleSpaceBar(
            background: Image.network(
              widget.establecimiento.foto != null ? 
                widget.establecimiento.foto 
                :'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRVX4RgUYvaDyHQaEiejmjMy0ZbuEPqGkOwsxq9oAmPl3MQJIRC&usqp=CAU',
              fit: BoxFit.cover,
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            /* Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.vertical( 
                  top: Radius.circular(30)
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    spreadRadius: 1,
                    offset: Offset(0, -2)
                  )
                ]
              ),
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                     */Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 20, bottom: 20),
                          constraints: BoxConstraints(maxWidth: 280),
                          child: Wrap(
                            spacing: 5,
                            runSpacing: 5,
                            children: _getWidget()
                          ),
                        ),
                        SizedBox(
                          height: 60,
                          child: FavButtonWidget(
                            id: widget.establecimiento.id,
                            type: widget.type,
                            size: Size.big
                          ),
                        ),
                      ],
                    ), 
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(widget.establecimiento.nombre, 
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                    ( widget.type == Establecimiento.alojamiento
                      ? Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: CategoryWidget(count: widget.establecimiento.categoria.valor, 
                            size: 30
                          )
                      )
                      : Container()
                    ),
                    Divider(thickness: 1.5, height: 10),
                    SizedBox(height: 40),
                    ( widget.type == Establecimiento.gastronomico &&
                      widget.establecimiento.especialidades.isNotEmpty
                      ? _getEspecialidades()
                      : Container()
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
                          child: Text(
                            widget.establecimiento.domicilio ?? 'Sin dirección', 
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 17
                            ),
                            overflow: TextOverflow.clip,
                          )
                        )
                      ]
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      child: MapCardWidget(
                        type: widget.type,
                        lat: widget.establecimiento.lat,
                        lng: widget.establecimiento.lng
                      )
                    ),
                    SizedBox(height: 40),
                    ScoreReviewWidget(),
                    MemoriesWidget(
                      id: widget.establecimiento.id,
                      type: widget.type,
                    )
                  ],
                ), 
              ),
          ])
        /* )
      ], */
    ); */
    
    return Scaffold(
      body: Stack(
        children: [
          Image.network(
            widget.establecimiento.foto != null ? 
              widget.establecimiento.foto 
              :'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRVX4RgUYvaDyHQaEiejmjMy0ZbuEPqGkOwsxq9oAmPl3MQJIRC&usqp=CAU',
            fit: BoxFit.cover,
            height: 450,
          ),
          ListView(
            controller: _scrollController,
            children: <Widget>[ 
              Container( 
                height: 400.0,
                child: Stack(
                  fit: StackFit.loose,
                  children: <Widget>[
                    /* Image.network(
                      widget.establecimiento.foto != null ? 
                        widget.establecimiento.foto 
                        :'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRVX4RgUYvaDyHQaEiejmjMy0ZbuEPqGkOwsxq9oAmPl3MQJIRC&usqp=CAU',
                      fit: BoxFit.cover,
                      height: 450,
                      width: _width,
                    ), */
                    /* Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 2,
                                  spreadRadius: 2,
                                  offset: Offset(2, 2)
                                )
                              ]
                            ),
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              icon: Icon(
                                Icons.arrow_back, 
                                color: Theme.of(context).textTheme.headline3.color, 
                                size: 35
                              ),
                              onPressed: () => Navigator.pop(context)
                            )
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 2,
                                  spreadRadius: 2,
                                  offset: Offset(2, 2)
                                )
                              ]
                            ),
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              icon: Icon(
                                Icons.share, 
                                color: Theme.of(context).textTheme.headline3.color, 
                                size: 30
                              ),
                              onPressed: () => Navigator.pop(context)
                            )
                          )
                        ],
                      ),
                    ), */
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.vertical( 
                    top: Radius.circular(30)
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      spreadRadius: 1,
                      offset: Offset(0, -2)
                    )
                  ]
                ),
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 20, bottom: 20),
                          constraints: BoxConstraints(maxWidth: 280),
                          child: Wrap(
                            spacing: 5,
                            runSpacing: 5,
                            children: _getWidget()
                          ),
                        ),
                        SizedBox(
                          height: 60,
                          child: FavButtonWidget(
                            id: widget.establecimiento.id,
                            type: widget.type,
                            size: Size.big
                          ),
                        ),
                      ],
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(widget.establecimiento.nombre, 
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                    ( widget.type == Establecimiento.alojamiento
                      ? Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: CategoryWidget(count: widget.establecimiento.categoria.valor, 
                            size: 30
                          )
                      )
                      : Container()
                    ),
                    Divider(thickness: 1.5, height: 10),
                    SizedBox(height: 40),
                    ( widget.type == Establecimiento.gastronomico &&
                      widget.establecimiento.especialidades.isNotEmpty
                      ? _getEspecialidades()
                      : Container()
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
                          child: Text(
                            widget.establecimiento.domicilio ?? 'Sin dirección', 
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 17
                            ),
                            overflow: TextOverflow.clip,
                          )
                        )
                      ]
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      child: MapCardWidget(
                        type: widget.type,
                        lat: widget.establecimiento.lat,
                        lng: widget.establecimiento.lng
                      )
                    ),
                    SizedBox(height: 40),
                    ScoreReviewWidget(
                      id: widget.establecimiento.id,
                      type: widget.type,
                    ),
                    MemoriesWidget(
                      id: widget.establecimiento.id,
                      type: widget.type,
                    )
                  ],
                ),
              ),
            ],
          ),
          Container(
            height: 85,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
            )
          ),
          AnimatedOpacity(
            duration: Duration(milliseconds: 500),
            opacity: _isScrolled ? 1.0 : 0.0,
            curve: Curves.ease,
            child: Container(
              height: 85,
              child: AppBar(
                title: Text(widget.establecimiento.nombre),
              )
            ),
          ),
        ],
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
), */