import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_app/bloc/autenticacion/autenticacion_bloc.dart';
import 'package:turismo_app/widgets/widgets.dart';


class SignInForm extends StatefulWidget {

  final AutenticacionBloc autenticacionBloc;

  const SignInForm({
    Key key,
    @required this.autenticacionBloc
  }) : super(key: key);

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void _processText() {
  }

  final _formKey = GlobalKey<FormState>();

  AutenticacionBloc get _autenticationBloc => widget.autenticacionBloc;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: BlocBuilder<AutenticacionBloc,AutenticacionState>(
        builder: (context, state) {
          return Column(
            children: [
              InputValidatedWidget(
                controller: _usernameController,
                hintText: 'Usuario',
                icon: Icons.person,
              ),
              InputValidatedWidget(
                controller: _passwordController,
                hintText: 'Contraseña',
                icon: Icons.lock,
                password: true,
              ),
              SizedBox(height: 40),
              RaisedButton(
                onPressed: () {
                  if (state is! AutenticacionLoading && _formKey.currentState.validate()) {
                    _autenticationBloc.add(LoggedIn(
                      username: _usernameController.text,
                      password: _passwordController.text
                    ));
                  }
                },
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Container(
                  width: 150,
                  height: 40,
                  alignment: Alignment.center,
                  child: state is AutenticacionLoading 
                    ? Container(
                        height: 25,
                        width: 25,
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white, 
                          strokeWidth: 3
                        )
                      ) 
                    : Text('Ingresar', style: TextStyle(fontSize: 16))
                )
              ),
            ],
          );
        }
      )
    );
  }
}