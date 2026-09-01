import 'package:flutter/material.dart';

import '../models/celebracion.dart';

class InformacionCelebracionScreen extends StatelessWidget {
  final Celebracion celebracion;

  const InformacionCelebracionScreen({super.key, required this.celebracion});

  @override
  Widget build(BuildContext context) {
    final biografia = celebracion.informacion.isNotEmpty
        ? celebracion.informacion.first
        : null;

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
                style: const TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 22),

              /*if (celebracion.rubrica != null)
                Text(
                  celebracion.rubrica!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),*/
              if (celebracion.descripcion != null) ...[
                const SizedBox(height: 8),
                Text(
                  celebracion.descripcion!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17,
                    height: 1.3,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],

              const SizedBox(height: 6),

              Text(
                celebracion.tipo,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),

              const SizedBox(height: 28),

              const Text(
                'Biografía breve',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 18),

              if (biografia != null)
                ...biografia.contenido.split('\n').map((linea) {
                  final texto = linea.trim();

                  // Subtítulos marcados con ##
                  if (texto.startsWith('## ')) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 18, bottom: 8),
                      child: Text(
                        texto.substring(3),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    );
                  }

                  // Línea vacía = separación entre párrafos
                  if (texto.isEmpty) {
                    return const SizedBox(height: 10);
                  }

                  // Texto normal
                  return Text(
                    texto,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(fontSize: 18, height: 1.5),
                  );
                })
              else
                const Text(
                  'Biografía no disponible.',
                  textAlign: TextAlign.center,
                ),
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
