import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:turismo_app/bloc/bloc.dart';
import 'package:turismo_app/screens/screens.dart';
import 'package:turismo_app/widgets/widgets.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool darkMode;
  AutenticacionBloc _autenticacionBloc;
  StreamSubscription _autenticacionListener;
  EditUserForm _editUserForm;

  @override
  void initState() {
    super.initState();

    _autenticacionBloc = BlocProvider.of<AutenticacionBloc>(context);
    _editUserForm = EditUserForm(autenticacionBloc: _autenticacionBloc);
  }

  @override 
  void dispose() {
    if (_autenticacionListener != null)
      _autenticacionListener.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocBuilder<AutenticacionBloc,AutenticacionState>(
        builder: (context, state) {

          return Scaffold(
            key: _scaffoldKey,
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
                      onPressed: () {
                        _editUserForm.state.validateForm();
                        _autenticacionListener = _autenticacionBloc.listen((state) {
                          if (state is AutenticacionUnauthenticated)
                            SnackBarWidget.show(_scaffoldKey, state.error, SnackType.danger);

                          if (state is AutenticacionAuthenticated)
                            SnackBarWidget.show(_scaffoldKey, 'La información se modificó con éxito.', SnackType.success, persistent: false);
                          /* Future.delayed(Duration(seconds: 1), () {
                            if (state is AutenticacionUnauthenticated)
                              SnackBarWidget.show(context, state.error, SnackType.danger);

                            if (state is AutenticacionAuthenticated)
                              SnackBarWidget.show(context, 'La información se modificó con éxito.', SnackType.success, persistent: false);
                          }); */
                        });
                      },
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