import '../models/celebracion.dart';
import '../models/eucaristia.dart';
import '../data/eucaristia_san_vicente.dart';
import '../data/eucaristia_2sep.dart';
import '../data/eucaristia_9sep.dart';

Eucaristia? obtenerEucaristia(Celebracion celebracion) {
  if (celebracion.mes == 9 && celebracion.dia == 2) {
    return eucaristiaMartires2Sep;
  }

  if (celebracion.mes == 9 && celebracion.dia == 9) {
    return eucaristiaFedericoOzanam9Sep;
  }

  if (celebracion.mes == 9 && celebracion.dia == 27) {
    return eucaristiaSanVicente;
  }

  return null;
}
