import 'package:flutter/material.dart';

import '../models/celebracion.dart';
import '../main.dart';

class InformacionCelebracionScreen extends StatefulWidget {
  final Celebracion celebracion;

  const InformacionCelebracionScreen({super.key, required this.celebracion});

  @override
  State<InformacionCelebracionScreen> createState() =>
      _InformacionCelebracionScreenState();
}

class _InformacionCelebracionScreenState
    extends State<InformacionCelebracionScreen> {
  late double tamanoTexto;

  @override
  Widget build(BuildContext context) {
    final celebracion = widget.celebracion;

    final settings = AppSettingsScope.of(context);
    tamanoTexto = settings.tamanoTexto;
    final modoOscuro = settings.modoOscuro;

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

              if (celebracion.descripcion != null) ...[
                const SizedBox(height: 8),
                Text(
                  celebracion.descripcion!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: tamanoTexto - 1,
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
                  fontSize: tamanoTexto,
                  fontStyle: FontStyle.italic,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),

              const SizedBox(height: 28),

              Text(
                'Biografía breve',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: tamanoTexto + 4,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 18),

              if (biografia != null)
                ...biografia.contenido.split('\n').map((linea) {
                  final texto = linea.trim();

                  if (texto.startsWith('## ')) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 18, bottom: 8),
                      child: Text(
                        texto.substring(3),
                        style: TextStyle(
                          fontSize: tamanoTexto + 2,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    );
                  }

                  if (texto.isEmpty) {
                    return const SizedBox(height: 10);
                  }

                  return Text(
                    texto,
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: tamanoTexto, height: 1.5),
                  );
                })
              else
                Text(
                  'Biografía no disponible.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: tamanoTexto),
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
