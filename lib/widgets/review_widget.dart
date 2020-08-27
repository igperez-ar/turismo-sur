import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';

import 'package:turismo_app/models/models.dart';
import 'package:turismo_app/queries/queries.dart';
import 'package:turismo_app/widgets/widgets.dart';

class ReviewWidget extends StatefulWidget {

  final Calificacion calificacion;
  final bool own;
  final Function onDelete;

  const ReviewWidget({
    Key key,
    @required this.calificacion,
    this.own = false,
    this.onDelete
  }) : super(key: key);

  @override
  _ReviewWidgetState createState() => _ReviewWidgetState();
}

class _ReviewWidgetState extends State<ReviewWidget> {
  /* bool isUseful = false;
  bool isUseless = false; */
  String createdAt;

  Calificacion get calificacion => widget.calificacion; 

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

  /* _changeUseful() {
    if (this.isUseful) 
      this.setState(() { 
        isUseful = false;
      }); 
    else
      this.setState(() { 
        isUseful = true;
        isUseless = false;
      });
  }

  _changeUseless() {
    if (this.isUseless) 
      this.setState(() { 
        isUseless = false;
      }); 
    else
      this.setState(() { 
        isUseless = true;
        isUseful = false;
      });
  } */

  @override
  void initState() {
    super.initState();

    DateTime date = DateTime.parse(calificacion.createdAt);
    createdAt = DateFormat('dd/mm/yy').format(date);
  }

  Widget _icon(int number, {bool min = true}) {
    return Icon(
      iconList[number-1]['name'],
      color: iconList[number-1]['color'],
      size: (min ? 24 : 65),
    );
  }

  @override
  Widget build(BuildContext context) {
    
    return Container(
      /* margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 10), */
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          /* Divider(height: 30, thickness: 1.5, color: Colors.grey[300],), */
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  /* ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: SvgPicture.network('https://image.flaticon.com/icons/svg/3011/3011279.svg',
                      height: 45,
                      width: 45,
                    )
                  ), */
                  ProfileImage(
                    image: calificacion.usuario.foto, 
                    size: ProfileImageSize.small
                  ),
                  SizedBox(width: 20),
                  Text(calificacion.usuario.username, style: Theme.of(context).textTheme.headline4
                  )
                ]
              ),
              (widget.own 
                ? Mutation(
                    options: MutationOptions(
                      documentNode: gql(QueryCalificacion.deleteCalificacion)
                    ),
                    builder: (RunMutation deleteCalificacion, QueryResult result) {
                      return PopupMenuButton(
                        icon: Icon(Icons.more_vert, color: Colors.grey[400]),
                        onSelected: (value) {
                          deleteCalificacion({
                            'calificacionId': widget.calificacion.id
                          });
                          if (widget.onDelete != null)
                            widget.onDelete();
                        },
                        itemBuilder: (context) => <PopupMenuEntry>[
                          const PopupMenuItem(
                            value: 1,
                            child: Text('Eliminar'),
                          ),
                        ],
                      );
                    },
                  )
                : Container()
              ),
              /* Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.thumb_up, color: (this.isUseful ? Colors.lightGreen : Colors.grey[400])),
                    onPressed: _changeUseful
                  ),
                  IconButton(
                    icon: Icon(Icons.thumb_down, color: (this.isUseless ? Colors.red : Colors.grey[400])),
                    onPressed: _changeUseless
                  )
                ],
              ) */
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: <Widget>[
              _icon(calificacion.puntaje),
              SizedBox(width: 5),
              Text(createdAt, style: Theme.of(context).textTheme.headline3)
            ],
          ),
          SizedBox(height: 10),
          Text(calificacion.comentario,
            style: Theme.of(context).textTheme.bodyText2,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}