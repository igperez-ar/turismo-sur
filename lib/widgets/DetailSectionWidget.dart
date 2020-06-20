import 'package:flutter/material.dart';

class DetailSectionWidget extends StatelessWidget{
  const DetailSectionWidget({
    Key key, 
    @required this.title,
    @required this.child,
    this.margin = true
  }): super(key: key);

  final String title;
  final Widget child;
  final bool margin;

  
  @override
  Widget build(BuildContext context) {
     return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(5)
      ),
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Text(title.toUpperCase(), style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
                fontWeight: FontWeight.bold
              )
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15, left: this.margin ? 20 : 0, bottom: 10),
            child: child,
          )
        ]
      )
    );
  }
}