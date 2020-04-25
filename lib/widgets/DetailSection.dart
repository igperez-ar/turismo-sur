import 'package:flutter/material.dart';

class DetailSection extends StatelessWidget{
  const DetailSection({
    Key key, 
    @required this.title,
    @required this.content,
    this.margin = true
  }): super(key: key);

  final String title;
  final Widget content;
  final bool margin;

  
  @override
  Widget build(BuildContext context) {
    final Width = MediaQuery.of(context).size.width;
    
     return (
      Column(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Text(title, style: TextStyle(
                color: Colors.grey[600],
                fontSize: 22,
                fontWeight: FontWeight.bold
              )
            ),
          ),
          Divider(
            color: Colors.grey[400],
            thickness: 1.6,
            endIndent: Width * 0.35,
          ),
          Padding(
            padding: EdgeInsets.only(top: 5, left: this.margin ? 20 : 0, bottom: 35),
            child: content,
          )
        ]
      )
    );
  }
}