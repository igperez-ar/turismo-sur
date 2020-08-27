import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {

  final Function onDismiss;
  final Function onSignup;

  const SplashScreen({
    Key key,
    this.onSignup,
    this.onDismiss
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;

    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      content: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/ushuaia-paisaje.jpg',
            fit: BoxFit.cover,
          ),
          Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(50, 50, 50, 0.65)
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(top: 100),
                    height: _height * 0.3,
                    child: Text('Turismo Sur', 
                      style: TextStyle(
                        color: Colors.white, 
                        fontSize: 45, 
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 70, right: 50),
                    height: _height * 0.2,
                    child: Text('Para poder utilizar todas las funcionalidades que ofrece la aplicación, es necesario que inicies sesión en tu cuenta o crees una. Puedes omitir este paso y hacerlo más tarde.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16
                      ),
                      textAlign: TextAlign.left,
                    )
                  ),
                  RaisedButton(
                    onPressed: this.onSignup, 
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Container(
                      width: 150,
                      height: 50,
                      alignment: Alignment.center,
                      child: Text('Acceder', style: TextStyle(fontSize: 16),)
                    )
                  ),
                  SizedBox(height: 15),
                  RaisedButton(
                    onPressed: this.onDismiss, 
                    textColor: Colors.white,
                    color: Colors.grey[500].withOpacity(0.6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Container(
                      width: 150,
                      height: 50,
                      alignment: Alignment.center,
                      child: Text('Omitir', style: TextStyle(fontSize: 16),)
                    )
                  ),
                ]
              )
            )
          )
        ],
      )
    );
  }
}