import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:just_audio/just_audio.dart';

import '../models/himno.dart';

import 'pdf_screen.dart';
import '../utils/navegacion.dart';

import '../models/celebracion.dart';
import '../data/himnos_san_vicente.dart';
import '../data/himnos_federico_ozanam.dart';
import '../models/tipo_oficio.dart';
import '../services/oficio_service.dart';
import '../main.dart';

class OficioScreen extends StatefulWidget {
  final Celebracion celebracion;
  final TipoOficio tipo;

  const OficioScreen({
    super.key,
    required this.celebracion,
    required this.tipo,
  });

  @override
  State<OficioScreen> createState() => _OficioScreenState();
}

class _OficioScreenState extends State<OficioScreen> {
  bool mostrarHimnosCantados = false;
  int? himnoSeleccionado;
  late double tamanoTexto;
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool reproduciendo = false;
  Duration posicionAudio = Duration.zero;
  Duration duracionAudio = Duration.zero;
  bool cargandoAudio = false;
  int? audioSeleccionado;

  Future<void> abrirAudio(String url) async {
    final uri = Uri.parse(url);

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('No se pudo abrir el audio');
    }
  }

  Future<void> reproducirAudio(String url, bool esYoutube, int indice) async {
    if (esYoutube) {
      await abrirAudio(url);
      return;
    }

    try {
      // Si pulsamos el mismo himno que ya está cargado:
      if (audioSeleccionado == indice) {
        if (_audioPlayer.playing) {
          await _audioPlayer.pause();
        } else {
          await _audioPlayer.play();
        }
        return;
      }

      // Hemos elegido otro himno.
      setState(() {
        cargandoAudio = true;
        audioSeleccionado = indice;
        posicionAudio = Duration.zero;
        duracionAudio = Duration.zero;
      });

      await _audioPlayer.setUrl(url);

      if (mounted) {
        setState(() {
          cargandoAudio = false;
        });
      }

      await _audioPlayer.play();
    } catch (e) {
      if (mounted) {
        setState(() {
          cargandoAudio = false;
        });
      }

      debugPrint('Error reproduciendo audio: $e');
    }
  }

  @override
  void initState() {
    super.initState();

    _audioPlayer.positionStream.listen((posicion) {
      if (mounted) {
        setState(() {
          posicionAudio = posicion;
        });
      }
    });

    _audioPlayer.durationStream.listen((duracion) {
      if (mounted && duracion != null) {
        setState(() {
          duracionAudio = duracion;
        });
      }
    });

    _audioPlayer.playerStateStream.listen((estado) {
      if (mounted) {
        setState(() {
          reproduciendo = estado.playing;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final celebracion = widget.celebracion;
    final oficio = obtenerOficio(widget.celebracion, widget.tipo);

    final settings = AppSettingsScope.of(context);
    tamanoTexto = settings.tamanoTexto;
    final modoOscuro = settings.modoOscuro;

    final List<Himno> himnosDisponibles;

    if (celebracion.mes == 9 && celebracion.dia == 27) {
      himnosDisponibles = himnosSanVicente;
    } else if (celebracion.mes == 9 && celebracion.dia == 9) {
      himnosDisponibles = himnosFedericoOzanam;
    } else {
      himnosDisponibles = [];
    }

    if (oficio == null) {
      return Scaffold(
        appBar: AppBar(title: Text(widget.tipo.titulo)),
        body: Center(
          child: Text(
            'Este oficio todavía no está disponible.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: tamanoTexto),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 48,
        leadingWidth: 52,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 40, weight: 700),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                oficio.fecha,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: tamanoTexto + 4,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                celebracion.nombre,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: tamanoTexto + 5,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 18),

              const Divider(height: 1, thickness: 1),

              const SizedBox(height: 1),

              Row(
                children: [
                  // DISMINUIR TEXTO
                  IconButton(
                    tooltip: 'Disminuir texto',
                    onPressed: () {
                      if (tamanoTexto > 16) {
                        settings.cambiarTamanoTexto(tamanoTexto - 2);
                      }
                    },
                    icon: Image.asset(
                      modoOscuro
                          ? 'assets/icons/menos-bn.png'
                          : 'assets/icons/menos.png',
                      width: 24,
                      height: 24,
                    ),
                  ),

                  const SizedBox(width: 4),

                  // TAMAÑO ACTUAL
                  Text(
                    '${tamanoTexto.toInt()}',
                    style: TextStyle(
                      fontSize: tamanoTexto - 1,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(width: 4),

                  // AUMENTAR TEXTO
                  IconButton(
                    tooltip: 'Aumentar texto',
                    onPressed: () {
                      if (tamanoTexto < 30) {
                        settings.cambiarTamanoTexto(tamanoTexto + 2);
                      }
                    },
                    icon: Image.asset(
                      modoOscuro
                          ? 'assets/icons/mas-bn.png'
                          : 'assets/icons/mas.png',
                      width: 24,
                      height: 24,
                    ),
                  ),

                  const Spacer(),

                  // MODO CLARO / OSCURO
                  IconButton(
                    tooltip: modoOscuro ? 'Modo claro' : 'Modo oscuro',
                    onPressed: () {
                      settings.cambiarModoOscuro(!settings.modoOscuro);
                    },
                    icon: Image.asset(
                      modoOscuro
                          ? 'assets/icons/soleado-bn.png'
                          : 'assets/icons/luna-creciente.png',
                      width: 32,
                      height: 32,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 1),

              const Divider(height: 1, thickness: 1),

              const SizedBox(height: 20),

              _botonHimnoCantado(himnosDisponibles),

              if (mostrarHimnosCantados && himnosDisponibles.isNotEmpty) ...[
                const SizedBox(height: 10),
                _listaHimnos(himnosDisponibles),
              ],

              const SizedBox(height: 32),

              Text(
                oficio.titulo,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: tamanoTexto + 10,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 28),

              _tituloSeccion(context, 'Invocación inicial'),

              const SizedBox(height: 12),

              _versiculo(context, 'V/', 'Dios mío, ven en mi auxilio.'),

              _versiculo(context, 'R/', 'Señor, date prisa en socorrerme.'),

              const SizedBox(height: 18),

              _versiculo(
                context,
                'V/',
                'Gloria al Padre, y al Hijo, y al Espíritu Santo.',
              ),

              _versiculo(
                context,
                'R/',
                'Como era en el principio, ahora y siempre, '
                    'por los siglos de los siglos. Amén. Aleluya.',
              ),

              const SizedBox(height: 28),

              _tituloSeccion(context, 'Himno'),

              const SizedBox(height: 12),

              if (himnoSeleccionado == null)
                Text(
                  oficio.himnoLiturgico,
                  style: TextStyle(fontSize: tamanoTexto, height: 1.5),
                )
              else
                _himnoSeleccionado(himnosDisponibles),

              const SizedBox(height: 28),

              _antifona(context, 'Ant. 1.', oficio.antifona1),

              const SizedBox(height: 24),

              _cabeceraSalmo(
                context,
                titulo: oficio.salmo1Titulo,
                referencia: oficio.salmo1Referencia,
                subtitulo: oficio.salmo1Subtitulo,
              ),

              const SizedBox(height: 14),

              Text(
                oficio.salmo1,
                style: TextStyle(fontSize: tamanoTexto, height: 1.5),
              ),

              const SizedBox(height: 20),

              _antifona(context, 'Ant. 1.', oficio.antifona1),

              const SizedBox(height: 28),

              _antifona(context, 'Ant. 2.', oficio.antifona2),

              const SizedBox(height: 24),

              _cabeceraSalmo(
                context,
                titulo: oficio.salmo2Titulo,
                referencia: oficio.salmo2Referencia,
                subtitulo: oficio.salmo2Subtitulo,
              ),

              const SizedBox(height: 14),

              Text(
                oficio.salmo2,
                style: TextStyle(fontSize: tamanoTexto, height: 1.5),
              ),

              if (oficio.rubricaSalmo2 != null) ...[
                const SizedBox(height: 8),
                Text(
                  oficio.rubricaSalmo2!,
                  style: TextStyle(
                    fontSize: tamanoTexto,
                    fontStyle: FontStyle.italic,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],

              const SizedBox(height: 20),

              _antifona(context, 'Ant. 2.', oficio.antifona2),

              const SizedBox(height: 28),

              _antifona(context, 'Ant. 3.', oficio.antifona3),

              if (oficio.salmo3Titulo != null) ...[
                const SizedBox(height: 24),

                _cabeceraSalmo(
                  context,
                  titulo: oficio.salmo3Titulo!,
                  referencia: oficio.salmo3Referencia,
                  subtitulo: oficio.salmo3Subtitulo,
                ),

                const SizedBox(height: 14),
              ],

              Text(
                oficio.salmo3,
                style: TextStyle(fontSize: tamanoTexto, height: 1.5),
              ),

              const SizedBox(height: 20),

              _antifona(context, 'Ant. 3.', oficio.antifona3),

              const SizedBox(height: 32),

              _tituloSeccion(context, oficio.lecturaBreveTitulo),

              if (oficio.lecturaBreveReferencia != null) ...[
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    oficio.lecturaBreveReferencia!,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: tamanoTexto,
                      fontStyle: FontStyle.italic,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
              ],

              const SizedBox(height: 8),

              Text(
                oficio.lecturaBreve,
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: tamanoTexto, height: 1.5),
              ),

              const SizedBox(height: 32),

              _tituloSeccion(context, 'Responsorio breve'),

              const SizedBox(height: 12),

              ...oficio.responsorio.split('\n').map((linea) {
                final esVersiculo = linea.startsWith('V/');
                final esRespuesta = linea.startsWith('R/');

                if (!esVersiculo && !esRespuesta) {
                  return Text(
                    linea,
                    style: TextStyle(fontSize: tamanoTexto, height: 1.5),
                  );
                }

                final indicador = esVersiculo ? 'V/' : 'R/';
                final texto = linea.substring(2).trim();

                return Padding(
                  padding: const EdgeInsets.only(bottom: 1),
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: tamanoTexto,
                        height: 1.5,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      children: [
                        TextSpan(
                          text: '$indicador ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        TextSpan(text: texto),
                      ],
                    ),
                  ),
                );
              }),

              const SizedBox(height: 32),

              _tituloSeccion(context, 'Cántico evangélico'),

              const SizedBox(height: 12),

              _antifona(context, 'Ant.', oficio.antifonaCantico),

              const SizedBox(height: 22),

              _cabeceraSalmo(
                context,
                titulo: oficio.canticoTitulo,
                referencia: oficio.canticoReferencia,
                subtitulo: oficio.canticoSubtitulo,
              ),

              const SizedBox(height: 14),

              Text(
                oficio.cantico,
                style: TextStyle(fontSize: tamanoTexto, height: 1.5),
              ),

              const SizedBox(height: 20),

              _antifona(context, 'Ant.', oficio.antifonaCantico),

              const SizedBox(height: 32),

              _tituloSeccion(context, 'Preces'),

              const SizedBox(height: 12),

              _versiculo(context, 'V/', oficio.introduccionPreces),

              const SizedBox(height: 8),

              _versiculo(context, 'R/', oficio.respuestaPreces),

              const SizedBox(height: 16),

              ...oficio.preces.map(
                (item) => prece(item.inicio, item.respuesta),
              ),

              const SizedBox(height: 24),

              if (oficio.introduccionPadreNuestro != null) ...[
                Text(
                  oficio.introduccionPadreNuestro!,
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: tamanoTexto, height: 1.5),
                ),

                const SizedBox(height: 16),
              ],

              _tituloSeccion(context, 'Padre Nuestro'),

              const SizedBox(height: 32),

              _tituloSeccion(context, 'Oración conclusiva'),

              const SizedBox(height: 12),

              Text(
                oficio.oracionConclusiva,
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: tamanoTexto, height: 1.5),
              ),

              const SizedBox(height: 32),

              _tituloSeccion(context, 'Conclusión'),

              const SizedBox(height: 12),

              _versiculo(
                context,
                'V/',
                'El Señor nos bendiga, nos guarde de todo mal '
                    'y nos lleve a la vida eterna.',
              ),

              _versiculo(context, 'R/', 'Amén.'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cabeceraSalmo(
    BuildContext context, {
    required String titulo,
    String? referencia,
    String? subtitulo,
  }) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: Text(
                titulo,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: tamanoTexto + 3,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),

            if (referencia != null)
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  referencia,
                  style: TextStyle(
                    fontSize: tamanoTexto,
                    fontStyle: FontStyle.italic,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
          ],
        ),

        if (subtitulo != null) ...[
          const SizedBox(height: 5),
          Text(
            subtitulo,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: tamanoTexto - 1,
              fontStyle: FontStyle.italic,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ],
    );
  }

  Widget _botonHimnoCantado(List<Himno> himnos) {
    if (himnos.isEmpty) {
      return const SizedBox.shrink();
    }

    return Align(
      alignment: Alignment.centerLeft,
      child: FilledButton.tonalIcon(
        onPressed: () {
          setState(() {
            mostrarHimnosCantados = !mostrarHimnosCantados;
          });
        },
        icon: const Icon(Icons.music_note),
        label: Text(
          'Himno cantado',
          style: TextStyle(fontSize: tamanoTexto, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _listaHimnos(List<Himno> himnos) {
    return Column(
      children: [
        for (int i = 0; i < himnos.length; i++)
          Card(
            margin: const EdgeInsets.only(bottom: 6),
            elevation: 0,
            child: ListTile(
              leading: const Icon(Icons.music_note_outlined),
              title: Text(
                himnos[i].titulo,
                style: TextStyle(
                  fontSize: tamanoTexto - 1,
                  fontWeight: FontWeight.w600,
                ),
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                setState(() {
                  himnoSeleccionado = i;
                  mostrarHimnosCantados = false;
                });
              },
            ),
          ),
      ],
    );
  }

  Widget _reproductorAudio() {
    if (cargandoAudio) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: CircularProgressIndicator(),
        ),
      );
    }

    final duracionMaxima = duracionAudio.inMilliseconds.toDouble();

    final posicion = posicionAudio.inMilliseconds
        .clamp(0, duracionAudio.inMilliseconds)
        .toDouble();

    return Column(
      children: [
        Slider(
          value: duracionMaxima > 0 ? posicion : 0,
          max: duracionMaxima > 0 ? duracionMaxima : 1,
          onChanged: duracionMaxima > 0
              ? (valor) {
                  _audioPlayer.seek(Duration(milliseconds: valor.toInt()));
                }
              : null,
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(_formatearDuracion(posicionAudio)),
            Text(_formatearDuracion(duracionAudio)),
          ],
        ),

        const SizedBox(height: 6),

        IconButton.filled(
          iconSize: 34,
          onPressed: () async {
            if (_audioPlayer.playing) {
              await _audioPlayer.pause();
            } else {
              await _audioPlayer.play();
            }
          },
          icon: Icon(reproduciendo ? Icons.pause : Icons.play_arrow),
        ),
      ],
    );
  }

  String _formatearDuracion(Duration duracion) {
    final minutos = duracion.inMinutes;
    final segundos = duracion.inSeconds.remainder(60);

    return '$minutos:${segundos.toString().padLeft(2, '0')}';
  }

  Widget _himnoSeleccionado(List<Himno> himnos) {
    if (himnoSeleccionado == null || himnoSeleccionado! >= himnos.length) {
      return const SizedBox();
    }

    final himno = himnos[himnoSeleccionado!];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (himno.audioUrl != null)
              ElevatedButton.icon(
                onPressed: () {
                  reproducirAudio(
                    himno.audioUrl!,
                    himno.esYoutube,
                    himnoSeleccionado!,
                  );
                },
                icon: const Icon(Icons.play_arrow),
                label: const Text('Escuchar'),
              ),

            if (himno.partituraUrl != null) ...[
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: () {
                  abrirPantalla(
                    context,
                    PdfScreen(titulo: himno.titulo, url: himno.partituraUrl!),
                  );
                },
                icon: const Icon(Icons.music_note_outlined),
                label: const Text('Partitura'),
              ),
            ],
          ],
        ),

        if (!himno.esYoutube && audioSeleccionado == himnoSeleccionado) ...[
          const SizedBox(height: 16),
          _reproductorAudio(),
        ],

        const SizedBox(height: 20),

        Text(
          himno.titulo,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: tamanoTexto + 4,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 18),

        Text(himno.letra, style: TextStyle(fontSize: tamanoTexto, height: 1.5)),
      ],
    );
  }

  Widget _tituloSeccion(BuildContext context, String titulo) {
    return Text(
      titulo,
      style: TextStyle(
        fontSize: tamanoTexto + 4,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  Widget _versiculo(BuildContext context, String indicador, String texto) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: '$indicador ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            TextSpan(text: texto),
          ],
        ),
        style: TextStyle(fontSize: tamanoTexto, height: 1.4),
      ),
    );
  }

  Widget _antifona(BuildContext context, String numero, String texto) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '$numero ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          TextSpan(
            text: texto,
            style: const TextStyle(fontStyle: FontStyle.italic),
          ),
        ],
      ),
      style: TextStyle(fontSize: tamanoTexto, height: 1.45),
    );
  }

  Widget prece(String inicio, String respuesta) {
    final colorGranate = Theme.of(context).colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 10),
                child: Container(
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(
                    color: colorGranate,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  inicio,
                  style: TextStyle(fontSize: tamanoTexto, height: 1.5),
                ),
              ),
            ],
          ),

          const SizedBox(height: 4),

          Padding(
            padding: const EdgeInsets.only(left: 17),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '– ',
                    style: TextStyle(
                      color: colorGranate,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: respuesta,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
              style: TextStyle(fontSize: tamanoTexto, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
