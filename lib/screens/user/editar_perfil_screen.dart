import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:turismo_app/bloc/configuracion/configuracion_bloc.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool darkMode;
  ConfiguracionBloc _configuracionBloc;

  final List<String> iconsIndex = ['265', '266', '268', '270', '272', '274', '276', '277', '278', '279', '280', '281', '282', '283', '284', '285', '286', '287', '288', '289', '290', '291', '292', '293', '294', '295', '296', '297', '298', '299', '300', '301', '302', '303', '304', '305'];

  @override
  void initState() {
    super.initState();

    _configuracionBloc = BlocProvider.of<ConfiguracionBloc>(context);
  }

  List<Widget> _icons() {
    return iconsIndex.map<Widget>((item) {
      var url = 'assets/profile_pics/pic_' + item + '.svg';

      return GestureDetector(
        onTap: () {
          this.setState(() {
            datos['image'] = item;
          });
          Navigator.pop(context);
        },
        child: SvgPicture.asset(
          url,
          width: 55,
          height: 55,
          )
      );
    }).toList();
  }

  Map<String, String> datos = {
    'name': 'Ignacio Perez',
    'username': 'igperez.ar',
    'image': '270',
    'bio': 'Work hard in silence. Let your success be the noise.',
    'email': 'fikuse@odsov.mx',
  };

  _selectImage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Seleccionar imagen'),
          content: Wrap(
            alignment: WrapAlignment.center,
            runSpacing: 10,
            spacing: 10, 
            children: _icons()
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Cuenta', 
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 30),
            height: 150,
            width: 150,
            child: Stack(
              alignment: Alignment.bottomRight,
              children: <Widget>[
                Container(  
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5,
                        spreadRadius: 2,
                        offset: Offset(2,3)
                      )
                    ]
                  ),
                  child: SvgPicture.asset(
                    'assets/profile_pics/pic_' + datos['image'] + '.svg',
                    height: 150,
                    width: 150,
                  )
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.teal[300],
                    shape: BoxShape.circle
                  ),
                  child: IconButton(
                    icon: Icon(Icons.camera_alt), 
                    iconSize: 28,
                    color: Colors.white,
                    onPressed: _selectImage
                  ),
                )
              ]
            ),
          ),
          SizedBox(height: 10),
          _getField('Usuario', datos['username']),
          _getField('Nombre', datos['name']),
          _getField('Bio', datos['bio']),
          _getField('Correo', datos['email']),
        ],
      ),
    );
  }
}