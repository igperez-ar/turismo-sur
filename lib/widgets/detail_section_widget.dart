import 'package:flutter/material.dart';

class DetailSectionWidget extends StatelessWidget{
  const DetailSectionWidget({
    Key key, 
    @required this.title,
    this.subtitle,
    @required this.child,
    this.actions
  }): super(key: key);

  final String title;
  final String subtitle;
  final Widget child;
  final List<Map<String, Object>> actions;

  Widget _getAction(Map<String, Object> action) {
    if (action.isNotEmpty)
      return IconButton(
        splashColor: Colors.transparent,
        padding: EdgeInsets.zero,
        icon: Icon(
          action['icon'],
          size: 26,
          color: Colors.grey,
        ),
        alignment: Alignment.centerRight,
        onPressed: action['onPressed'],
      );
    
    return Container();
  }

  
  @override
  Widget build(BuildContext context) {
     return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(title, style: TextStyle(
                  color: Colors.grey[700],
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
          SizedBox(height: 10),
          ( subtitle != null 
            ? Text(subtitle)
            : Container()
          ),
          Padding(
            padding: EdgeInsets.only(top: 15, left: 0, bottom: 10),
            child: child,
          )
        ]
      )
    );
  }
}