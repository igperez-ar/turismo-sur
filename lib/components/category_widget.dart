import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget{
  const CategoryWidget({
    Key key, 
    @required this.count,
    this.size = 25
  }): super(key: key);

  final int count;
  final double size;

  @override
  Widget build(BuildContext context) {
    
    if (this.count == 0) {
      return Row(
        children: <Widget>[
          Icon(
            Icons.stars, 
            color: Theme.of(context).iconTheme.color, 
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
            color: (i <= count ? 
                Theme.of(context).iconTheme.color 
              : Theme.of(context).disabledColor), 
            size: this.size
          )
        );

      return Row(
        children: _children
      );
    }
  }
}