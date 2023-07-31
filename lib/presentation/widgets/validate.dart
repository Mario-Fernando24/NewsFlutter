// Función para mostrar el modal emergente
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/constant.dart';

void showModalConnecty(BuildContext context) {
  showCupertinoDialog(
      context: context,
      builder: (_) {
        return CupertinoAlertDialog(
          title: Text("Datos moviles desactivados"),
          content: Text(
              "ha ocurrido un error de conexión, por favor intente nuevamente"),
          actions: [
            CupertinoDialogAction(
              isDestructiveAction: true,
              child: Text(
                "Cerrar",
                style: TextStyle(color: Colors.blue),
              ),
              onPressed: () => {Navigator.pop(context)}, 
            )
          ],
        );
      });
}
