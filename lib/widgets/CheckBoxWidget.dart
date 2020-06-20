import 'package:flutter/material.dart';

class CheckBoxWidget extends StatelessWidget {
  final String title;
  final Function onPress;
  final bool checked;

  const CheckBoxWidget({
    Key key,
    @required this.title,
    @required this.onPress,
    this.checked=false,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onPress,
      child: Row(
        children: <Widget>[
          Container(
            child: Icon(
              (this.checked ? Icons.check_box : Icons.check_box_outline_blank), 
              color: Colors.teal, 
              size: 30
            )
          ),
          SizedBox(width: 5),
          Text(
            this.title,
            style: TextStyle(
              fontSize: 16
            ),
          )
        ],
      )
    );
  }
}