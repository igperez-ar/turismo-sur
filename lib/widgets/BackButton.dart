/* import 'package:flutter/material.dart';

class BackButton extends StatelessWidget{
  const BackButton({
    Key key, 
    @required this.onPress
  }): super(key: key);

  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.white,
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
        margin: EdgeInsets.only(top: 1),
        alignment: Alignment.center,
        child: IconButton(
          icon: Icon(
            liked ? Icons.favorite : Icons.favorite_border, 
            color: (liked ? Colors.teal[300] : Colors.grey),
            size: this.size / 1.8
          ), 
          onPressed: this.onPress,
        ),
      )
    );
  }
} */