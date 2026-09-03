import 'package:flutter/material.dart';

import '../models/celebracion.dart';
import '../services/eucaristia_service.dart';
import '../main.dart';

class EucaristiaScreen extends StatefulWidget {
  final Celebracion celebracion;

  const EucaristiaScreen({super.key, required this.celebracion});

  @override
  State<EucaristiaScreen> createState() => _EucaristiaScreenState();
}

class _EucaristiaScreenState extends State<EucaristiaScreen> {
  late double tamanoTexto;

  @override
  Widget build(BuildContext context) {
    final eucaristia = obtenerEucaristia(widget.celebracion);

    final settings = AppSettingsScope.of(context);
    tamanoTexto = settings.tamanoTexto;
    final modoOscuro = settings.modoOscuro;

    if (eucaristia == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Eucaristía')),
        body: Center(
          child: Text(
            'La Eucaristía de esta celebración todavía no está disponible.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: tamanoTexto),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Eucaristía'),
        actions: [
          IconButton(
            tooltip: 'Disminuir texto',
            onPressed: () {
              if (tamanoTexto > 14) {
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
            tooltip: 'Modo oscuro',
            onPressed: () {
              settings.cambiarModoOscuro(!settings.modoOscuro);
            },
            icon: Icon(
              modoOscuro ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                eucaristia.fecha,
                style: TextStyle(
                  fontSize: tamanoTexto + 4,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),

            const SizedBox(height: 8),

            Center(
              child: Text(
                eucaristia.titulo,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: tamanoTexto + 5,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),

            const SizedBox(height: 14),

            Center(
              child: Text(
                eucaristia.grado,
                style: TextStyle(
                  fontSize: tamanoTexto + 2,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.normal,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),

            if (eucaristia.introduccion != null) ...[
              const SizedBox(height: 24),
              Text(
                eucaristia.introduccion!,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: tamanoTexto,
                  height: 1.5,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],

            const SizedBox(height: 28),

            _tituloSeccion(context, 'Antífona de entrada'),
            _referencia(context, eucaristia.antifonaEntradaReferencia),
            const SizedBox(height: 8),
            _texto(eucaristia.antifonaEntrada),

            if (eucaristia.antifonaEntradaAlternativa != null) ...[
              const SizedBox(height: 16),
              _oBien(context),
              _referencia(
                context,
                eucaristia.antifonaEntradaAlternativaReferencia!,
              ),
              const SizedBox(height: 8),
              _texto(eucaristia.antifonaEntradaAlternativa!),
            ],

            if (eucaristia.rubricaGloria != null) ...[
              const SizedBox(height: 18),
              _rubrica(context, eucaristia.rubricaGloria!),
            ],

            const SizedBox(height: 28),

            _tituloSeccion(context, 'Oración colecta'),
            _texto(eucaristia.oracionColecta),

            if (eucaristia.oracionColectaAlternativa != null) ...[
              const SizedBox(height: 16),
              _oBien(context),
              _texto(eucaristia.oracionColectaAlternativa!),
            ],

            const SizedBox(height: 32),

            _tituloSeccion(context, 'Liturgia de la Palabra'),

            if (eucaristia.rubricaLecturas != null) ...[
              const SizedBox(height: 16),
              Text(
                eucaristia.rubricaLecturas!,
                style: TextStyle(
                  fontSize: tamanoTexto,
                  fontStyle: FontStyle.italic,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 12),
            ],

            _subtitulo(context, 'PRIMERA LECTURA'),

            if (eucaristia.primeraLecturaTitulo.isNotEmpty) ...[
              const SizedBox(height: 8),
              _tituloLectura(context, eucaristia.primeraLecturaTitulo),
            ],

            _encabezadoLectura(eucaristia.primeraLecturaEncabezado),

            _referencia(context, eucaristia.primeraLecturaReferencia),

            const SizedBox(height: 8),

            _texto(eucaristia.primeraLectura),

            const SizedBox(height: 12),

            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Palabra de Dios',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: tamanoTexto,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),

            const SizedBox(height: 28),

            _subtitulo(context, 'SALMO RESPONSORIAL'),
            _referencia(context, eucaristia.salmoReferencia),

            const SizedBox(height: 8),

            _respuestaSalmo(context, eucaristia.salmoRespuesta),

            const SizedBox(height: 16),

            ...eucaristia.salmoEstrofas.map(
              (estrofa) => Padding(
                padding: const EdgeInsets.only(bottom: 18),
                child: _estrofaSalmo(context, estrofa),
              ),
            ),

            const SizedBox(height: 10),

            if (eucaristia.segundaLectura.isNotEmpty) ...[
              _subtitulo(context, 'SEGUNDA LECTURA'),

              if (eucaristia.segundaLecturaTitulo.isNotEmpty) ...[
                const SizedBox(height: 8),
                _tituloLectura(context, eucaristia.segundaLecturaTitulo),
              ],

              if (eucaristia.segundaLecturaEncabezado.isNotEmpty)
                _encabezadoLectura(eucaristia.segundaLecturaEncabezado),

              if (eucaristia.segundaLecturaReferencia.isNotEmpty)
                _referencia(context, eucaristia.segundaLecturaReferencia),

              const SizedBox(height: 8),

              _texto(eucaristia.segundaLectura),

              const SizedBox(height: 8),

              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Palabra de Dios.',
                  style: TextStyle(
                    fontSize: tamanoTexto,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],

            if (eucaristia.aleluya.isNotEmpty) ...[
              const SizedBox(height: 18),
              _subtitulo(context, 'ALELUYA'),

              if (eucaristia.aleluyaReferencia.isNotEmpty)
                _referencia(context, eucaristia.aleluyaReferencia),

              const SizedBox(height: 8),

              _texto(eucaristia.aleluya),

              const SizedBox(height: 18),
            ],

            const SizedBox(height: 8),

            _tituloSeccion(context, 'Evangelio'),
            _encabezadoLectura(eucaristia.evangelioEncabezado),
            _referencia(context, eucaristia.evangelioReferencia),
            const SizedBox(height: 8),
            _texto(eucaristia.evangelio),

            const SizedBox(height: 12),

            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Palabra del Señor',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: tamanoTexto,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),

            if (eucaristia.rubricaCredo != null) ...[
              const SizedBox(height: 18),
              _rubrica(context, eucaristia.rubricaCredo!),
            ],

            const SizedBox(height: 28),

            _tituloSeccion(context, 'Oración de los fieles'),
            _texto(eucaristia.introduccionFieles),

            const SizedBox(height: 16),

            ...eucaristia.peticionesFieles.map(
              (peticion) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _peticion(context, peticion),
              ),
            ),

            _texto(eucaristia.conclusionFieles),

            const SizedBox(height: 28),

            _tituloSeccion(context, 'Oración sobre las ofrendas'),
            _texto(eucaristia.oracionOfrendas),

            const SizedBox(height: 28),

            if (eucaristia.prefacio.isNotEmpty) ...[
              _tituloSeccion(context, 'Prefacio'),

              const SizedBox(height: 8),

              if (eucaristia.prefacioTitulo.isNotEmpty) ...[
                Center(
                  child: Text(
                    eucaristia.prefacioTitulo,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: tamanoTexto,
                      fontStyle: FontStyle.italic,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),

                const SizedBox(height: 18),
              ],

              ...eucaristia.prefacio.split('\n').map((linea) {
                final esVersiculo = linea.startsWith('V/');
                final esRespuesta = linea.startsWith('R/');

                if (!esVersiculo && !esRespuesta) {
                  final esSanto = linea.trim().startsWith(
                    'Santo, Santo, Santo',
                  );

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 3),
                    child: Text(
                      linea,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: tamanoTexto,
                        height: 1.5,
                        fontWeight: esSanto
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  );
                }

                final indicador = esVersiculo ? 'V/' : 'R/';
                final texto = linea.substring(2).trim();

                return Padding(
                  padding: EdgeInsets.only(bottom: esVersiculo ? 0 : 0.1),
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
              const SizedBox(height: 28),
            ],

            _tituloSeccion(context, 'Antífona de comunión'),
            _referencia(context, eucaristia.antifonaComunionReferencia),
            const SizedBox(height: 18),
            _texto(eucaristia.antifonaComunion),

            if (eucaristia.antifonaComunionAlternativa != null) ...[
              const SizedBox(height: 16),
              _oBien(context),
              _referencia(
                context,
                eucaristia.antifonaComunionAlternativaReferencia!,
              ),
              const SizedBox(height: 18),
              _texto(eucaristia.antifonaComunionAlternativa!),
            ],

            const SizedBox(height: 28),

            _tituloSeccion(context, 'Oración final'),
            _texto(eucaristia.oracionFinal),

            if (eucaristia.bendicionSolemne.isNotEmpty) ...[
              const SizedBox(height: 28),
              _tituloSeccion(context, 'Bendición solemne'),

              const SizedBox(height: 8),

              ...eucaristia.bendicionSolemne.map((bloque) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: bloque
                        .split('\n')
                        .where((linea) => linea.trim().isNotEmpty)
                        .map((linea) {
                          final esVersiculo = linea.startsWith('V/');
                          final esRespuesta = linea.startsWith('R/');

                          if (esVersiculo || esRespuesta) {
                            final indicador = esVersiculo ? 'V/' : 'R/';
                            final texto = linea.substring(2).trim();

                            return RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: tamanoTexto,
                                  height: 1.5,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurface,
                                ),
                                children: [
                                  TextSpan(
                                    text: '$indicador ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary,
                                    ),
                                  ),
                                  TextSpan(
                                    text: texto,
                                    style: TextStyle(
                                      fontWeight: esRespuesta
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }

                          return Text(
                            linea,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontSize: tamanoTexto,
                              height: 1.5,
                            ),
                          );
                        })
                        .toList(),
                  ),
                );
              }),
            ],
          ],
        ),
      ),
    );
  }

  Widget _tituloSeccion(BuildContext context, String titulo) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Text(
        titulo,
        style: TextStyle(
          fontSize: tamanoTexto + 4,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  Widget _subtitulo(BuildContext context, String titulo) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        titulo,
        style: TextStyle(
          fontSize: tamanoTexto + 1,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  Widget _referencia(BuildContext context, String texto) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        texto,
        textAlign: TextAlign.right,
        style: TextStyle(
          fontSize: tamanoTexto,
          fontStyle: FontStyle.italic,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  Widget _texto(String texto) {
    return Text(
      texto,
      textAlign: TextAlign.justify,
      style: TextStyle(fontSize: tamanoTexto, height: 1.5),
    );
  }

  Widget _oBien(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        'O bien:',
        style: TextStyle(
          fontSize: tamanoTexto - 1,
          fontStyle: FontStyle.italic,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  Widget _rubrica(BuildContext context, String texto) {
    return Text(
      texto,
      style: TextStyle(
        fontSize: tamanoTexto - 1,
        fontStyle: FontStyle.italic,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  Widget _tituloLectura(BuildContext context, String texto) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Center(
        child: Text(
          texto,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: tamanoTexto,
            fontStyle: FontStyle.italic,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }

  Widget _encabezadoLectura(String texto) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        texto,
        style: TextStyle(fontSize: tamanoTexto, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _respuestaSalmo(BuildContext context, String texto) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: tamanoTexto,
          height: 1.5,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        children: [
          TextSpan(
            text: 'R/ ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          TextSpan(
            text: texto,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _estrofaSalmo(BuildContext context, String texto) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: tamanoTexto,
          height: 1.5,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        children: [
          TextSpan(
            text: 'V/ ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          TextSpan(text: texto),
        ],
      ),
    );
  }

  Widget _peticion(BuildContext context, String texto) {
    const respuesta = 'Roguemos al Señor';

    final posicion = texto.indexOf(respuesta);

    if (posicion == -1) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Text(
          texto,
          textAlign: TextAlign.justify,
          style: TextStyle(fontSize: tamanoTexto, height: 1.5),
        ),
      );
    }

    final antes = texto.substring(0, posicion);
    final despues = texto.substring(posicion + respuesta.length);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: RichText(
        textAlign: TextAlign.justify,
        text: TextSpan(
          style: TextStyle(
            fontSize: tamanoTexto,
            height: 1.5,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          children: [
            TextSpan(text: antes),
            const TextSpan(
              text: respuesta,
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
            TextSpan(text: despues),
          ],
        ),
      ),
    );
  }
}
