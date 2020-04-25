import 'package:flutter/material.dart';
import 'package:turismo_app/views/Alojamiento.dart';
import 'package:turismo_app/views/Filtros.dart';
import 'package:turismo_app/widgets/DefaultCard.dart';

class Explorar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final Width = MediaQuery.of(context).size.width;
    final Height = MediaQuery.of(context).size.height;
    
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
      body: Center(
        child: ListView(
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
            DefaultCard(
              title: 'Hotel Mónaco',
              subtitle: 'San Martín 1335',
              imgUrl: 'https://suit.tur.ar/archivos/read/366/mdc',
              clasification: 1,
              route: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Alojamiento())
              )
            ),
          ],
        ),
      ),
      backgroundColor: Color.fromRGBO(238, 238, 242, 1),
    );
  }
}