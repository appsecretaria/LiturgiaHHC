import 'package:flutter/material.dart';

class AppSettings extends ChangeNotifier {
  double _tamanoTexto = 18.0;

  double get tamanoTexto => _tamanoTexto;

  void cambiarTamanoTexto(double nuevoTamano) {
    if (_tamanoTexto == nuevoTamano) return;

    _tamanoTexto = nuevoTamano;
    notifyListeners();
  }
}
