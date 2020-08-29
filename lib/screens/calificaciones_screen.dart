import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:turismo_app/bloc/bloc.dart';
import 'package:turismo_app/models/models.dart';
import 'package:turismo_app/queries/queries.dart';
import 'package:turismo_app/widgets/widgets.dart';


class CalificacionesScreen extends StatelessWidget {

  final List calificaciones;

  const CalificacionesScreen({
    Key key,
    this.calificaciones
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Calificaciones y reseñas', 
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        /* leading: IconButton(
          icon: Icon(Icons.close, color: Colors.white, size: 30.0,), 
          onPressed: () => Navigator.pop(context),
        ) */
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(20),
        itemCount: calificaciones.length,
        itemBuilder: (context, index) => Column(
          children: [
            (index > 0 
              ? Divider(height: 30, thickness: 1.5, color: Colors.grey[300],)
              : Container()
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: ReviewWidget(
                calificacion: Calificacion.fromJson(calificaciones[index])
              )
            )
          ],
        ),
      )
    );
  }
}