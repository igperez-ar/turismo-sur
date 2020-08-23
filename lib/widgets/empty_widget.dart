import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EmptyWidget extends StatelessWidget {
  final String title;
  final Map<String, dynamic> button;
  final String uri;

  const EmptyWidget({
    Key key,
    @required this.title,
    @required this.uri,
    this.button
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return Center(
      child: Container(
        padding: EdgeInsets.only(left: 40, right: 40, top: 70),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: SvgPicture.asset(
                uri,
                fit: BoxFit.contain,
              )
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 30, bottom: 50, left: 30, right: 30),
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.headline4,
                      textAlign: TextAlign.center,
                      
                    )
                  ),
                  ( button != null
                    ? RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                        onPressed: button['action'], 
                        child: Text(button['title'], style: TextStyle(color: Colors.white),)
                      )
                    : Container()
                  )
                ],
              )
            )
          ],
        )
      )
    );
  }
}