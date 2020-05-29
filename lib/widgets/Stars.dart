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
    
    if (this.count == 6) {
      return Row(
        children: <Widget>[
          Icon(
            Icons.stars, 
            color: Colors.teal[300], 
            size: this.size
          ),
          Padding(padding: EdgeInsets.only(left:5),),
          Text("Categoría única", style: TextStyle(
              fontSize: this.size / 1.65,
              color: Colors.grey[600],
            ),
          ),
        ]
      );
    } 
    else {
      final _children = <Widget>[]; 

      for (var i = 1; i <= 5; i++) 
        _children.add(
          Icon(
            Icons.star, 
            color: (i <= count ? Colors.teal[300] : Colors.grey[300]), 
            size: this.size
          )
        );

      return Row(
        children: _children
      );
    }
  }
}