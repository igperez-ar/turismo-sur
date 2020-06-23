import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_app/bloc/bloc.dart';
import 'package:turismo_app/models/Alojamiento.dart';

import 'package:turismo_app/screens/screens.dart';
import 'package:turismo_app/components/components.dart';

class ExplorarScreen extends StatelessWidget {

  Widget _getCardList(items) {
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
      body: BlocBuilder<AlojamientoBloc, AlojamientoState>(
          builder: (context, state) {
            if (state is AlojamientoInitial) {
              BlocProvider.of<AlojamientoBloc>(context).add(FetchAlojamientos());
            }

            if (state is AlojamientoFailure) {
              return Center(
                child: Text('failed to fetch alojamientos')
              );
            }

            if (state is AlojamientoSuccess) {
              if (state.alojamientos.isEmpty) {
                return Center(
                  child: Text('alojamientos VACIO')
                );
              }

              return _getCardList(state.alojamientos);
            }
          
            return Center(
              child: CircularProgressIndicator()
            ); 
          }
        ),
      );
  }
}