import '../models/celebracion.dart';
import '../models/oficio.dart';
import '../models/tipo_oficio.dart';
import '../data/oficios_san_vicente.dart';
import '../data/oficios_2sep.dart';

Oficio? obtenerOficio(Celebracion celebracion, TipoOficio tipo) {
  // Mártires franceses 2 septiembre
  if (celebracion.mes == 9 && celebracion.dia == 2) {
    switch (tipo) {
      case TipoOficio.primerasVisperas:
        return null;

      case TipoOficio.laudes:
        return laudesMartires2Septiembre;

      case TipoOficio.segundasVisperas:
        return visperasMartires2Sep;
    }
  }
  // San Vicente de Paúl
  if (celebracion.mes == 9 && celebracion.dia == 27) {
    switch (tipo) {
      case TipoOficio.primerasVisperas:
        return primerasVisperasSanVicente;

      case TipoOficio.laudes:
        return laudesSanVicente;

      case TipoOficio.segundasVisperas:
        return segundasVisperasSanVicente;
    }
  }

  return null;
}
