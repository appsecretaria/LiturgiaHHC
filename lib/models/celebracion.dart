import 'apartado_informacion.dart';
import 'lectura_espiritual.dart';

class Celebracion {
  final int mes;
  final int dia;
  final String nombre;
  final String tipo;
  final String? imagen;
  final bool primerasVisperas;
  final bool laudes;
  final bool eucaristia;
  final bool segundasVisperas;
  final bool lecturaEspiritual;
  final String? rubrica;
  final String? descripcion;
  final String? pdfUrl;

  final List<ApartadoInformacion> informacion;

  final List<LecturaEspiritual> lecturasEspirituales;

  const Celebracion({
    required this.mes,
    required this.dia,
    required this.nombre,
    required this.tipo,
    this.imagen,
    this.primerasVisperas = false,
    this.laudes = true,
    this.eucaristia = true,
    this.segundasVisperas = true,
    this.lecturaEspiritual = true,
    this.lecturasEspirituales = const [],
    this.rubrica,
    this.descripcion,
    this.pdfUrl,
    this.informacion = const [],
  });
}
