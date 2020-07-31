import 'package:flutter/material.dart';

enum SnackType {
  success,
  danger,
  info,
}

class SnackBarWidget extends StatefulWidget {
  final String message;
  final Map<String, dynamic> button;
  final SnackType type;

  const SnackBarWidget({
    Key key,
    @required this.message,
    @required this.type,
    this.button
  }): super(key: key);

  @override
  _SnackBarWidgetState createState() => _SnackBarWidgetState();
}

class _SnackBarWidgetState extends State<SnackBarWidget> with TickerProviderStateMixin {
  bool isShow = true;

  @override
  void didUpdateWidget(oldWidget) {
    show();
    super.didUpdateWidget(oldWidget);
  }

  void show() {
    setState(() {
      isShow = true;
    });
  }

  void hide() {
    setState(() {
      isShow = false;
    });
  }

  Color _getColor() {
    switch (widget.type) {
      case SnackType.success:
        return Colors.green[400];
        break;
      case SnackType.info:
        return Colors.blue;
        break;
      case SnackType.danger:
        return Colors.red;
        break;
      default: 
        return Colors.grey[700];
    }
  }

  @override
  Widget build(BuildContext context) {

    if (isShow)
      return Container(
        margin: EdgeInsets.only(top: 5, left: 5, right: 5),
        padding: EdgeInsets.only(left: 15),
        decoration: BoxDecoration(
          color: _getColor().withOpacity(0.9),
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 2,
              spreadRadius: 2,
              offset: Offset(2, 2)
            )
          ]
        ),
        child: Flex(
          direction: Axis.vertical,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(widget.message, 
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15
                  ),
                ),
                ( widget.button != null
                  ? IconButton(
                      onPressed: widget.button['action'],
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        widget.button['icon'],
                      )
                    )
                  : IconButton(
                      onPressed: hide,
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        Icons.close,
                        color: Colors.white,
                      )
                    )
                )
              ],
            )
          ]
        )
      );

    return Container();
  }
}
