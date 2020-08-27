import 'package:flutter/material.dart';

 
class MultiSelect extends StatefulWidget {
  const MultiSelect({
    Key key, 
    @required this.options,
    @required this.selected,
  }): super(key: key);

  final List options;
  final List selected;

  @override
  _MultiSelectState createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelect> with TickerProviderStateMixin {
  bool open = false;
  List _selected = [];

  @override
  void initState() {
    super.initState();
    _selected = widget.selected;
  }

  Widget _checkBox(item, bool checked) {
    final _width = MediaQuery.of(context).size.width;

    return Container(
      width: _width / 2.5,
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              if (!checked) {
                setState(() {_selected.add(item);});

              } else {
                setState(() {_selected.remove(item);});
              }
            },
            child: Container(
              width: 25,
              height: 25,
              margin: EdgeInsets.only(right: 10),
              decoration: 
                (checked ? 
                  BoxDecoration( 
                    color: Colors.teal[300],
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 2,
                        spreadRadius: 1, 
                        offset: Offset(1, 1),
                      )
                    ],
                  ) :
                  BoxDecoration( 
                    border: Border.all(color: Colors.grey[300]),
                    borderRadius: BorderRadius.all(Radius.circular(8.0))
                  ) 
              ),
            ),
          ),
          Expanded(
            child: Text(
              item.nombre,
              overflow: TextOverflow.clip,
            )
          )
        ],
      )
    );  
  }

  Widget _chip(String title) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        color: Colors.teal[300],
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 2,
            spreadRadius: 1, 
            offset: Offset(1, 1),
          )
        ],
      ),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
        textAlign: TextAlign.center,
      )
    );
  }

  void _changeOpen() {
    setState(() {
      open = !open;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 3,
            spreadRadius: 2, 
            offset: Offset(2, 2),
          )
        ],        
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Flex(
        direction: Axis.vertical,
        children: <Widget>[
          Container(
            width: _width,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              child: Row(children: <Widget>[
                  Expanded(
                    child: (_selected.isEmpty ? 
                      Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text("Selecciona una opción.", style: TextStyle(
                            color: Colors.grey,
                            fontSize: 17,
                          ),
                        )
                      ) :
                      Container(
                        height: 50,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                          children: _selected.map<Widget>((item) => _chip(item.nombre)).toList(),
                        )
                      )
                    ),
                  ),
                  Container(
                    width: 50,
                    height: 40,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        open ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                        size: 40,
                        color: Colors.grey,
                      ),
                      onPressed: _changeOpen
                    ),
                  )
                ],
              )
            ),
          ),
          AnimatedSize(
            vsync: this,
            curve: Curves.fastOutSlowIn,
            duration: Duration(milliseconds: 200),
            child: Container(
              padding: EdgeInsets.only(bottom: 15),
              constraints: ( open 
                ? BoxConstraints(maxHeight: double.infinity)
                : BoxConstraints(maxHeight: 0.0)
              ),
              child: Wrap(
                runSpacing: 12,
                spacing: 10,
                children: widget.options.map<Widget>(
                  (item) => _checkBox(item, _selected.contains(item))
                ).toList()
              )
            )
          )
        ]
      )
    );
  }
}