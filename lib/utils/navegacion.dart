import 'package:flutter/cupertino.dart';

void abrirPantalla(BuildContext context, Widget pantalla) {
  Navigator.of(context)
      .push(CupertinoPageRoute(builder: (context) => pantalla));
}
