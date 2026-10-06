class LecturaEspiritual {
  final String titulo;

  // Encabezado que aparecerá encima de la lectura.
  // Ej.: "De los escritos de San Vicente de Paúl"
  final String encabezado;

  // Referencia de la fuente.
  // Ej.: "(Conferencia a los misioneros...)"
  final String referencia;

  // Subtítulo propio del texto.
  // Ej.: "Dispuestos a la prisión y al martirio por su misericordia"
  final String subtitulo;

  // Cuerpo completo de la lectura.
  final String contenido;

  // Enlace externo opcional.
  final String? url;

  // Texto que aparecerá en el botón del enlace.
  final String? textoUrl;

  const LecturaEspiritual({
    required this.titulo,
    required this.encabezado,
    required this.referencia,
    required this.subtitulo,
    required this.contenido,
    this.url,
    this.textoUrl,
  });
}
