import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_app/bloc/bloc.dart';

import 'package:turismo_app/screens/screens.dart';
import 'package:turismo_app/components/components.dart';

class ExplorarScreen extends StatefulWidget {
  @override
  _ExplorarScreenState createState() => _ExplorarScreenState();
}

class _ExplorarScreenState extends State<ExplorarScreen> {

  Widget _getCardList(List alojamientos, List gastronomicos) {
    /* final int count = max(alojamientos.length, gastronomicos.length);
    List<Widget> _cards = [];

    for (var index = 0; index < count; index++) {
      if (index < alojamientos.length)
        _cards.add(
          DefaultCard(
            type: 'ALOJAMIENTO',
            name: alojamientos[index].nombre,
            address: alojamientos[index].domicilio,
            image: alojamientos[index].foto,
            category: alojamientos[index].categoria,
            clasification: alojamientos[index].clasificacion.nombre,
            onTap: () => Navigator.push(context,
              MaterialPageRoute(
                builder: (context) => AlojamientoScreen(alojamiento: alojamientos[index])
              )
            )
          )
        );
                
        if (index < gastronomicos.length)
          _cards.add(
            DefaultCard(
              type: 'GASTRONOMICO',
              name: gastronomicos[index].nombre,
              address: gastronomicos[index].domicilio,
              image: gastronomicos[index].foto,
              activities: gastronomicos[index].actividades,
              specialities: gastronomicos[index].especialidades,
              onTap: () {}
            )
          );  
    }

    return ListView(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
      children: _cards,
    ); */

    return ListView.builder(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
        itemCount: max(alojamientos.length, gastronomicos.length), 
        itemBuilder: (context, index) { 
          return Column(
            children: <Widget>[
              ( index < alojamientos.length ?
                  DefaultCard(
                    type: 'ALOJAMIENTO',
                    name: alojamientos[index].nombre,
                    address: alojamientos[index].domicilio,
                    image: alojamientos[index].foto,
                    category: alojamientos[index].categoria,
                    clasification: alojamientos[index].clasificacion.nombre,
                    onTap: () => Navigator.push(context,
                      MaterialPageRoute(
                        builder: (context) => AlojamientoScreen(alojamiento: alojamientos[index])
                      )
                    )
                  )
                : Container()
              ),
              ( index < gastronomicos.length ?
                  DefaultCard(
                    type: 'GASTRONOMICO',
                    name: gastronomicos[index].nombre,
                    address: gastronomicos[index].domicilio,
                    image: gastronomicos[index].foto,
                    activities: gastronomicos[index].actividades,
                    specialities: gastronomicos[index].especialidades,
                    onTap: () {}
                  )
                : Container()
              )
            ]
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
            onPressed: () => Navigator.push(context,
              MaterialPageRoute(
                builder: (context) => FiltrosScreen()
              )
            )
          )
        ],
      ),
      body: Container(
        child: BlocBuilder<EstablecimientosBloc, EstablecimientosState>(
          builder: (context, state) {
            if (state is EstablecimientosInitial) {
              BlocProvider.of<EstablecimientosBloc>(context)
                .add(FetchEstablecimientos());
            }

            if (state is EstablecimientosFailure) {
              return Center(
                child: Text('failed to fetch content')
              );
            }

            if (state is EstablecimientosSuccess) {
              return _getCardList(
                state.alojamientos, 
                state.gastronomicos
              );
            }
          
            return Center(
              child: CircularProgressIndicator()
            ); 
          }
        ),
        /* Query(
          options: QueryOptions(
            documentNode: gql(gastronomicosQuery),
            pollInterval: 10,
          ),
          builder: (QueryResult result, 
            { VoidCallback refetch, FetchMore fetchMore }) {
            if (result.hasException) {
                return Text(result.exception.toString());
            }

            if (result.loading) {
              return Center(
                child: CircularProgressIndicator()
              ); 
            }

            List gastronomicos = result.data['gastronomicos'];

            return Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                itemCount: gastronomicos.length,
                itemBuilder: (context, index) {
                  return DefaultCard(
                    type: 'GASTRONOMICO',
                    name: gastronomicos[index]['nombre'],
                    address: gastronomicos[index]['domicilio'] ?? 'Sin dirección',
                    image: gastronomicos[index]['foto'],
                    onTap: null
                  );
                }
              )
            );
          },
        ),
        BlocBuilder<AlojamientoBloc, AlojamientoState>(
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

              return Expanded(
                child: _getCardList(state.alojamientos)
              );
            }
          
            return Center(
              child: CircularProgressIndicator()
            ); 
          }
        ), 
      ]
    )
    */
      )
    );
  }
}