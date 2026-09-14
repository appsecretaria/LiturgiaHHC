import '../models/celebracion.dart';
import '../models/eucaristia.dart';
import '../data/eucaristia_san_vicente.dart';
import '../data/eucaristia_2sep.dart';
import '../data/eucaristia_9sep.dart';
import '../data/eucaristia_11sep.dart';
import '../data/eucaristia_25oct.dart';

Eucaristia? obtenerEucaristia(Celebracion celebracion) {
  if (celebracion.mes == 9 && celebracion.dia == 2) {
    return eucaristiaMartires2Sep;
  }

  if (celebracion.mes == 9 && celebracion.dia == 9) {
    return eucaristiaFedericoOzanam9Sep;
  }

  if (celebracion.mes == 9 && celebracion.dia == 11) {
    return eucaristiaSanJuanGabrielPerboyre11Sep;
  }

  if (celebracion.mes == 9 && celebracion.dia == 27) {
    return eucaristiaSanVicente;
  }

  if (celebracion.mes == 10 && celebracion.dia == 25) {
    return eucaristia25Oct;
  }

  return null;
}
