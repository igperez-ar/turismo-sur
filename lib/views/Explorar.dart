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
          category: items[index].categoriaId != 6 ? items[index].categoriaId : 0,
          onTap: () => Navigator.push(context,
            MaterialPageRoute(
              builder: (context) => View.Alojamiento(alojamiento: items[index])
            )
          ),
        ); 
      },
    );

    /* return ListView(
      padding: EdgeInsets.all(20),
      children: <Widget>[ 
        Container(
          child: Padding(
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
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
        ),
        ListView.builder(
          itemCount: items.length, 
          itemBuilder: (context, index) { 
            return DefaultCard(
              title: items[index].nombre,
              subtitle: 'San Martín 1335',
              imgUrl: 'https://suit.tur.ar/archivos/read/366/mdc',
              clasification: 1,
              route: () => MaterialPageRoute( 
                builder: (context) => View.Alojamiento()
            )
            ); 
          },
        )
      ],
    ); */
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
      backgroundColor: Color.fromRGBO(238, 238, 242, 1),
    );
  }
}