import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:turismo_app/bloc/bloc.dart';
import 'package:turismo_app/screens/screens.dart';
import 'package:turismo_app/widgets/widgets.dart';

class IngresoScreen extends StatefulWidget {
  final int selectedTab;

  const IngresoScreen({
    Key key,
    this.selectedTab = 1
  }) : super(key: key);

  @override
  _IngresoScreenState createState() => _IngresoScreenState();
}

class _IngresoScreenState extends State<IngresoScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  AutenticacionBloc _autenticacionBloc;
  int _selectedTab;

  @override 
  void initState() {
    super.initState();

    _autenticacionBloc = BlocProvider.of<AutenticacionBloc>(context);
    _selectedTab = widget.selectedTab;
  }

  Widget _renderSignup() {
    if (this._selectedTab != 0) 
      return Container();

    return BlocBuilder<AutenticacionBloc,AutenticacionState>(
      builder: (context, state) {
        return Column(
          children: [
            SignUpForm(
              autenticacionBloc: _autenticacionBloc
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () => this.setState(() {
                this._selectedTab = 1;
              }),
              child: Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Text('Ya tienes una cuenta? Inicia sesión!', 
                  style: TextStyle(
                    color: Colors.grey[600]
                  ),
                )
              )
            )
          ],
        );
      },
    );
  }

  Widget _renderSignin() {
    if (this._selectedTab != 1) 
      return Container();

    return Column(
      children: [
        SignInForm(
          autenticacionBloc: _autenticacionBloc,
          onSubmit: () {
            _autenticacionBloc.listen((state) {
              if (state is AutenticacionUnauthenticated) {
                SnackBarWidget.show(_scaffoldKey, state.error, SnackType.danger);
              }
            });
          },
        ),
        SizedBox(height: 15),
        GestureDetector(
          onTap: () => this.setState(() {
            this._selectedTab = 0;
          }),
          child: Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Text('No tienes una cuenta? Registrate!', 
              style: TextStyle(
                color: Colors.grey[600]
              ),
            )
          )
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(this._selectedTab == 1 ? 'Iniciar sesión' : 'Registrarse', 
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: BlocBuilder<AutenticacionBloc, AutenticacionState>(
            builder: (context, state) {

              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: this._selectedTab == 1 ? null : 0,
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: SvgPicture.asset(
                        'assets/images/undraw_sign_in.svg',
                        height: _height * 0.3,
                      )
                    ),
                    Container(
                      height: this._selectedTab == 0 ? null : 0,
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: SvgPicture.asset(
                        'assets/images/undraw_register.svg',
                        height: _height * 0.3,
                      )
                    ),
                    SizedBox(height: 10),
                    _renderSignin(),
                    _renderSignup()
                  ]
                )
              );
            },
          )
        )
      )
    );
  }
}