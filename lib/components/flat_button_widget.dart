import 'package:flutter/material.dart';

class FlatButtonWidget extends StatelessWidget {
  final Function onPress;
  final String title;
  final bool pressed;

  const FlatButtonWidget({
    Key key, 
    @required this.onPress,
    @required this.title,
    this.pressed = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: this.onPress,
      child: Container(
        width: _width * 0.43,
        height: 40,
        child: Align(
          alignment: Alignment.center,
          child: Text(this.title, style: TextStyle(
              fontSize: 16,
              color: this.pressed ? Colors.teal[400] : Colors.grey,
              fontWeight: this.pressed ? FontWeight.bold : FontWeight.normal,
            ),
            maxLines: 1,
            overflow: TextOverflow.clip,
          ),
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          boxShadow: (!this.pressed ? [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 3,
              spreadRadius: 1,
              offset: Offset(2, 2),
            )
          ] : []),
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: (this.pressed ?
            Border.all(color: Colors.teal[300], width: 2) :
            Border.all(color: Colors.grey[300], width: 1)
          ),
        ),
      ),
    );
  }
}