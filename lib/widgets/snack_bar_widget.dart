import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

enum SnackType {
  success,
  danger,
  info,
}

class SnackBarWidget {

  static Map<SnackType, Color> typeColor = {
    SnackType.success: Colors.green[400],
    SnackType.danger: Colors.red[400],
    SnackType.info: Colors.blue[400]
  };

  static show(scaffoldKey, String message, SnackType type, {SnackBarAction action, bool persistent = true, Function onHide}) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      scaffoldKey.currentState.hideCurrentSnackBar();
      scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(message),
          action: action ?? SnackBarAction(
            label: action != null ? action.label : 'Ocultar',
            textColor: Colors.white,
            onPressed: () {
              scaffoldKey.currentState.hideCurrentSnackBar();
              if (onHide != null) 
                onHide();
            },
          ),
          backgroundColor: typeColor[type],
          behavior: SnackBarBehavior.floating,
          duration: persistent ? Duration(hours: 1) : Duration(seconds: 5),
          elevation: 2,
        )
      );
    });
  }
}