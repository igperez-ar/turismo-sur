import 'dart:math';
import 'dart:ui';

import 'package:dashed_container/dashed_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:turismo_app/bloc/bloc.dart';
import 'package:turismo_app/bloc/configuracion/configuracion_bloc.dart';
import 'package:turismo_app/components/components.dart';
import 'package:turismo_app/models/models.dart';
import 'package:turismo_app/screens/helper.dart';

import 'package:turismo_app/screens/screens.dart';
import 'package:turismo_app/screens/user/ingreso_screen.dart';

//icons 265-306

/* class PerfilScreen extends StatelessWidget { */
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
class PerfilScreen extends StatefulWidget {
  @override
  _PerfilScreenState createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  bool darkMode;
  ConfiguracionBloc _configuracionBloc;

  final Map<String, String> datos = {
    'name': 'Ignacio Perez',
    'username': 'igperezperez',
    'image': '270',
    'email': 'fikuse@odsov.mx',
    'phone': '(601) 256-4824',
    'birth_date': '8/13/2109',
    'address': '1436 Fafdu Highway',
  };

  @override 
  void initState() {
    super.initState();

    _configuracionBloc = BlocProvider.of<ConfiguracionBloc>(context);
  }

  Widget _getOption({IconData icon, String title, Function onPress, bool value}) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(icon),
                SizedBox(width: 15),
                Text(title, style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15
                  )
                )
              ],
            ),
            value == null 
            ? IconButton(
                icon: Icon(Icons.chevron_right), 
                onPressed: onPress
              )
            : Switch(
              value: value, 
              onChanged: (value) => onPress()
            )
          ],
        )
      )
    );
  }

  Widget _getOptionsGroup(List<Widget> options) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      padding: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            spreadRadius: 1,
            offset: Offset(2, 2)
          )
        ]
      ),
      child: Column(
        children: options.map<Widget>((element) {
          if (options.indexOf(element) != 0)
            return Column(
              children: <Widget>[
                Divider(indent: 20, endIndent: 20, thickness: 1),
                element
              ],
            );

          return element;
        }).toList()
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;

    /* if (false) {
      return IngresoScreen();
    } */

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('igperez-ar', 
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.teal[300],
        /* centerTitle: true, */
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.favorite_border), 
            onPressed: () => Navigator.push(context,
              MaterialPageRoute(
                builder: (context) => FavoritosScreen()
              )
            ),
          ),
          IconButton(
            icon: Icon(Icons.notifications), 
            onPressed: () {}
          )
        ],
      ),
      body: Stack(
        children: [
          Container(
            width: _width,
            height: 300,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment(0, 0.5),
                colors: [Colors.teal[300], Colors.teal[100]])
            ),
          ),
          ListView(
            children: [
              Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 30, bottom: 15),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    height: 100,
                    width: 100,
                    child: SvgPicture.asset(
                      'assets/profile_pics/pic_270.svg'
                    ),
                  ),
                  Text('Ignacio Perez', 
                    style: TextStyle(
                      fontSize: 27,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      shadows: [
                        Shadow(
                          color: Colors.black38,
                          blurRadius: 3,
                          offset: Offset(1.5, 1.5)
                        )
                      ]
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 70),
                    child: Text('Work hard in silence. Let your success be the noise.', style: TextStyle(
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            color: Colors.black38,
                            blurRadius: 2,
                            offset: Offset(1.3, 1.3)
                          )
                        ]
                      ),
                      textAlign: TextAlign.center,
                    )
                  ),
                ],
              ),
              _getOptionsGroup([
                _getOption(
                  icon: Icons.location_on,
                  title: "Mi ubicación",
                  onPress: () {}
                ),
                _getOption(
                  icon: Icons.group,
                  title: "Cuenta",
                  onPress: () => Navigator.push(context,
                    MaterialPageRoute(
                      builder: (context) => EditProfileScreen()
                    )
                  )
                ),
              ]),
              BlocBuilder<ConfiguracionBloc, ConfiguracionState>(
                builder: (context, state) {
                  if (state is ConfiguracionSuccess) {
                    darkMode = state.config['dark-mode'];
                  }
                
                  return _getOptionsGroup([
                    _getOption(
                      icon: Icons.notifications,
                      title: "Notificaciones",
                      onPress: () {}
                    ),
                    _getOption(
                      icon: Icons.devices,
                      title: "Dispositivos",
                      onPress: () {}
                    ),
                    _getOption(
                      icon: Icons.chat_bubble,
                      title: "Idioma",
                      onPress: () {}
                    ),
                    _getOption(
                      icon: Icons.lightbulb_outline,
                      title: "Modo oscuro",
                      value: darkMode, 
                      onPress: () {
                        setState(() {
                          darkMode = !darkMode;
                        });
                        _configuracionBloc.add(UpdateConfiguracion({'dark-mode': darkMode}));
                      }
                    ),
                  ]);
                }
              )
            ],
          )
        ],
      )
    );
  }
}