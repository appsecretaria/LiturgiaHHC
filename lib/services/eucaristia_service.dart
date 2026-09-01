import '../models/celebracion.dart';
import '../models/eucaristia.dart';
import '../data/eucaristia_san_vicente.dart';

Eucaristia? obtenerEucaristia(Celebracion celebracion) {
  if (celebracion.mes == 9 && celebracion.dia == 27) {
    return eucaristiaSanVicente;
  }

  return null;
}
