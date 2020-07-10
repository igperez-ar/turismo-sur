import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReviewWidget extends StatefulWidget {
  @override
  _ReviewWidgetState createState() => _ReviewWidgetState();
}

class _ReviewWidgetState extends State<ReviewWidget> {
  bool isUseful = false;
  bool isUseless = false;

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

  _changeUseful() {
    if (this.isUseful) 
      this.setState(() { 
        isUseful = false;
      }); 
    else
      this.setState(() { 
        isUseful = true;
        isUseless = false;
      });
  }

  _changeUseless() {
    if (this.isUseless) 
      this.setState(() { 
        isUseless = false;
      }); 
    else
      this.setState(() { 
        isUseless = true;
        isUseful = false;
      });
  }

  Widget _icon(int number, {bool min = true}) {
    return Icon(
      iconList[number-1]['name'],
      color: iconList[number-1]['color'],
      size: (min ? 24 : 65),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: <Widget>[
          Divider(height: 30, thickness: 1.5, color: Colors.grey[300],),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: SvgPicture.network('https://image.flaticon.com/icons/svg/3011/3011279.svg',
                      height: 45,
                      width: 45,
                    )
                  ),
                  SizedBox(width: 20),
                  Text("Noah Steven", style: Theme.of(context).textTheme.headline4
                  )
                ]
              ),
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.thumb_up, color: (this.isUseful ? Colors.lightGreen : Colors.grey[400])),
                    onPressed: _changeUseful
                  ),
                  IconButton(
                    icon: Icon(Icons.thumb_down, color: (this.isUseless ? Colors.red : Colors.grey[400])),
                    onPressed: _changeUseless
                  )
                ],
              )
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: <Widget>[
              _icon(4),
              SizedBox(width: 5),
              Text("27/5/20", style: Theme.of(context).textTheme.headline3)
            ],
          ),
          SizedBox(height: 10),
          Text('chamber ran heart something similar certain win son score old date noise factory motor audience chief court my sugar expect full medicine statement consonant',
            style: Theme.of(context).textTheme.bodyText2,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}