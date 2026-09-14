import '../models/celebracion.dart';
import '../models/oficio.dart';
import '../models/tipo_oficio.dart';
import '../data/oficios_san_vicente.dart';
import '../data/oficios_2sep.dart';
import '../data/oficios_9sep.dart';
import '../data/oficios_11sep.dart';

Oficio? obtenerOficio(Celebracion celebracion, TipoOficio tipo) {
  // Mártires franceses 2 septiembre
  if (celebracion.mes == 9 && celebracion.dia == 2) {
    switch (tipo) {
      case TipoOficio.primerasVisperas:
        return null;

      case TipoOficio.laudes:
        return laudesMartires2Septiembre;

      case TipoOficio.visperas:
        return visperasMartires2Sep;

      case TipoOficio.segundasVisperas:
        return null;
    }
  }
  // Federico Ozanam 9 septiembre
  if (celebracion.mes == 9 && celebracion.dia == 9) {
    switch (tipo) {
      case TipoOficio.primerasVisperas:
        return null;

      case TipoOficio.laudes:
        return laudesFedericoOzanam9Sep;

      case TipoOficio.visperas:
        return visperasFedericoOzanam9Sep;

      case TipoOficio.segundasVisperas:
        return null;
    }
  }
  // Juan Gabriel Perboyre 11 septiembre
  if (celebracion.mes == 9 && celebracion.dia == 11) {
    switch (tipo) {
      case TipoOficio.primerasVisperas:
        return null;

      case TipoOficio.laudes:
        return laudesSanJuanGabrielPerboyre11Sep;

      case TipoOficio.visperas:
        return visperasSanJuanGabrielPerboyre11Sep;

      case TipoOficio.segundasVisperas:
        return null;
    }
  }
  // San Vicente de Paúl 27 septiembre
  if (celebracion.mes == 9 && celebracion.dia == 27) {
    switch (tipo) {
      case TipoOficio.primerasVisperas:
        return primerasVisperasSanVicente;

      case TipoOficio.laudes:
        return laudesSanVicente;

      case TipoOficio.visperas:
        return null;

      case TipoOficio.segundasVisperas:
        return segundasVisperasSanVicente;
    }
  }

  return null;
}
