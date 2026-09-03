import 'package:flutter/material.dart';

import '../models/celebracion.dart';
import '../models/lectura_espiritual.dart';
import '../main.dart';

class LecturaEspiritualScreen extends StatefulWidget {
  final Celebracion celebracion;

  const LecturaEspiritualScreen({super.key, required this.celebracion});

  @override
  State<LecturaEspiritualScreen> createState() =>
      _LecturaEspiritualScreenState();
}

class _LecturaEspiritualScreenState extends State<LecturaEspiritualScreen> {
  int lecturaSeleccionada = -1;
  late double tamanoTexto;

  @override
  Widget build(BuildContext context) {
    final celebracion = widget.celebracion;

    final settings = AppSettingsScope.of(context);
    tamanoTexto = settings.tamanoTexto;
    final modoOscuro = settings.modoOscuro;

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
        actions: [
          IconButton(
            tooltip: 'Disminuir texto',
            onPressed: () {
              if (tamanoTexto > 16) {
                settings.cambiarTamanoTexto(tamanoTexto - 2);
              }
            },
            icon: const Icon(Icons.text_decrease),
          ),
          IconButton(
            tooltip: 'Aumentar texto',
            onPressed: () {
              if (tamanoTexto < 30) {
                settings.cambiarTamanoTexto(tamanoTexto + 2);
              }
            },
            icon: const Icon(Icons.text_increase),
          ),
          IconButton(
            tooltip: modoOscuro ? 'Modo claro' : 'Modo oscuro',
            onPressed: () {
              settings.cambiarModoOscuro(!settings.modoOscuro);
            },
            icon: Icon(
              modoOscuro ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                '${celebracion.dia} de ${_nombreMes(celebracion.mes)}',
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
                  fontSize: tamanoTexto + 9,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 22),

              Text(
                'Lectura espiritual',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: tamanoTexto + 4,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 18),

              for (int i = 0; i < celebracion.lecturasEspirituales.length; i++)
                _BotonLectura(
                  titulo: celebracion.lecturasEspirituales[i].titulo,
                  seleccionado: lecturaSeleccionada == i,
                  onTap: () {
                    setState(() {
                      lecturaSeleccionada = i;
                    });
                  },
                ),

              if (lecturaSeleccionada >= 0) ...[
                const SizedBox(height: 28),

                _ContenidoLectura(
                  lectura:
                      celebracion.lecturasEspirituales[lecturaSeleccionada],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _nombreMes(int mes) {
    const meses = [
      'enero',
      'febrero',
      'marzo',
      'abril',
      'mayo',
      'junio',
      'julio',
      'agosto',
      'septiembre',
      'octubre',
      'noviembre',
      'diciembre',
    ];

    return meses[mes - 1];
  }
}

class _ContenidoLectura extends StatelessWidget {
  final LecturaEspiritual lectura;

  const _ContenidoLectura({required this.lectura});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final tamanoTexto = AppSettingsScope.of(context).tamanoTexto;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          lectura.encabezado,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: tamanoTexto + 1,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 14),

        Text(
          '(${lectura.referencia})',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: tamanoTexto - 2,
            height: 1.35,
            fontStyle: FontStyle.italic,
            color: colorScheme.primary,
          ),
        ),

        const SizedBox(height: 12),

        Text(
          lectura.subtitulo,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: tamanoTexto + 1,
            fontWeight: FontWeight.w600,
            color: colorScheme.primary,
          ),
        ),

        const SizedBox(height: 24),

        Text(
          lectura.contenido,
          textAlign: TextAlign.justify,
          style: TextStyle(fontSize: tamanoTexto, height: 1.5),
        ),
      ],
    );
  }
}

class _BotonLectura extends StatelessWidget {
  final String titulo;
  final bool seleccionado;
  final VoidCallback onTap;

  const _BotonLectura({
    required this.titulo,
    required this.seleccionado,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final tamanoTexto = AppSettingsScope.of(context).tamanoTexto;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 0,
      color: seleccionado
          ? colorScheme.secondaryContainer
          : colorScheme.surfaceContainerHighest,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Text(
            titulo,
            style: TextStyle(
              fontSize: tamanoTexto,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
