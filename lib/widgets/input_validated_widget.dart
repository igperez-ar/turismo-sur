import 'package:flutter/material.dart';


class InputValidatedWidget extends StatefulWidget {

  final TextEditingController controller;
  final String hintText;
  final String initialValue;
  final IconData icon;
  final TextInputType inputType;
  final bool password;
  final TextEditingController validPassword;
  final bool email;
  final bool optional;
  final bool multiline;
  final TextCapitalization textCapitalization;
  final int max;
  final int min;

  const InputValidatedWidget({
    Key key,
    @required this.controller,
    this.hintText,
    this.initialValue,
    this.icon,
    this.inputType = TextInputType.text,
    this.password = false,
    this.validPassword,
    this.email = false,
    this.optional = false,
    this.multiline = false,
    this.textCapitalization = TextCapitalization.none,
    this.max,
    this.min,
  }) : super(key: key);

  @override
  _InputValidatedWidgetState createState() => _InputValidatedWidgetState();
}

class _InputValidatedWidgetState extends State<InputValidatedWidget> {
  bool error = false;
  FocusNode _focusNode;
  bool focus = false;

  @override 
  void initState() {
    super.initState();
    widget.controller.text = widget.initialValue;
    _focusNode = FocusNode();
    _focusNode.addListener(() => setState(() {
      focus = FocusScope.of(context).hasFocus;
    }));
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  bool isEmail(String email) {
    String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(email);
  }

  bool hasMin(String text, int min) {
    return text.length >= min;
  }

  String _hasError(String errorMessage) {
    setState(() {
      error = true;
    });
    return errorMessage;
  }

  String _validateText(String value) {
    if (!widget.optional && value.isEmpty) {
      return _hasError('El campo es obligatorio.');
    }

    if (widget.email == true && !isEmail(value)) {
      return _hasError('El email ingresado no es válido.');
    }

    if (widget.password == true && !hasMin(value, 8)) {
      return _hasError('El campo debe contener 8 caracteres como mínimo.');
    }

    if (widget.validPassword != null && value != widget.validPassword.text) {
      print(value);
      print(widget.validPassword.text);
      return _hasError('Las contraseñas no coinciden.');
    }

    setState(() { error = false; });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: TextFormField(
        focusNode: _focusNode,
        validator: (value) {
          return _validateText(value);
        },
        maxLines: widget.multiline ? null : 1,
        maxLength: widget.max,
        textAlign: TextAlign.left,
        textAlignVertical: TextAlignVertical.center,
        textCapitalization: widget.textCapitalization,
        controller: widget.controller,
        obscureText: widget.password ?? false,
        keyboardType: widget.inputType,
        decoration: InputDecoration( 
          counterText: _focusNode.hasFocus ? null : '',
          labelText: widget.hintText,
          labelStyle: TextStyle(
            color: _focusNode.hasFocus ? null : Colors.grey,
          ),
          alignLabelWithHint: true,
          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 15),
          fillColor: Colors.grey[200],
          filled: true,
          prefixIcon: ( widget.icon != null 
            ? Icon(widget.icon, color: this.error ? Colors.red[300] : null) 
            : null
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.teal),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.teal),
            borderRadius: BorderRadius.circular(15),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[400]),
            borderRadius: BorderRadius.circular(15),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2),
            borderRadius: BorderRadius.circular(15),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[400]),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}