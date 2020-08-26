import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:turismo_app/bloc/autenticacion/autenticacion_bloc.dart';
import 'package:turismo_app/models/models.dart';
import 'package:turismo_app/widgets/widgets.dart';


class EditUserForm extends StatefulWidget {
  final _EditUserFormState state = _EditUserFormState();
  final AutenticacionBloc autenticacionBloc;

  EditUserForm({
    Key key,
    @required this.autenticacionBloc
  }) : super(key: key);

  @override
  _EditUserFormState createState() {
    return this.state;
  }
}

class _EditUserFormState extends State<EditUserForm> {

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String image;
  Usuario user;
  /* TextEditingController _password2Controller = TextEditingController();
  bool _showConfirm = false; */

  final _formKey = GlobalKey<FormState>();

  AutenticacionBloc get _autenticationBloc => widget.autenticacionBloc;

  @override 
  void initState() {
    super.initState();
    
    if (_autenticationBloc.state is AutenticacionAuthenticated) {
      user = (_autenticationBloc.state as AutenticacionAuthenticated).usuario;
      image = user.foto;
    } 
    /* _passwordController.addListener(() {
      if (!_showConfirm && _passwordController.text.isNotEmpty) {
        setState(() {
          _showConfirm = true;
        });
      }
    }); */
  }

  final List<String> iconsIndex = ['265', '266', '268', '270', '272', '274', '276', '277', '278', '279', '280', '281', '282', '283', '284', '285', '286', '287', '288', '289', '290', '291', '292', '293', '294', '295', '296', '297', '298', '299', '300', '301', '302', '303', '304', '305'];

  List<Widget> _icons() {
    return iconsIndex.map<Widget>((item) {
      var url = 'assets/profile_pics/pic_$item.svg';

      return GestureDetector(
        onTap: () {
          setState(() {
            image = item;
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

  void _selectImage() {
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

  void validateForm() async {
    final state = _autenticationBloc.state;
    FocusScope.of(context).unfocus();

    if (state is AutenticacionAuthenticated && _formKey.currentState.validate()) {
      Usuario oldUser = state.usuario;
      Usuario newUser = oldUser.copyWith(
        nombre: _nameController.text,
        descripcion: _descriptionController.text,
        foto: image,
        email: _emailController.text,
        username: _usernameController.text,
        password: _passwordController.text
      );
      
      _autenticationBloc.add(AutenticacionUpdate(
        username: oldUser.username,
        newUser: newUser,
      ));
    }

    Future.delayed(Duration(seconds: 1), () {
      if (state is AutenticacionUnauthenticated)
        SnackBarWidget.show(context, state.error, SnackType.danger);

      if (state is AutenticacionAuthenticated)
        SnackBarWidget.show(context, 'La información se modificó con éxito.', SnackType.success, persistent: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: BlocBuilder<AutenticacionBloc,AutenticacionState>(
        builder: (context, state) {

          return Column(
            children: [
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 30, bottom: 15),
                height: 150,
                width: 150,
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: <Widget>[
                    ProfileImage(
                      image: image, 
                      size: ProfileImageSize.large
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.teal[300],
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 3,
                            spreadRadius: 1,
                            offset: Offset(1,1)
                          )
                        ]
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
              InputValidatedWidget(
                controller: _usernameController,
                initialValue: user?.username,
                hintText: 'Usuario',
                icon: Icons.person,
              ),
              InputValidatedWidget(
                controller: _nameController,
                hintText: 'Nombre completo',
                initialValue: user?.nombre,
                textCapitalization: TextCapitalization.words,
                icon: Icons.person,
              ),
              InputValidatedWidget(
                controller: _descriptionController,
                hintText: 'Descripción',
                initialValue: user?.descripcion,
                textCapitalization: TextCapitalization.sentences,
                max: 100,
                optional: true,
                icon: Icons.description,
              ),
              InputValidatedWidget(
                controller: _emailController,
                hintText: 'Email',
                initialValue: user?.email,
                email: true,
                icon: Icons.email,
              ),
              InputValidatedWidget(
                controller: _passwordController,
                hintText: 'Contraseña',
                initialValue: user?.password,
                password: true,
                icon: Icons.lock,
              ),
              /* Visibility(
                visible: _showConfirm,
                maintainAnimation: true,
                maintainState: true,
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 700),
                  opacity: _showConfirm ? 1.0 : 0.0,
                  child: InputValidatedWidget(
                    controller: _password2Controller,
                    hintText: 'Confirmar contraseña',
                    icon: Icons.lock,
                    password: true,
                    validPassword: _passwordController,
                  )
                )
              ), */
              SizedBox(height: 40),
              /* RaisedButton(
                onPressed: validateForm,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Container(
                  width: 150,
                  height: 40,
                  alignment: Alignment.center,
                  child: (state is AutenticacionLoading
                    ? Container(
                        height: 25,
                        width: 25,
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white, 
                          strokeWidth: 3
                        )
                      )
                    : Text('Editar', style: TextStyle(fontSize: 16))
                  )
                )
              ), */
              /* RaisedButton(
                onPressed: () {
                  /* _autenticacionBloc.add(AutenticacionLoggedOut());
                  Navigator.pop(context); */
                }, 
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Container(
                  width: 150,
                  height: 40,
                  alignment: Alignment.center,
                  child: Text('Cambiar contraseña', style: TextStyle(fontSize: 16),)
                )
              ), */
            ]
            /* )
          }

          return Center(child: CircularProgressIndicator());
        } */
      );}
    ));
  }
}