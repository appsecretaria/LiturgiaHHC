import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:just_audio/just_audio.dart';

import 'pdf_screen.dart';
import '../utils/navegacion.dart';

import '../models/celebracion.dart';
import '../data/himnos_san_vicente.dart';

class IVisperasScreen extends StatefulWidget {
  final Celebracion celebracion;

  const IVisperasScreen({super.key, required this.celebracion});

  @override
  State<IVisperasScreen> createState() => _IVisperasScreenState();
}

class _IVisperasScreenState extends State<IVisperasScreen> {
  bool mostrarHimnosCantados = false;
  int? himnoSeleccionado;
  double tamanoTexto = 18;
  bool modoOscuro = false;
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

    return Theme(
      data: modoOscuro
          ? ThemeData.dark(useMaterial3: true).copyWith(
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xFF9E1B1B),
                brightness: Brightness.dark,
              ),
            )
          : Theme.of(context),
      child: Scaffold(
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
                  '26 de septiembre',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  celebracion.nombre,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 27,
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
                        setState(() {
                          if (tamanoTexto > 14) {
                            tamanoTexto -= 2;
                          }
                        });
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
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(width: 4),

                    // AUMENTAR TEXTO
                    IconButton(
                      tooltip: 'Aumentar texto',
                      onPressed: () {
                        setState(() {
                          if (tamanoTexto < 30) {
                            tamanoTexto += 2;
                          }
                        });
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
                        setState(() {
                          modoOscuro = !modoOscuro;
                        });
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

                _botonHimnoCantado(),

                if (mostrarHimnosCantados) ...[
                  const SizedBox(height: 10),
                  _listaHimnos(),
                ],

                const SizedBox(height: 32),

                const Text(
                  'I Vísperas',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
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
                    '¿Qué nuevo triunfo cantan, hoy, los cielos?\n'
                    '¿qué nuevo aplauso los santos tributan?\n'
                    '¡La luz del clero, el Padre de los pobres\n'
                    'brilla en la Gloria!\n\n'
                    'Obras ingentes loan tus proezas\n'
                    'y el Amor ciñe de laurel tu frente:\n'
                    'cuanto le diste al pobre con largueza\n'
                    'te vuelve el Cielo.\n\n'
                    'Los sacerdotes, siendo tú su guía,\n'
                    'llevan al pobre la verdad de Cristo:\n'
                    'la madre Iglesia vive y canoniza\n'
                    'tu Magisterio.\n\n'
                    'Pero te honran de manera insigne\n'
                    'vírgenes castas que, a la vez, son madres:\n'
                    'los pobres gozan, bajo tu mirada,\n'
                    'de su ternura.\n\n'
                    'Como aliviaste el dolor del mísero\n'
                    'oye hoy, benigno, el clamor del pueblo:\n'
                    'todos los pobres, juntos te proclaman\n'
                    'Padre y amigo.\n\n'
                    'Demos, hoy, todos, gloria al Padre Eterno\n'
                    'y al Hijo Ungido Salvador del hombre\n'
                    'y al Amor mismo, llama de Dios vivo\n'
                    'que arde en Vicente. ¡Amén!',
                    style: TextStyle(fontSize: tamanoTexto, height: 1.5),
                  )
                else
                  _himnoSeleccionado(),

                const SizedBox(height: 28),

                _antifona(
                  context,
                  'Ant. 1.',
                  'Los pobres y necesitados buscan agua y no la encuentran; '
                      'yo el Señor los oiré; yo el Dios de Israel no los abandonaré.',
                ),

                const SizedBox(height: 24),

                _tituloCentrado(context, 'Salmo 112'),

                const SizedBox(height: 14),

                Text(
                  'Alabad, siervos del Señor,\n'
                  'alabad el nombre del Señor.\n'
                  'Bendito sea el nombre del Señor,\n'
                  'ahora y por siempre:\n'
                  'de la salida del sol hasta su ocaso\n'
                  'alabado sea el nombre del Señor.\n\n'
                  'El Señor se eleva sobre todos los pueblos,\n'
                  'su gloria sobre los cielos.\n'
                  '¿Quién como el Señor Dios nuestro,\n'
                  'que se eleva en su trono\n'
                  'y se abaja para mirar\n'
                  'al cielo y a la tierra?\n\n'
                  'Levanta del polvo al desvalido,\n'
                  'alza de la basura al pobre,\n'
                  'para sentarlo con los príncipes,\n'
                  'los príncipes de su pueblo;\n'
                  'a la estéril le da un puesto en la casa,\n'
                  'como madre feliz de hijos.\n\n'
                  'Gloria al Padre, y al Hijo, y al Espíritu Santo.\n'
                  'Como era en el principio, ahora y siempre,\n'
                  'por los siglos de los siglos. Amén.',
                  style: TextStyle(fontSize: tamanoTexto, height: 1.5),
                ),

                const SizedBox(height: 20),

                _antifona(
                  context,
                  'Ant. 1.',
                  'Los pobres y necesitados buscan agua y no la encuentran; '
                      'yo el Señor los oiré; yo el Dios de Israel no los abandonaré.',
                ),

                const SizedBox(height: 28),

                _antifona(
                  context,
                  'Ant. 2.',
                  'Os daré pastores según mi corazón y os apacentarán en ciencia y en doctrina.',
                ),

                const SizedBox(height: 24),

                _tituloCentrado(context, 'Salmo 145'),

                const SizedBox(height: 14),

                Text(
                  'Alaba, alma mía, al Señor:\n'
                  'alabaré al Señor mientras viva,\n'
                  'tañeré para mi Dios mientras exista.\n\n'
                  'No confiéis en los príncipes,\n'
                  'seres de polvo que no pueden salvar;\n'
                  'exhalan el espíritu y vuelven al polvo,\n'
                  'ese día perecen sus planes.\n\n'
                  'Dichoso a quien auxilia el Dios de Jacob,\n'
                  'el que espera en el Señor, su Dios,\n'
                  'que hizo el cielo y la tierra,\n'
                  'el mar y cuanto hay en él;\n\n'
                  'que mantiene su fidelidad perpetuamente\n'
                  'que hace justicia a los oprimidos,\n'
                  'que da pan a los hambrientos.\n\n'
                  'El Señor liberta a los cautivos,\n'
                  'el Señor abre los ojos al ciego,\n'
                  'el Señor endereza a los que ya se doblan,\n'
                  'el Señor ama a los justos.\n\n'
                  'El Señor guarda a los peregrinos,\n'
                  'sustenta al huérfano y a la viuda\n'
                  'y trastorna el camino de los malvados.\n\n'
                  'El Señor reina eternamente,\n'
                  'tu Dios, Sión, de edad en edad.\n\n'
                  'Gloria al Padre, y al Hijo, y al Espíritu Santo.\n'
                  'Como era en el principio, ahora y siempre,\n'
                  'por los siglos de los siglos. Amén.',
                  style: TextStyle(fontSize: tamanoTexto, height: 1.5),
                ),

                const SizedBox(height: 20),

                _antifona(
                  context,
                  'Ant. 2.',
                  'Os daré pastores según mi corazón y os apacentarán en ciencia y en doctrina.',
                ),

                const SizedBox(height: 28),

                _antifona(
                  context,
                  'Ant. 3.',
                  'Embriagaré el alma de mis sacerdotes con la abundancia '
                      'y colmaré a mi pueblo de mis bienes.',
                ),

                const SizedBox(height: 24),

                Text(
                  'Bendito sea Dios,\n'
                  'Padre de nuestro Señor Jesucristo,\n'
                  'que nos ha bendecido en la persona de Cristo\n'
                  'con toda clase de bienes espirituales y celestiales.\n\n'
                  'Él nos eligió en la persona de Cristo,\n'
                  'antes de crear el mundo,\n'
                  'para que fuésemos santos\n'
                  'e irreprochables ante él por el amor.\n\n'
                  'Él nos ha destinado en la persona de Cristo,\n'
                  'por pura iniciativa suya,\n'
                  'a ser sus hijos,\n'
                  'para que la gloria de su gracia,\n'
                  'que tan generosamente nos ha concedido\n'
                  'en su querido Hijo,\n'
                  'redunde en alabanza suya.\n\n'
                  'Por este Hijo, por su sangre,\n'
                  'hemos recibido la redención,\n'
                  'el perdón de los pecados.\n'
                  'El tesoro de su gracia, sabiduría y prudencia\n'
                  'ha sido un derroche para con nosotros,\n'
                  'dándonos a conocer el Misterio de su Voluntad.\n\n'
                  'Éste es el plan que había proyectado realizar por Cristo\n'
                  'cuando llegase el momento culminante:\n'
                  'recapitular en Cristo todas las cosas\n'
                  'del cielo y de la tierra.\n\n'
                  'Gloria al Padre, y al Hijo, y al Espíritu Santo.\n'
                  'Como era en el principio, ahora y siempre,\n'
                  'por los siglos de los siglos. Amén.',
                  style: TextStyle(fontSize: tamanoTexto, height: 1.5),
                ),

                const SizedBox(height: 20),

                _antifona(
                  context,
                  'Ant. 3.',
                  'Embriagaré el alma de mis sacerdotes con la abundancia '
                      'y colmaré a mi pueblo de mis bienes.',
                ),

                const SizedBox(height: 32),

                _tituloSeccion(context, 'Lectura breve: 1 Jn 4,19-21'),

                const SizedBox(height: 12),

                Text(
                  'Nosotros amamos a Dios, porque Él nos amó primero. '
                  'Si alguno dice: Amo a Dios y aborrece a su hermano, '
                  'es un mentiroso, pues quien no ama a su hermano a quien ve, '
                  'no puede amar a Dios a quien no ve. '
                  'Y hemos recibido de Él este mandamiento: '
                  'Quien ama a Dios, ame también a su hermano.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: tamanoTexto, height: 1.5),
                ),

                const SizedBox(height: 32),

                _tituloSeccion(context, 'Responsorio breve'),

                const SizedBox(height: 12),

                _versiculo(
                  context,
                  'V/',
                  'Me gozaré y alegraré en tu misericordia.',
                ),
                _versiculo(
                  context,
                  'R/',
                  'Me gozaré y alegraré en tu misericordia.',
                ),
                _versiculo(context, 'V/', 'Porque has mirado mi aflicción.'),
                _versiculo(context, 'R/', 'En tu misericordia.'),
                _versiculo(
                  context,
                  'V/',
                  'Gloria al Padre, y al Hijo, y al Espíritu Santo.',
                ),
                _versiculo(
                  context,
                  'R/',
                  'Me gozaré y alegraré en tu misericordia.',
                ),

                const SizedBox(height: 32),

                _tituloSeccion(context, 'Cántico evangélico'),

                const SizedBox(height: 12),

                _antifona(
                  context,
                  'Ant.',
                  'El Espíritu del Señor está sobre mí, '
                      'me envió a evangelizar a los pobres.',
                ),

                const SizedBox(height: 22),

                _tituloCentrado(context, 'Magníficat'),

                const SizedBox(height: 14),

                Text(
                  'Proclama mi alma la grandeza del Señor,\n'
                  'se alegra mi espíritu en Dios, mi salvador;\n'
                  'porque ha mirado la humillación de su esclava.\n\n'
                  'Desde ahora me felicitarán todas las generaciones,\n'
                  'porque el Poderoso ha hecho obras grandes por mí:\n'
                  'su nombre es santo,\n'
                  'y su misericordia llega a sus fieles\n'
                  'de generación en generación.\n\n'
                  'Él hace proezas con su brazo:\n'
                  'dispersa a los soberbios de corazón,\n'
                  'derriba del trono a los poderosos\n'
                  'y enaltece a los humildes,\n'
                  'a los hambrientos los colma de bienes\n'
                  'y a los ricos los despide vacíos.\n\n'
                  'Auxilia a Israel, su siervo,\n'
                  'acordándose de su misericordia\n'
                  '-como lo había prometido a nuestros padres-\n'
                  'en favor de Abraham y su descendencia por siempre.\n\n'
                  'Gloria al Padre, y al Hijo, y al Espíritu Santo.\n'
                  'Como era en el principio, ahora y siempre, '
                  'por los siglos de los siglos. Amén.',
                  style: TextStyle(fontSize: tamanoTexto, height: 1.5),
                ),

                const SizedBox(height: 20),

                _antifona(
                  context,
                  'Ant.',
                  'El Espíritu del Señor está sobre mí, '
                      'me envió a evangelizar a los pobres.',
                ),

                const SizedBox(height: 32),

                _tituloSeccion(context, 'Preces'),

                const SizedBox(height: 12),

                _versiculo(
                  context,
                  'V/',
                  'Al recordar con alegría a San Vicente de Paúl, '
                      'imploremos la tierna bondad de Dios, para que despierte '
                      'y renueve siempre en la Familia Vicenciana el espíritu '
                      'de nuestro Padre, y digámosle con confianza:',
                ),

                const SizedBox(height: 8),

                _versiculo(context, 'R/', 'Inflámanos en tu amor.'),

                const SizedBox(height: 18),

                prece(
                  'Tú que enviaste a tu Hijo para que trajera la Buena Noticia a los pobres,',
                  'que jamás deje la Iglesia de anunciar la Palabra Salvadora.',
                ),

                prece(
                  'Tú que llamaste a la Familia Vicenciana a participar en la misión de tu Hijo,',
                  'concédele tener los mismos sentimientos y afectos llenándose de su espíritu.',
                ),

                prece(
                  'Que aprendamos realmente a amar a nuestro pueblo y a todo ser humano,',
                  'y a construir una convivencia humana en la paz y en el bienestar.',
                ),

                prece(
                  'Tú que cifraste en el amor la perfección de la ley, muévenos a compartir el gozo de los alegres y la pena de los tristes,',
                  'para que nuestro amor revierta más en bien de todos.',
                ),

                prece(
                  'Tú que hiciste a todos según tu imagen,',
                  'haz que nuestra entrega contribuya a luchar contra las injusticias.',
                ),

                prece(
                  'Tú que suscitas continuamente el propósito santo de dar la vida para servirte a ti y a los hermanos,',
                  'sosténnos con la fuerza del Espíritu que nos llama a ser en el mundo testigos del amor de Cristo.',
                ),

                prece(
                  'Que quienes se esforzaron por reconocerte y amarte en los más pobres,',
                  'lleguen a contemplarte, cara a cara, por siempre en tu Reino.',
                ),

                const SizedBox(height: 24),

                _tituloSeccion(context, 'Padre Nuestro'),

                const SizedBox(height: 32),

                _tituloSeccion(context, 'Oración conclusiva'),

                const SizedBox(height: 12),

                Text(
                  'Señor Dios nuestro, que para la evangelización de los pobres '
                  'y la formación del clero, infundiste en tu bienaventurado sacerdote '
                  'Vicente las virtudes apostólicas, haz, te rogamos, que los que seguimos '
                  'el ejemplo de su vida sintamos de continuo la urgencia de la caridad '
                  'para perpetuar la misión de tu Hijo en el mundo. '
                  'Por nuestro Señor Jesucristo, tu Hijo, que vive y reina contigo '
                  'en la unidad del Espíritu Santo y es Dios, por los siglos de los siglos. Amén.',
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
      ),
    );
  }

  Widget _botonHimnoCantado() {
    return Align(
      alignment: Alignment.centerLeft,
      child: FilledButton.tonalIcon(
        onPressed: () {
          setState(() {
            mostrarHimnosCantados = !mostrarHimnosCantados;
          });
        },
        icon: const Icon(Icons.music_note),
        label: const Text(
          'Himno cantado',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _listaHimnos() {
    return Column(
      children: [
        for (int i = 0; i < himnosSanVicente.length; i++)
          Card(
            margin: const EdgeInsets.only(bottom: 6),
            elevation: 0,
            child: ListTile(
              leading: const Icon(Icons.music_note_outlined),
              title: Text(
                himnosSanVicente[i].titulo,
                style: const TextStyle(
                  fontSize: 17,
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

  Widget _himnoSeleccionado() {
    if (himnoSeleccionado == null) {
      return const SizedBox();
    }

    final himno = himnosSanVicente[himnoSeleccionado!];

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

        switch (himnoSeleccionado) {
          0 => _himnoSanVicente(),

          _ => Text(
            'Este himno todavía no tiene la letra disponible.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: tamanoTexto,
              fontStyle: FontStyle.italic,
            ),
          ),
        },
      ],
    );
  }

  Widget _himnoSanVicente() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Himno a San Vicente de Paúl',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 18),

        Text(
          'Enséñanos a amar Vicente de Paúl\n'
          'al pobre nuestro hermano\n'
          'como lo amaste tú. (bis)',
          style: TextStyle(
            fontSize: tamanoTexto,
            height: 1.5,
            fontWeight: FontWeight.bold,
          ),
        ),

        SizedBox(height: 18),

        Text(
          'No sabemos sufrir con los que sufren,\n'
          'rehusamos llorar con los que lloran,\n'
          'ignoramos la voz que nos suplica\n'
          'y la mano que hambrienta nos implora.\n\n'
          'Acallamos a veces entre rezos,\n'
          'el clamor de los pobres que nos gritan,\n'
          'con palabras de Cristo y su Evangelio\n'
          'que sólo es el amor lo que da vida.\n\n'
          'Vicente de Paúl que descubriste,\n'
          'a Cristo desvalido entre los pobres,\n'
          'que a la luz de tu vida descubramos,\n'
          'que ellos son nuestros Amos y Señores.',
          style: TextStyle(fontSize: tamanoTexto, height: 1.5),
        ),

        const SizedBox(height: 16),

        Text(
          'Letra: JAVIER ÍÑIGO, CM',
          textAlign: TextAlign.right,
          style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
        ),
      ],
    );
  }

  Widget _tituloSeccion(BuildContext context, String titulo) {
    return Text(
      titulo,
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  Widget _tituloCentrado(BuildContext context, String titulo) {
    return Text(
      titulo,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 21,
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
