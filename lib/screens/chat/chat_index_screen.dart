import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:turismo_app/bloc/autenticacion/autenticacion_bloc.dart';
import 'package:turismo_app/models/models.dart';
import 'package:turismo_app/providers/mensaje_provider.dart';
import 'package:turismo_app/providers/providers.dart';
import 'package:turismo_app/queries/queries.dart';
import 'package:turismo_app/queries/query_grupo.dart';
import 'package:turismo_app/screens/screens.dart';

import 'package:turismo_app/widgets/widgets.dart';


class ChatIndexScreen extends StatefulWidget {

  @override
  _ChatIndexScreenState createState() => _ChatIndexScreenState();
}

class _ChatIndexScreenState extends State<ChatIndexScreen> {
  PageController _pageController = PageController(initialPage: 0);
  int _grupoId;

  Widget _buildChatItem(chat) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _grupoId = chat['id'];
        });
        _pageController.jumpToPage(1);
      },
      child: Container(
        height: 60,
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[400]
              ),
              child: Icon(
                Icons.people,
                color: Colors.white,
              ),
            ),
            Expanded(
              child: Container(
                height: 60,
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  border: BorderDirectional(
                    bottom: BorderSide(color: Colors.grey[300], width: 1)
                  )
                ),
                child: Text(chat['nombre'],
                  style: TextStyle(
                    fontSize: 20
                  ),
                )
              )
            )
          ],
        ),
      )
    );
  }

  Widget _buildIndex() {
    return BlocBuilder<AutenticacionBloc,AutenticacionState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                Container(),
                Text('Chats', 
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            centerTitle: true,
            actions: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 10),
                child: IconButton(
                  icon: Icon(Icons.search, color: Colors.white, size: 30.0),
                  onPressed: () {
                    if (state is AutenticacionAuthenticated) {
                      _pageController.jumpToPage(2);
                    }
                  },
                )
              )
            ],
          ),
          body: Builder(
            builder: (context) {
              
              if (state is AutenticacionAuthenticated) {
                return Query(
                  options: QueryOptions(
                    documentNode: gql(QueryGrupo.getAll),
                    variables: {
                      'usuarioId': 1
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

                    final chats = result.data['grupos'];

                    return ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      itemCount: chats.length,
                      itemBuilder: (context, index) {
                        return _buildChatItem(chats[index]); 
                      }
                    );
                  }
                );
              }

              return Expanded(
                child: Center(
                  child: CircularProgressIndicator()
                )
              );
            }
          ) 
        );
      } 
    );
  }

  @override
  Widget build(BuildContext context) {

    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: [
        _buildIndex(),
        ChatScreen(
          grupoId: _grupoId,
          onBack: () => _pageController.jumpToPage(0),
        ),
      ],
    );
  }
}