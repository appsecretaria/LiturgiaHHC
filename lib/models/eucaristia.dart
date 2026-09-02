class Eucaristia {
  final String fecha;
  final String titulo;
  final String grado;
  final String? introduccion;

  final String antifonaEntradaReferencia;
  final String antifonaEntrada;
  final String? antifonaEntradaAlternativaReferencia;
  final String? antifonaEntradaAlternativa;

  final String? rubricaGloria;

  final String oracionColecta;
  final String? oracionColectaAlternativa;

  final String primeraLecturaTitulo;
  final String? rubricaLecturas;
  final String primeraLecturaEncabezado;
  final String primeraLecturaReferencia;
  final String primeraLectura;

  final String salmoReferencia;
  final String salmoRespuesta;
  final List<String> salmoEstrofas;

  final String segundaLecturaTitulo;
  final String segundaLecturaEncabezado;
  final String segundaLecturaReferencia;
  final String segundaLectura;

  final String aleluyaReferencia;
  final String aleluya;

  final String evangelioEncabezado;
  final String evangelioReferencia;
  final String evangelio;

  final String? rubricaCredo;

  final String introduccionFieles;
  final List<String> peticionesFieles;
  final String conclusionFieles;

  final String oracionOfrendas;

  final String prefacioTitulo;
  final String prefacio;

  final String antifonaComunionReferencia;
  final String antifonaComunion;
  final String? antifonaComunionAlternativaReferencia;
  final String? antifonaComunionAlternativa;

  final String oracionFinal;

  final List<String> bendicionSolemne;

  const Eucaristia({
    required this.fecha,
    required this.titulo,
    required this.grado,
    this.introduccion,

    required this.antifonaEntradaReferencia,
    required this.antifonaEntrada,
    this.antifonaEntradaAlternativaReferencia,
    this.antifonaEntradaAlternativa,

    this.rubricaGloria,

    required this.oracionColecta,
    this.oracionColectaAlternativa,

    required this.primeraLecturaTitulo,
    this.rubricaLecturas,
    required this.primeraLecturaEncabezado,
    required this.primeraLecturaReferencia,
    required this.primeraLectura,

    required this.salmoReferencia,
    required this.salmoRespuesta,
    required this.salmoEstrofas,

    required this.segundaLecturaTitulo,
    required this.segundaLecturaEncabezado,
    required this.segundaLecturaReferencia,
    required this.segundaLectura,

    required this.aleluyaReferencia,
    required this.aleluya,

    required this.evangelioEncabezado,
    required this.evangelioReferencia,
    required this.evangelio,

    this.rubricaCredo,

    required this.introduccionFieles,
    required this.peticionesFieles,
    required this.conclusionFieles,

    required this.oracionOfrendas,

    required this.prefacioTitulo,
    required this.prefacio,

    required this.antifonaComunionReferencia,
    required this.antifonaComunion,
    this.antifonaComunionAlternativaReferencia,
    this.antifonaComunionAlternativa,

    required this.oracionFinal,

    required this.bendicionSolemne,
  });
}
