import 'tipo_oficio.dart';
import '../data/comunes/canticos_evangelicos.dart';

class PreceOficio {
  final String inicio;
  final String respuesta;

  const PreceOficio({required this.inicio, required this.respuesta});
}

class Oficio {
  final String fecha;
  final TipoOficio tipo;

  final String himnoLiturgico;

  final String antifona1;
  final String salmo1Titulo;
  final String salmo1;

  final String antifona2;
  final String salmo2Titulo;
  final String salmo2;

  final String antifona3;
  final String? salmo3Titulo;
  final String salmo3;

  final String? salmo1Referencia;
  final String? salmo1Subtitulo;

  final String? salmo2Referencia;
  final String? salmo2Subtitulo;

  final String? salmo3Referencia;
  final String? salmo3Subtitulo;

  final String? introduccionPadreNuestro;

  final String lecturaBreveTitulo;
  final String lecturaBreve;

  final String responsorio;

  final String? rubricaSalmo2;
  final String? lecturaBreveReferencia;

  final String antifonaCantico;

  String get canticoTitulo =>
      tipo == TipoOficio.laudes ? 'Benedictus' : 'Magníficat';

  String get canticoReferencia =>
      tipo == TipoOficio.laudes ? 'Lc 1, 68-79' : 'Lc 1, 46-55';

  String get canticoSubtitulo => tipo == TipoOficio.laudes
      ? 'El Mesías y Precursor'
      : 'Alegría del alma en el Señor';

  String get cantico => tipo == TipoOficio.laudes ? benedictus : magnificat;

  final String introduccionPreces;
  final String respuestaPreces;
  final List<PreceOficio> preces;

  final String oracionConclusiva;

  const Oficio({
    required this.fecha,
    required this.tipo,
    required this.himnoLiturgico,
    required this.antifona1,
    required this.salmo1Titulo,
    required this.salmo1,
    required this.antifona2,
    required this.salmo2Titulo,
    required this.salmo2,
    this.rubricaSalmo2,
    required this.antifona3,
    this.salmo3Titulo,
    required this.salmo3,

    this.salmo1Referencia,
    this.salmo1Subtitulo,
    this.salmo2Referencia,
    this.salmo2Subtitulo,
    this.salmo3Referencia,
    this.salmo3Subtitulo,

    this.lecturaBreveReferencia,
    this.introduccionPadreNuestro,
    required this.lecturaBreveTitulo,
    required this.lecturaBreve,
    required this.responsorio,
    required this.antifonaCantico,

    required this.introduccionPreces,
    required this.respuestaPreces,
    required this.preces,
    required this.oracionConclusiva,
  });
}
