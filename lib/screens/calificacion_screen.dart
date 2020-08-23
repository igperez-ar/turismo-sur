import 'package:flutter/material.dart';
import 'package:turismo_app/widgets/widgets.dart';

List<Map<String,Object>> destacables = [
  {
    'id': 1,
    'nombre': 'Excelente servicio',
    'icono': '5',
    'tipo': 'Ambos',  
  },
  {
    'id': 2,
    'nombre': 'Gran conversación',
    'icono': '5',
    'tipo': 'Ambos',  
  },
  {
    'id': 3,
    'nombre': 'Instalaciones limpias',
    'icono': '5',
    'tipo': 'Ambos',  
  },
  {
    'id': 5,
    'nombre': 'Increible vista',
    'icono': '5',
    'tipo': 'Ambos',  
  },
];


class CalificacionScreen extends StatefulWidget {

  final Map<String, Object> selected;

  const CalificacionScreen({
    Key key,
    this.selected,
  }) : super(key: key);

  @override
  _CalificacionScreenState createState() => _CalificacionScreenState();
}

class _CalificacionScreenState extends State<CalificacionScreen> {
  Map<String, Object> selected;
  int destacableSelected;
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.selected != null)
      setState(() {
        selected = widget.selected;
      });
  }

  Widget _getDestacables() {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: destacables
        .map((item) => Container(
          margin: EdgeInsets.symmetric(horizontal: 5),
          padding: EdgeInsets.all(5),
          width: 110,
          decoration: BoxDecoration(
            /* border: Border.all(
              color: this.destacableSelected != null && this.destacableSelected == item['id'] ? Colors.green : Colors.transparent,
              width: 1.5
            ),
            borderRadius: BorderRadius.circular(15) */
          ),
          child: GestureDetector(
            onTap: () => this.setState(() {
              this.destacableSelected = this.destacableSelected == item['id'] ? null : item['id']; 
            }),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 80,
                  width: 80,
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: this.destacableSelected == item['id'] ? Colors.teal[300] : Colors.transparent,
                      width: 5
                    )
                  ),
                ),
                Text(item['nombre'],
                  style: TextStyle(
                    fontWeight: this.destacableSelected == item['id'] ? FontWeight.bold : FontWeight.normal
                  ),
                  overflow: TextOverflow.clip,
                  /* softWrap: false, */
                  textAlign: TextAlign.center,
                )
              ],
            )
          ), 
        ))
        .toList()
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Calificar', 
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.white, size: 30.0,), 
          onPressed: () => Navigator.pop(context),
        )
      ),
      body: Column(
        children: [
          SizedBox(height: 30),
          ( this.selected != null 
            ? Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Text(selected['label'],
                style: TextStyle(
                  color: Colors.grey[700],
                  fontWeight: FontWeight.bold,
                  fontSize: 25
                )
              ) 
            )
            : Container()
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: CalificacionWidget(
              selected: this.selected != null ? this.selected['id'] : null,
              onPress: (item) => this.setState(() {
                this.selected = item; 
              }),
            )
          ),
          Container(
            /* height: 45, */
            constraints: BoxConstraints(minHeight: 200, maxHeight: 300),
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Colors.grey[400],
                width: 1
              )
            ),
            child: Flex( 
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Flexible(
                  child: TextField(
                    textCapitalization: TextCapitalization.sentences,
                    maxLength: 500,
                    controller: _textEditingController,
                    /* onEditingComplete: _processText, */
                    decoration: InputDecoration(
                      hintText: 'Describe tu experiencia',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                    minLines: 9,
                    maxLines: 15,
                  ),
                )
              ]
            )
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.all(20),
            child: Text('¿Qué destacarías?', 
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          Container(
            height: 150,
            child: _getDestacables()
          ),
          FlatButton(
            onPressed: () {},
            padding: EdgeInsets.zero,
            textColor: Colors.teal,
            child: Text('Publicar', 
              style: TextStyle(
                fontSize: 16
              ),
            )
          )
        ],
      )
    );
  }
}