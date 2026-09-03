import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettings extends ChangeNotifier {
  double _tamanoTexto = 18.0;
  bool _modoOscuro = false;

  double get tamanoTexto => _tamanoTexto;
  bool get modoOscuro => _modoOscuro;

  Future<void> cargarPreferencias() async {
    final prefs = await SharedPreferences.getInstance();

    _tamanoTexto = prefs.getDouble('tamanoTexto') ?? 18.0;
    _modoOscuro = prefs.getBool('modoOscuro') ?? false;

    notifyListeners();
  }

  Future<void> cambiarTamanoTexto(double nuevoTamano) async {
    if (_tamanoTexto == nuevoTamano) return;

    _tamanoTexto = nuevoTamano;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('tamanoTexto', nuevoTamano);
  }

  Future<void> cambiarModoOscuro(bool nuevoValor) async {
    if (_modoOscuro == nuevoValor) return;

    _modoOscuro = nuevoValor;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('modoOscuro', nuevoValor);
  }
}
