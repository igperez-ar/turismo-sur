import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:turismo_app/bloc/autenticacion/autenticacion_bloc.dart';
import 'package:turismo_app/queries/queries.dart';
import 'package:turismo_app/queries/query_grupo.dart';

import 'package:turismo_app/widgets/widgets.dart';


class ChatScreen extends StatefulWidget {
  final int grupoId; 
  final Function onBack;

  const ChatScreen({
    Key key,
    this.grupoId = 1,
    this.onBack
  }) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  Map grupo;

  @override
  void dispose() {
    _scrollController.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: (grupo != null
          ? Row(
              children: [
                Container(),
                Text(grupo['nombre'], 
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )
          : Container()
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 30.0,), 
          onPressed: widget.onBack,
        ),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10),
            child: DropdownButton(
              icon: Icon(Icons.more_vert, color: Colors.white, size: 30.0), 
              items: [
                DropdownMenuItem(child: Text('Info. del grupo')),
                DropdownMenuItem(child: Text('Salir del grupo')),
              ],
              underline: Container(),
              selectedItemBuilder: (context) => [Container(width: 110)],
              itemHeight: 60,
              onChanged: (value) {},
            )
          )
        ],
      ),
      body: Query(
        options: QueryOptions(
          documentNode: gql(QueryGrupo.getOne),
          variables: {
            'grupo': widget.grupoId
          },
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

          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              setState(() {
                grupo = result.data['grupos'].first;
              });
            }
          });

          return BlocBuilder<AutenticacionBloc,AutenticacionState>(
            builder: (context, state) {

              if (state is AutenticacionAuthenticated && grupo != null) {
                final selfMiembro = (grupo['miembros'] as List).firstWhere((element) => element['usuario']['id'] == state.usuario.id);
                
                return Flex(
                  direction: Axis.vertical,
                  children: <Widget>[
                    Subscription(
                      'getAll',
                      QueryMensajes.getAll,
                      variables: {'grupo': 1},
                      builder: ({
                        bool loading,
                        dynamic payload,
                        dynamic error,
                      }) {
                        if (payload != null) {
                          List mensajes = payload['mensajes'];

                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            if (_scrollController.hasClients) {
                              _scrollController.animateTo(
                                _scrollController.position.maxScrollExtent,
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeOut,
                              );
                            }
                          });

                          return Expanded(
                            child: ListView.builder(
                              controller: _scrollController,
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              itemCount: mensajes.length,
                              itemBuilder: (context, index) {
                                
                                return MessageWidget(
                                  name: (mensajes[index]['miembro']['usuario']['id'] == state.usuario.id ? null : mensajes[index]['miembro']['usuario']['username']),
                                  message: mensajes[index]['contenido'],
                                  first: (index > 0 
                                    ? (mensajes[index-1]['miembro']['id'] != mensajes[index]['miembro']['id'])
                                    : true
                                  ),
                                );  
                              })
                          );

                        } else {
                          return Expanded(
                            child: Center(
                              child: CircularProgressIndicator()
                            )
                          );
                        }
                      }
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        constraints: BoxConstraints(minHeight: 45, maxHeight: 150),
                        margin: EdgeInsets.only(right: 10, left: 10, top: 10, bottom: 15),
                        padding: EdgeInsets.only(left: 20),
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: Flex( 
                          direction: Axis.horizontal,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Flexible(
                              child: TextField(
                                textCapitalization: TextCapitalization.sentences,
                                controller: _textEditingController,
                                decoration: InputDecoration(
                                  hintText: 'Escribe un mensaje',
                                  hintStyle: TextStyle(color: Colors.grey[800]),
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                ),
                                minLines: 1,
                                maxLines: 6,
                              ),
                            ),
                            Mutation(
                              options: MutationOptions(
                                documentNode: gql(QueryMensajes.addMensaje),
                              ),
                              builder: (RunMutation addMensaje, QueryResult result) {
                                
                                return IconButton(
                                  icon: Icon(Icons.send, color: Colors.grey[800],),
                                  onPressed: () {
                                    if (_textEditingController.text.trim().isNotEmpty) {
                                      addMensaje({
                                        'contenido': _textEditingController.text, 
                                        'grupo': widget.grupoId, 
                                        'miembro': selfMiembro['id']
                                      });
                                      _textEditingController.clear();
                                    }
                                  }
                                );
                              },
                            )
                          ]
                        )
                      )
                    )
                  ]
                );
              }

                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            );
        }
      )
    );
  }
}