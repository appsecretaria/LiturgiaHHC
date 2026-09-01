class Himno {
  final String titulo;
  final String letra;
  final String? audioUrl;
  final String? partituraUrl;
  final bool esYoutube;

  const Himno({
    required this.titulo,
    required this.letra,
    this.audioUrl,
    this.partituraUrl,
    this.esYoutube = false,
  });
}
