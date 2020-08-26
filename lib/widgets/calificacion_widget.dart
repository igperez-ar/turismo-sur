import 'package:flutter/material.dart';

final List<Map<String, Object>> puntajes = [
  {'id': 1,
   'name': Icons.sentiment_very_dissatisfied,
   'label': 'Pésimo',
   'color': Colors.red
  },
  {'id': 2,
   'name': Icons.sentiment_dissatisfied,
   'label': 'Malo',
   'color': Colors.orange
  },
  {'id': 3,
   'name': Icons.sentiment_neutral,
   'label': 'Regular',
   'color': Colors.yellow
  },
  {'id': 4,
   'name': Icons.sentiment_satisfied,
   'label': 'Bueno',
   'color': Colors.lightGreen
  },
  {'id': 5,
   'name': Icons.sentiment_very_satisfied,
   'label': 'Excelente',
   'color': Colors.green
  },
];


class CalificacionWidget extends StatefulWidget {

  final int selected;
  final Function(Map<String, Object>) onPress;
  final bool animation;

  const CalificacionWidget({
    Key key,
    this.onPress,
    this.selected,
    this.animation = true
  }) : super(key: key);

  @override
  _CalificacionWidgetState createState() => _CalificacionWidgetState();
}

class _CalificacionWidgetState extends State<CalificacionWidget> {
  int selected;

  @override
  void initState() {
    super.initState();

    if (widget.selected != null)
      setState(() {
        selected = widget.selected;
      });
  }

  List<Widget> _getIcons() {
    List<Widget> _children = [];

    for (var item in puntajes) {
      _children.add(
        IconButton(
          padding: EdgeInsets.zero,
          iconSize: 60,
          onPressed: () {
            setState(() {
              this.selected = item['id'];
            });
            if (widget.onPress != null)
              widget.onPress(item);
          },
          icon: Icon(
            item['name'],
            color: this.selected != null && this.selected == item['id'] && widget.animation ? Colors.teal[300] : Colors.grey,
            size:  this.selected != null && this.selected == item['id'] && widget.animation ? 60 : 40,
          ),
        )
      );
    }

    return _children;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _getIcons()
    );
  }
}