import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:turismo_app/bloc/bloc.dart';
import 'package:turismo_app/models/models.dart';
import 'package:turismo_app/queries/query_calificacion.dart';
import 'package:turismo_app/widgets/widgets.dart';


class CalificacionScreen extends StatefulWidget {

  final Map<String, Object> selected;
  final int id;
  final Establecimiento type;
  final Calificacion update;

  const CalificacionScreen({
    Key key,
    this.selected,
    @required this.id,
    @required this.type,
    this.update
  }) : super(key: key);

  @override
  _CalificacionScreenState createState() => _CalificacionScreenState();
}

class _CalificacionScreenState extends State<CalificacionScreen> {
  Map<String, Object> selected;
  int destacableSelected;
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.selected != null)
      setState(() {
        selected = widget.selected;
      });

    if (widget.update != null) {
      final Calificacion calificacion = widget.update;
      final puntaje = puntajes.firstWhere(
        (element) => element['id'] == calificacion.puntaje,
      );

      setState(() {
        selected = puntaje;
        destacableSelected = calificacion.destacable?.id;
        _textEditingController.text = calificacion.comentario;
      });
    }
  }

  Widget _getDestacables() {
    return Query(
      options: QueryOptions(
        documentNode: gql(QueryCalificacion.getDestacables)
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
          final destacables = result.data['destacables'];
          return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: destacables.length,
          itemBuilder: (context, index) {
            final item = destacables[index];
              return Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              padding: EdgeInsets.all(5),
              width: 110,
              child: GestureDetector(
                onTap: () => this.setState(() {
                  this.destacableSelected = this.destacableSelected == item['id'] ? null : item['id']; 
                }),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: this.destacableSelected == item['id'] ? Colors.teal[300] : Colors.transparent,
                          width: 5
                        )
                      ),
                    ),
                    Text(item['nombre'],
                      style: TextStyle(
                        fontWeight: this.destacableSelected == item['id'] ? FontWeight.bold : FontWeight.normal
                      ),
                      overflow: TextOverflow.clip,
                      textAlign: TextAlign.center,
                    )
                  ],
                )
              )
            );
          }
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Calificar', 
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.close, color: Colors.white, size: 30.0,), 
            onPressed: () => Navigator.pop(context),
          )
        ),
        body: BlocBuilder<AutenticacionBloc,AutenticacionState>(
          builder: (context, state) {
            if (state is AutenticacionAuthenticated){
              return  SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 30),
                    ( this.selected != null 
                      ? Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Text(selected['label'],
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold,
                            fontSize: 25
                          )
                        ) 
                      )
                      : Container()
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: CalificacionWidget(
                        selected: this.selected != null ? this.selected['id'] : null,
                        onPress: (item) => this.setState(() {
                          this.selected = item; 
                        }),
                      )
                    ),
                    Container(
                      constraints: BoxConstraints(minHeight: 200, maxHeight: 300),
                      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Colors.grey[400],
                          width: 1
                        )
                      ),
                      child: Flex( 
                        direction: Axis.horizontal,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Flexible(
                            child: TextField(
                              textCapitalization: TextCapitalization.sentences,
                              maxLength: 500,
                              controller: _textEditingController,
                              decoration: InputDecoration(
                                hintText: 'Describe tu experiencia',
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                              ),
                              minLines: 9,
                              maxLines: null,
                            ),
                          )
                        ]
                      )
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.all(20),
                      child: Text('¿Qué destacarías?', 
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Container(
                      height: 150,
                      child: _getDestacables()
                    ),
                    Mutation(
                      options: MutationOptions(
                        documentNode: gql(widget.update != null
                          ? QueryCalificacion.updateCalificacion
                          : QueryCalificacion.addCalificacion
                        ),
                        onCompleted: (_) => Navigator.of(context).pop(),
                      ),
                      builder: (RunMutation runMutation, QueryResult result) {

                        return FlatButton(
                          onPressed: () {
                            if (widget.update != null) {
                              runMutation({
                                "calificacionId": widget.update.id,
                                "puntaje": selected['id'],
                                "comentario": _textEditingController.text,
                                "destacableId": destacableSelected
                              });

                            } else {
                              runMutation({
                                "puntaje": selected['id'],
                                "comentario": _textEditingController.text,
                                "usuarioId": state.usuario.id,
                                "alojamientoId": (widget.type == Establecimiento.alojamiento ? widget.id : null),
                                "gastronomicoId": (widget.type == Establecimiento.gastronomico ? widget.id : null),
                                "destacableId": destacableSelected
                              });
                            }
                          },
                          padding: EdgeInsets.zero,
                          textColor: Colors.teal,
                          child: Text('Publicar', 
                            style: TextStyle(
                              fontSize: 16
                            ),
                          )
                        );
                      },
                    )
                  ],
                )
              );
            }

            return Expanded(
              child: Center(
                child: CircularProgressIndicator()
              )
            );
          }
        )
      )
    );
  }
}