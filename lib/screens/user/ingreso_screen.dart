import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IngresoScreen extends StatefulWidget {
  @override
  _IngresoScreenState createState() => _IngresoScreenState();
}

class _IngresoScreenState extends State<IngresoScreen> {
  TextEditingController _usuarioController;
  TextEditingController _contrasenaController;

  Widget _getField(String title, String data) {
    TextEditingController _textEditingController = TextEditingController();
    _textEditingController.text = data;

    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: <Widget>[ 
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                fit: FlexFit.loose,
                flex: 1,
                child: Text(title, style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18
                  )
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 3,
                child: TextField(
                  textAlign: TextAlign.right,
                  textCapitalization: TextCapitalization.sentences,
                  controller: _textEditingController,
                  /* onEditingComplete: _processText, */ 
                  decoration: InputDecoration( 
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
          Divider(thickness: 2, color: Colors.grey[200],)
        ]
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenid@!', 
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
              height: 100,
            child: SvgPicture.asset(
              'assets/images/undraw_sign_in_e6hj.svg',
              color: Theme.of(context).scaffoldBackgroundColor,
              colorBlendMode: isDark ? BlendMode.lighten : BlendMode.softLight,
              /* width: 55, */
            )
          )
        ]
      )
    );
  }
}