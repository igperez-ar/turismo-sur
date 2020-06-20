import 'package:flutter/material.dart';

class FavButtonWidget extends StatelessWidget{
  const FavButtonWidget({
    Key key, 
    @required this.liked,
    this.size = 45,
    this.onPress
  }): super(key: key);

  final bool liked;
  final double size;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.size,
      height: this.size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            spreadRadius: 2, 
            offset: Offset(2, 2),
          )
        ],
      ),
      child: Container(
        child: IconButton(
          alignment: Alignment.center,
          icon: Icon(
            liked ? Icons.favorite : Icons.favorite_border, 
            color: (liked ? Theme.of(context).iconTheme.color : Colors.grey[400]),
            size: this.size / 1.5
          ), 
          onPressed: this.onPress
        ),
      )
    );
  }
}