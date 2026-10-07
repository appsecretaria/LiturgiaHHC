import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettings extends ChangeNotifier {
  double _tamanoTexto = 18.0;
  bool _modoOscuro = false;

  bool _notificacionesCelebraciones = true;
  int _horaNotificacion = 8;
  int _minutoNotificacion = 0;

  double get tamanoTexto => _tamanoTexto;
  bool get modoOscuro => _modoOscuro;

  bool get notificacionesCelebraciones => _notificacionesCelebraciones;
  int get horaNotificacion => _horaNotificacion;
  int get minutoNotificacion => _minutoNotificacion;

  TimeOfDay get horaNotificacionTimeOfDay =>
      TimeOfDay(hour: _horaNotificacion, minute: _minutoNotificacion);

  Future<void> cargarPreferencias() async {
    final prefs = await SharedPreferences.getInstance();

    _tamanoTexto = prefs.getDouble('tamanoTexto') ?? 18.0;
    _modoOscuro = prefs.getBool('modoOscuro') ?? false;

    _notificacionesCelebraciones =
        prefs.getBool('notificacionesCelebraciones') ?? true;

    _horaNotificacion = prefs.getInt('horaNotificacion') ?? 8;
    _minutoNotificacion = prefs.getInt('minutoNotificacion') ?? 0;

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

  Future<void> cambiarNotificacionesCelebraciones(bool nuevoValor) async {
    if (_notificacionesCelebraciones == nuevoValor) return;

    _notificacionesCelebraciones = nuevoValor;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notificacionesCelebraciones', nuevoValor);
  }

  Future<void> cambiarHoraNotificacion(TimeOfDay nuevaHora) async {
    if (_horaNotificacion == nuevaHora.hour &&
        _minutoNotificacion == nuevaHora.minute) {
      return;
    }

    _horaNotificacion = nuevaHora.hour;
    _minutoNotificacion = nuevaHora.minute;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('horaNotificacion', nuevaHora.hour);
    await prefs.setInt('minutoNotificacion', nuevaHora.minute);
  }
}
