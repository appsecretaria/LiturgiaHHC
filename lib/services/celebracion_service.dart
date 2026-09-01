import '../data/celebraciones.dart';
import '../models/celebracion.dart';

Celebracion? obtenerCelebracion(DateTime fecha) {
  for (final celebracion in celebracionesVicencianas) {
    if (celebracion.mes == fecha.month &&
        celebracion.dia == fecha.day) {
      return celebracion;
    }
  }

  return null;
}