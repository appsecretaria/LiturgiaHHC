enum TipoOficio { primerasVisperas, laudes, visperas, segundasVisperas }

extension TipoOficioExtension on TipoOficio {
  String get titulo {
    switch (this) {
      case TipoOficio.primerasVisperas:
        return 'I Vísperas';

      case TipoOficio.laudes:
        return 'Laudes';

      case TipoOficio.visperas:
        return 'Vísperas';

      case TipoOficio.segundasVisperas:
        return 'II Vísperas';
    }
  }
}
