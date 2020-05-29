import 'package:flutter/material.dart';

class MultiSelect extends StatefulWidget {
  const MultiSelect({
    Key key, 
    @required this.options,
    this.onChange,
  }): super(key: key);

  final List options;
  final Function onChange;

  @override
  _MultiSelectState createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelect> {
  bool open;
  List _selected = [];
            

  _MultiSelectState({this.open = false});

  Widget _checkBox(item, bool checked) {
    final _width = MediaQuery.of(context).size.width;

    return Container(
      width: _width / 2.5,
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              setState(() {
                if (!checked) {
                  _selected.add(item.id);
                } else {
                  _selected.removeWhere((id) {
                    return id == item.id;
                  });
                }
              });
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
                        color: Colors.grey[200],
                        blurRadius: 5,
                        spreadRadius: 2, 
                        offset: Offset(2, 2),
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
            color: Colors.grey[300],
            blurRadius: 5,
            spreadRadius: 2, 
            offset: Offset(2, 2),
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

    return Flex(
      direction: Axis.vertical,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey[300],
                blurRadius: 5,
                spreadRadius: 2, 
                offset: Offset(2, 2),
              )
            ],
          ),
        child: Column(
          children: <Widget>[
            Container(
              width: _width,
              padding: EdgeInsets.only(left: 10, right: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(15),
                  bottom: (open ? Radius.zero : Radius.circular(15))
                ),
              ),
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
                            children: _selected.map<Widget>((id) {
                              final index = widget.options.indexWhere((item) => item.id == id);
                              return _chip(widget.options[index].nombre);
                            }).toList(),
                          )
                        )
                      ),
                    ),
                    Container(
                      width: 50,
                      height: 40,
                      child: IconButton(
                        padding: EdgeInsets.only(bottom:5),
                        icon: Icon(
                          (open ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down),
                          size: 40,
                          color: Colors.grey,
                        ),
                        onPressed: _changeOpen
                      )
                    )
                  ],
                )
              ),
            ),
            Container(
              width: _width,
              height: (open ? null : 0),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
              ),
              child: Wrap(
                runSpacing: 12,
                spacing: 10,
                children: widget.options.map<Widget>((item) {
                  return _checkBox(item, _selected.contains(item.id));
                }).toList()
              )
            ),
          ]
        )
        )
      ]
    );
  }
}