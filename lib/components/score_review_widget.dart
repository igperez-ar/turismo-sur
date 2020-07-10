import 'package:flutter/material.dart';
import 'package:turismo_app/components/components.dart';

class ScoreReviewWidget extends StatefulWidget {
  @override
  _ScoreReviewWidgetState createState() => _ScoreReviewWidgetState();
}

class _ScoreReviewWidgetState extends State<ScoreReviewWidget> {
  /* bool _open = false; */

  final List<Map<String, Object>> iconList = [
    {'name': Icons.sentiment_very_dissatisfied,
     'color': Colors.red
    },
    {'name': Icons.sentiment_dissatisfied,
     'color': Colors.orange
    },
    {'name': Icons.sentiment_neutral,
     'color': Colors.yellow
    },
    {'name': Icons.sentiment_satisfied,
     'color': Colors.lightGreen
    },
    {'name': Icons.sentiment_very_satisfied,
     'color': Colors.green
    },
  ];

  Widget _icon(int number, {bool min = true}) {
    return Icon(
      iconList[number-1]['name'],
      color: iconList[number-1]['color'],
      size: (min ? 24 : 65),
    );
  }

  Widget _bar(Icon icon, double count) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          icon,
          SizedBox(width: 5),
          Flexible(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: LinearProgressIndicator(
                value: count,
                backgroundColor: Colors.grey[300],
              )
            )
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: <Widget>[ 
          Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Column(
                    children: <Widget>[
                      _icon(5, min:false),
                      SizedBox(height: 5),
                      Text(
                        "300",
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 16
                        ),
                      )
                    ],
                  )
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    children: <Widget>[
                      _bar(_icon(5), 200/300),
                      _bar(_icon(4), 50/300),
                      _bar(_icon(3), 1/300),
                      _bar(_icon(2), 39/300),
                      _bar(_icon(1), 10/300),
                    ],
                  ),
                )
              ],
            )
          ),
          SizedBox(height: 10),
          ReviewWidget(),
          ReviewWidget(),
          /* ReviewWidget(), */
        ],
    );
  }
}