import 'package:flutter/material.dart';

class DetailSectionWidget extends StatelessWidget{
  const DetailSectionWidget({
    Key key, 
    @required this.title,
    @required this.child,
    this.actions
    /* this.margin = false */
  }): super(key: key);

  final String title;
  final Widget child;
  final List<Map<String, Object>> actions;
  /* final bool margin; */

  Widget _getAction(Map<String, Object> action) {
    return IconButton(
      splashColor: Colors.transparent,
      padding: EdgeInsets.zero,
      icon: Icon(
        action['icon'],
        size: 26,
        color: Colors.grey[400],
      ),
      alignment: Alignment.centerRight,
      onPressed: action['onPressed'],
    );
  }

  
  @override
  Widget build(BuildContext context) {
     return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(15),
      /* decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            spreadRadius: 1,
            offset: Offset(2, 2)
          )
        ]
      ), */
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(title, style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                )
              ),
              ( actions != null 
                ? Container(
                  constraints: BoxConstraints(maxHeight: 26),
                  child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: actions.map((action) => _getAction(action)).toList()
                    )
                )
                : Container()
              )
            ]
          ),
          Padding(
            padding: EdgeInsets.only(top: 15, left: /* this.margin ? 20 : */ 0, bottom: 10),
            child: child,
          )
        ]
      )
    );
  }
}