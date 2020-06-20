import 'package:flutter/material.dart';

class ChipWidget extends StatelessWidget{
  const ChipWidget({
    Key key, 
    @required this.pressed,
    @required this.title,
    @required this.onPress
  }): super(key: key);

  final bool pressed;
  final String title;
  final Function(bool) onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        this.onPress(this.pressed);
      },
      child: Container(
        height: 30,
        padding: EdgeInsets.only(left:5, right:10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Theme.of(context).cardColor,
          border: this.pressed ? 
            Border.all(
              color: Colors.teal[300],
              width: 1
            ) : Border.all(width:1, color: Colors.transparent),
          boxShadow: this.pressed ? [] : [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 2,
              spreadRadius: 2, 
              offset: Offset(2, 2),
            )
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: 22,
              height: 22,
              alignment: Alignment.center,
              margin: EdgeInsets.only(right: 5),
              decoration: BoxDecoration(
                color: this.pressed ? Colors.teal[300] : Colors.teal,
                shape: BoxShape.circle
              ),
              child: Text(
                this.title[0].toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16
                ),
              ),
            ),
            Text(this.title, style: this.pressed ? TextStyle(
                color: Colors.teal[300],
                fontWeight: FontWeight.bold
              ) : null,
            )
          ]
        )
      )
    );
  }
}