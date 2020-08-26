import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:turismo_app/bloc/autenticacion/autenticacion_bloc.dart';
import 'package:turismo_app/models/models.dart';
import 'package:turismo_app/queries/queries.dart';
import 'package:turismo_app/queries/query_calificacion.dart';
import 'package:turismo_app/widgets/widgets.dart';
import 'package:turismo_app/screens/calificacion_screen.dart';

class ScoreReviewWidget extends StatefulWidget {

  final int id;
  final Establecimiento type;

  const ScoreReviewWidget({
    Key key,
    @required this.id,
    @required this.type
  }) : super(key: key);

  @override
  _ScoreReviewWidgetState createState() => _ScoreReviewWidgetState();
}

class _ScoreReviewWidgetState extends State<ScoreReviewWidget> {
  /* bool _open = false; */
  bool _updated = false;
  Usuario selfUsuario;

  @override
  void initState() {
    super.initState();

    final state = BlocProvider.of<AutenticacionBloc>(context).state;
    if (state is AutenticacionAuthenticated) {
      selfUsuario = state.usuario;
    }
  }

  void _updateState() {
    setState(() {
      _updated = !_updated;
    });
  }

  final List<Map<String, Object>> iconList = [
    {'name': Icons.sentiment_very_dissatisfied,
     'color': Colors.red
    },
    {'name': Icons.sentiment_dissatisfied,
     'color': Colors.orange
    },
    {'name': Icons.sentiment_neutral,
     'color': Colors.yellow
    },
    {'name': Icons.sentiment_satisfied,
     'color': Colors.lightGreen
    },
    {'name': Icons.sentiment_very_satisfied,
     'color': Colors.green
    },
  ];

  Widget _icon(int number, {bool min = true}) {
    return Icon(
      iconList[number-1]['name'],
      color: iconList[number-1]['color'],
      size: (min ? 24 : 65),
    );
  }

  Widget _bar(Icon icon, double count) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          icon,
          SizedBox(width: 5),
          Flexible(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: LinearProgressIndicator(
                value: count,
                backgroundColor: Colors.grey[300],
              )
            )
          )
        ],
      ),
    );
  }

  Widget _buildCalificar(Function onSuccess) {
    return DetailSectionWidget(
      title: "Califica este lugar",
      subtitle: "Comparte tu opinión con otros usuarios",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: CalificacionWidget(
              animation: false,
              onPress: (item) => Navigator.push(context,
                MaterialPageRoute(
                  builder: (context) => CalificacionScreen(
                    id: widget.id,
                    type: widget.type,
                    selected: item,
                  )
                )
              ).then((_) => _updateState()),
            ),
          ),
          FlatButton(
            onPressed: () => Navigator.push(context,
              MaterialPageRoute(
                builder: (context) => CalificacionScreen(
                  id: widget.id,
                  type: widget.type
                )
              )
            ).then((_) => _updateState()),
            padding: EdgeInsets.zero,
            textColor: Colors.teal,
            child: Text('Escribe una reseña', 
              style: TextStyle(
                fontSize: 16
              ),
            )
          )
        ],
      )
    );
  }

  Widget _buildComentario(Calificacion calificacion) {
    return DetailSectionWidget(
      title: 'Tu reseña',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ReviewWidget(
            own: true,
            calificacion: calificacion,
            onDelete: _updateState,
          ),
          SizedBox(height: 10),
          FlatButton(
            onPressed: () => Navigator.push(context,
              MaterialPageRoute(
                builder: (context) => CalificacionScreen(
                  id: widget.id,
                  type: widget.type,
                  update: calificacion,
                )
              )
            ).then((_) => _updateState()),
            padding: EdgeInsets.zero,
            textColor: Colors.teal,
            child: Text('Editar reseña', 
              style: TextStyle(
                fontSize: 16
              ),
            )
          )
        ],
      )
    );
  }

  Widget _getAverage(List calificaciones) {
    final total = calificaciones.length;
    List<Widget> _children = [];

    for (var i = 5; i >= 1; i--) {
      final int count = calificaciones
        .where(
          (element) => element['puntaje'] == i
        )
        .length;
      _children.add(
        _bar(_icon(i), count/total),
      );
    }

    return Column(
      children: _children
    );
  }

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
        documentNode: gql(widget.type == Establecimiento.alojamiento
          ? QueryAlojamiento.getCalificaciones
          : QueryGastronomico.getCalificaciones
        ),
        variables: {
          "establecimientoId": widget.id
        }
      ), 
      builder: (QueryResult result, {VoidCallback refetch, FetchMore fetchMore}) {
        if (result.hasException) {
          return Text(result.exception.toString());
        }

        if (result.loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final List calificaciones = result.data['calificaciones'];

        if (calificaciones.isEmpty) {
          return Column(
            children: [
              _buildCalificar(refetch),
              DetailSectionWidget(
                title: 'Calificaciones y reseñas',
                child: Text('Aún no se publican reseñas.'),
              )
            ],
          );
        }

        return Column(
          children: [
            Builder(
              builder: (context) {

                if (selfUsuario != null) {
                  final jsonCalificacion = calificaciones.singleWhere(
                    (element) => element['usuario']['id'] == selfUsuario.id,
                    orElse: () => null,  
                  );

                  if (jsonCalificacion != null) {
                    Calificacion selfCalificacion = Calificacion.fromJson(jsonCalificacion);
                    return _buildComentario(selfCalificacion);

                  } else {
                    return _buildCalificar(refetch);
                  }
                }

                return Container();
              }
            ),
            DetailSectionWidget(
              title: "Calificaciones y reseñas",
              child: Flex(
                direction: Axis.vertical,
                children: <Widget>[ 
                    Container(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Column(
                              children: <Widget>[
                                _icon(5, min:false),
                                SizedBox(height: 5),
                                Text(calificaciones.length.toString(),
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 16
                                  ),
                                )
                              ],
                            )
                          ),
                          Expanded(
                            flex: 3,
                            child: _getAverage(calificaciones),
                          )
                        ],
                      )
                    ),
                    SizedBox(height: 10),
                    Column(
                      children: calificaciones.map<Widget>((e) {
                        if (selfUsuario == null || e['usuario']['id'] != selfUsuario.id)
                          return Column(
                            children: [
                              Divider(height: 30, thickness: 1.5, color: Colors.grey[300],),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: ReviewWidget(
                                  calificacion: Calificacion.fromJson(e)
                                )
                              )
                            ],
                          );

                        return Container();
                      }).toList(),
                    )
                  ],
              )
            )
          ],
        );
      }
    );
  }
}