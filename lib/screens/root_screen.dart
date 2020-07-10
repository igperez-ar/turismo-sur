import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location_permissions/location_permissions.dart';

import 'package:turismo_app/screens/screens.dart';


class RootScreen extends StatefulWidget {

  @override
  State createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _currentIndex = 0;
  final List<Widget> _children =[
    ExplorarScreen(),
    MapaScreen(),
    ChatScreen(),
    PerfilScreen()
  ];

  void changeTabIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _locationConfig() async {
    final PermissionStatus permissionStatus = await LocationPermissions().checkPermissionStatus();
    print(permissionStatus);

    final ServiceStatus serviceStatus = await LocationPermissions().checkServiceStatus();
    print(serviceStatus);

    if (permissionStatus != PermissionStatus.granted ||
        permissionStatus != PermissionStatus.restricted) {
      final PermissionStatus newPermissionStatus = await LocationPermissions()
        .requestPermissions(permissionLevel: LocationPermissionLevel.location);
      print(newPermissionStatus);
    }

    /* if (serviceStatus != ServiceStatus.enabled) {
      final isOpen = await LocationPermissions().openAppSettings();
      print(isOpen);
    } */
  }

  @override
  void initState() {
    super.initState();
    
    /* this._locationConfig(); */
  }

  Widget _getTabItem(int id, IconData icon, String title) {

    if (_currentIndex == id) 
      return IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(
          icon, 
          size: 35, 
          color: Colors.teal
        ),
        onPressed: () => this.changeTabIndex(id),
      );

    return IconButton(
      padding: EdgeInsets.zero,
      icon: Column(
        children: <Widget>[
          Icon(
            icon,
            size: 26, 
            color: Colors.grey[600]
          ),
          Text(
            title, 
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 13
            ),
          ),
        ]
      ),
      onPressed: () => this.changeTabIndex(id),
    );
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: _children[_currentIndex],
      /* floatingActionButton: FloatingActionButton(
        onPressed: (){}, 
        backgroundColor: (_currentIndex == 4 ? Colors.teal : Colors.grey[600]),
        child: Icon(Icons.favorite, size: 33),),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked, */
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              spreadRadius: 2,
              offset: Offset(0,-1)
            )
          ]
        ),
        child: /* BottomAppBar(
          child: Container(
            height: 58,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
              this._getTabItem(0, Icons.explore, 'Explorar'),
              this._getTabItem(1, Icons.map, 'Mapa'),
              SizedBox(width: 40),
              // Nombre al botón del medio
              /* Container(
                margin: EdgeInsets.only(top: 20),
                child: Text(
                  'Favoritos', 
                  style: TextStyle(
                    fontSize: 13, 
                    color: Colors.grey[600]
                  )
                )
              ), */
              this._getTabItem(2, Icons.chat, 'Chat'),
              this._getTabItem(3, Icons.person, 'Perfil'),
            ],
            ),
          ),
          shape: CircularNotchedRectangle(),
        ) */
        BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: changeTabIndex,
          backgroundColor: Theme.of(context).bottomAppBarColor,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Theme.of(context).iconTheme.color,
          selectedIconTheme: IconThemeData(size: 32),
          selectedLabelStyle: TextStyle(height: 0),
          
          showSelectedLabels: false,
          elevation: 15,
          unselectedLabelStyle: TextStyle(height: 1.2, fontSize: 13),
          iconSize: 26,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              title: Text('Explorar'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              title: Text('Mapa'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              title: Text('Chat'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Perfil'),
            ),
          ],
        ), 
      )
    );
  }
}