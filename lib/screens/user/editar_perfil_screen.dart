import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:turismo_app/bloc/autenticacion/autenticacion_bloc.dart';
import 'package:turismo_app/bloc/configuracion/configuracion_bloc.dart';
import 'package:turismo_app/screens/forms/forms.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool darkMode;
  AutenticacionBloc _autenticacionBloc;
  EditUserForm _editUserForm;

  @override
  void initState() {
    super.initState();

    _autenticacionBloc = BlocProvider.of<AutenticacionBloc>(context);
    _editUserForm = EditUserForm(autenticacionBloc: _autenticacionBloc);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocBuilder<AutenticacionBloc,AutenticacionState>(
        builder: (context, state) {

          return Scaffold(
            appBar: AppBar(
              title: Text('Cuenta', 
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, size: 30.0), 
                onPressed: () => Navigator.of(context).pop()
              ),
              actions: [
                (state is AutenticacionAuthenticated
                  ? IconButton(
                      icon: Icon(Icons.check, size: 30.0,),
                      onPressed: () => _editUserForm.state.validateForm(),
                    )
                  : Container(
                    width: 57,
                    padding: EdgeInsets.all(15),
                    child: CircularProgressIndicator(backgroundColor: Colors.white,strokeWidth: 3.0,)
                  )
                )
              ],
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    _editUserForm,
                    RaisedButton(
                      onPressed: () {
                        _autenticacionBloc.add(AutenticacionLoggedOut());
                        Navigator.pop(context);
                      }, 
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Container(
                        width: 150,
                        height: 40,
                        alignment: Alignment.center,
                        child: Text('Cerrar sesión', style: TextStyle(fontSize: 16),)
                      )
                    ),
                    SizedBox(height: 20)
                  ],
                )
              )
            ),
          );
        },
      )
    );
  }
}