import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:turismo_app/bloc/bloc.dart';
import 'package:turismo_app/components/components.dart';
import 'package:turismo_app/models/models.dart';
import 'package:turismo_app/screens/helper.dart';

import 'package:turismo_app/screens/screens.dart';
import 'package:turismo_app/screens/user/ingreso_screen.dart';

//icons 265-306

class PerfilScreen extends StatelessWidget {
  /* final List<String> iconsIndex = ['265', '266', '268', '270', '272', '274', '276', '277', '278', '279', '280', '281', '282', '283', '284', '285', '286', '287', '288', '289', '290', '291', '292', '293', '294', '295', '296', '297', '298', '299', '300', '301', '302', '303', '304', '305', '306'];

  List<Widget> _icons() {
    List<Widget> children = [];

    for (var item in iconsIndex) {
      var url = 'assets/profile_pics/pic_' + item + '.svg';

      children.add(
        SvgPicture.asset(
          url,
          width: 55,
          height: 55,
        ),
      );
    }

    return children;
  }   */

  final Map<String, String> datos = {
    'name': 'Ignacio Perez',
    'username': 'igperezperez',
    'image': '270',
    'email': 'fikuse@odsov.mx',
    'phone': '(601) 256-4824',
    'birth_date': '8/13/2109',
    'address': '1436 Fafdu Highway',
  };

  Widget _getField(String title, String info) => Container(
    padding: EdgeInsets.only(top: 30, left: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title, style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(height: 5),
        Text(info, style: TextStyle(
            color: Colors.grey[600],
            fontSize: 15
          )
        )
      ],
    ),
  );

  bool _isFav(_favs, id, tipo) {
    return _favs.any((element) => (element.id == id
                                && element.tipo == tipo)
    );
  }

  Widget _getFavoritos( List<Favorito> favs, 
    List<Alojamiento> aloj, List<Gastronomico> gast) 
  {
    List<Widget> _children = [];

    for (var index = 0; index < max(aloj.length, gast.length); index++) {
      if (index < aloj.length) {
        if (_isFav(favs, aloj[index].id, Establecimiento.alojamiento)) {
          _children.add(
            FavCard(
              type: Establecimiento.alojamiento,
              establecimiento: aloj[index]
            )
          );
        }
      }

      if (index < gast.length) {
        if (_isFav(favs, gast[index].id, Establecimiento.gastronomico)) {
          _children.add(
            FavCard(
              type: Establecimiento.gastronomico,
              establecimiento: gast[index]
            )
          );
        }
      }
    }

    return Column(
      children: _children,
    );
  }

  @override
  Widget build(BuildContext context) {

    /* if (false) {
      return IngresoScreen();
    } */

    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil', 
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit), 
            onPressed: () => Navigator.push(context,
            MaterialPageRoute(
                  builder: (context) => EditProfileScreen()
                )
              ),
            )
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 30),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[300],
            ),
            height: 160,
            width: 160,
            child: SvgPicture.asset(
              'assets/profile_pics/pic_270.svg',
              height: 150,
              width: 150,
            ),
          ),
          SizedBox(height: 15),
          Text('Ignacio Perez', style: TextStyle(
              fontSize: 27,
              color: Theme.of(context).textTheme.headline4.color,
              fontWeight: FontWeight.w500
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 5),
          Text('@ignacioperez', style: TextStyle(
              fontSize: 20,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 30),
          Divider(thickness: 1, height: 0),
          Container(
            color: Colors.grey[100],
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text('+2k', style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Theme.of(context).textTheme.headline3.color
                      ),
                    ),
                    SizedBox(height: 5),
                    Text('Me gustas', style: TextStyle(
                        color: Colors.grey
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text('+5k', style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Theme.of(context).textTheme.headline3.color
                      ),
                    ),
                    SizedBox(height: 5),
                    Text('Seguidores', style: TextStyle(
                        color: Colors.grey
                      ),
                    ),
                  ],
                ),
              ],
            )
          ),
          Divider(thickness: 1, height: 0),
          BlocBuilder<EstablecimientosBloc, EstablecimientosState>(
            builder: (context, estState) {

              if (estState is EstablecimientosSuccess) {
                return BlocBuilder<FavoritosBloc, FavoritosState>(
                  builder: (context, favState) {

                    if (favState is FavoritosSuccess) {
                      return Padding(
                        padding: EdgeInsets.all(10),
                        child: _getFavoritos(
                          favState.favoritos,
                          estState.alojamientos, 
                          estState.gastronomicos
                        )
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ); 
              }

              return Center(
                child: CircularProgressIndicator(),
              );
            },
          )
          /* _getField('Dirección', datos['address']),
          _getField('Teléfono', datos['phone']),
          _getField('Correo', datos['email']), */
          /* Wrap(
            alignment: WrapAlignment.center,
            runSpacing: 10,
            spacing: 10,
            children: _icons()
          ) */
        ],
      )
    );
  }
}