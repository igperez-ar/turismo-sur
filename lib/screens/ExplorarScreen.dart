import 'package:flutter/material.dart';
import 'package:turismo_app/models/Alojamiento.dart';

import 'package:turismo_app/screens/AlojamientoScreen.dart';
import 'package:turismo_app/screens/FiltrosScreen.dart';
import 'package:turismo_app/widgets/CardWidget.dart';
import 'package:turismo_app/widgets/SearchBarWidget.dart';

class ExplorarScreen extends StatelessWidget {
  final Future<List<Alojamiento>> alojamientos;
  ExplorarScreen({Key key, this.alojamientos}) : super(key:key);


  Widget getAlojamientos(items) {
    return ListView.builder(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
      itemCount: items.length, 
      itemBuilder: (context, index) { 
        return DefaultCard(
          name: items[index].nombre,
          address: items[index].domicilio,
          image: items[index].foto,
          category: items[index].categoria,
          clasification: items[index].clasificacion.nombre,
          onTap: () => Navigator.push(context,
            MaterialPageRoute(
              builder: (context) => AlojamientoScreen(alojamiento: items[index])
            )
          ),
        ); 
      },
    );
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Explorar', 
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.filter_list, color: Colors.white, size: 30.0,), 
            onPressed: () => Navigator.pushNamed(context, '/filtros'),
          )
        ],
      ),
      body: Column(
          children: <Widget>[
            /* Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: SearchBar(),
            ), */
            Expanded(
              child:FutureBuilder<List<Alojamiento>>(
                future: alojamientos, builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.error); 
                  return snapshot.hasData ? getAlojamientos(snapshot.data) 
                  
                  : Center(child: CircularProgressIndicator()); 
                },
              ),
            )
          ],
      ),
    );
  }
}