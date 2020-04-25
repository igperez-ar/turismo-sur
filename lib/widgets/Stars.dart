import 'package:flutter/material.dart';

class Stars extends StatelessWidget{
  const Stars({
    Key key, 
    @required this.count,
    this.size = 25
  }): super(key: key);

  final int count;
  final double size;

  @override
  Widget build(BuildContext context) {
    final _children = <Widget>[]; 
    
    for (var i = 1; i <= 5; i++) {
      if (i <= count) {
        _children.add(Icon(Icons.star, color: Colors.teal[300], size: this.size));
      } else {
        _children.add(Icon(Icons.star_border, color: Colors.teal[300], size: this.size));
      }
    }

    return (
      Row(
        children: _children
      )
    );
  }
}