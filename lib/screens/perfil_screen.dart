import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:turismo_app/screens/screens.dart';

//icons 265-306

class PerfilScreen extends StatelessWidget {
  final List<String> iconsIndex = ['265', '266', '268', '270', '272', '274', '276', '277', '278', '279', '280', '281', '282', '283', '284', '285', '286', '287', '288', '289', '290', '291', '292', '293', '294', '295', '296', '297', '298', '299', '300', '301', '302', '303', '304', '305', '306'];

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
  }  

  @override
  Widget build(BuildContext context) {
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
      body: Container(
        alignment: Alignment.center,
        /* padding: EdgeInsets.all(30), */
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 30),
              height: 150,
              width: 150,
              child: SvgPicture.asset(
                'assets/profile_pics/pic_270.svg',
                height: 150,
                width: 150,
              ),
            ),
            SizedBox(height: 20),
            Text('Ignacio Perez', style: TextStyle(
                fontSize: 27,
                color: Colors.grey[800]
              )
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text('Un viajero apasionado por los animales', style: TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey[500]
                ),
                textAlign: TextAlign.center,
              )
            )
            /* Wrap(
              alignment: WrapAlignment.center,
              runSpacing: 10,
              spacing: 10,
              children: _icons()
            ) */
          ],
        )
      ),
    );
  }
}