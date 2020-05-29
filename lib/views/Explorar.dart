import 'package:flutter/material.dart';
import 'package:turismo_app/models/Alojamiento.dart';

import 'package:turismo_app/views/Alojamiento.dart' as View;
import 'package:turismo_app/views/Filtros.dart';
import 'package:turismo_app/widgets/DefaultCard.dart';

class Explorar extends StatelessWidget {
  final Future<List<Alojamiento>> alojamientos;
  Explorar({Key key, this.alojamientos}) : super(key:key);


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
              builder: (context) => View.Alojamiento(alojamiento: items[index])
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
          textAlign: TextAlign.center, 
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.filter_list, color: Colors.white, size: 30.0,), 
            onPressed: () => Navigator.pushNamed(context, '/filtros'),
          )
        ],
        centerTitle: true,
        backgroundColor: Colors.teal[300],
      ),
      body: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 25, right: 15, left: 15, bottom: 20),
              padding: EdgeInsets.only(left: 20, right: 10),
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: TextField(
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        hintText: '¿Qué estás buscando?',
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                    )
                  ),
                  IconButton(
                    icon: Icon(Icons.search, color: Colors.teal[300], size: 30,),
                    onPressed: null
                  )
                ],
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[300],
                    blurRadius: 5,
                    spreadRadius: 2, 
                    offset: Offset(2, 2),
                  )
                ],
              ),
            ),
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
      backgroundColor: Colors.grey[50],
    );
  }
}