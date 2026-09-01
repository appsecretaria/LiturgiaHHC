import 'package:flutter/material.dart';

import '../models/celebracion.dart';
import '../models/lectura_espiritual.dart';

class LecturaEspiritualScreen extends StatefulWidget {
  final Celebracion celebracion;

  const LecturaEspiritualScreen({super.key, required this.celebracion});

  @override
  State<LecturaEspiritualScreen> createState() =>
      _LecturaEspiritualScreenState();
}

class _ContenidoLectura extends StatelessWidget {
  final LecturaEspiritual lectura;

  const _ContenidoLectura({required this.lectura});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          lectura.encabezado,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 14),

        Text(
          '(${lectura.referencia})',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            height: 1.35,
            color: colorScheme.primary,
          ),
        ),

        const SizedBox(height: 12),

        Text(
          lectura.subtitulo,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w600,
            color: colorScheme.primary,
          ),
        ),

        const SizedBox(height: 24),

        Text(
          lectura.contenido,
          textAlign: TextAlign.justify,
          style: const TextStyle(fontSize: 18, height: 1.5),
        ),
      ],
    );
  }
}

class _LecturaEspiritualScreenState extends State<LecturaEspiritualScreen> {
  int lecturaSeleccionada = -1;

  @override
  Widget build(BuildContext context) {
    final celebracion = widget.celebracion;

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
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                '${celebracion.dia} de ${_nombreMes(celebracion.mes)}',
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
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 22),

              const Text(
                'Lectura espiritual',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
