import 'dart:convert';

import 'package:flutter/services.dart';

Future<List<String>> obtenerSantosDelDia(DateTime fecha) async {
  final texto = await rootBundle.loadString('assets/data/santoral.json');

  final List<dynamic> datos = jsonDecode(texto);

  for (final registro in datos) {
    if (registro['mes'] == fecha.month && registro['dia'] == fecha.day) {
      return List<String>.from(registro['santos']);
    }
  }

  return [];
}
