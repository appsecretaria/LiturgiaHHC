import 'package:flutter/material.dart';

import '../models/celebracion.dart';
import 'informacion_celebracion_screen.dart';
import 'lectura_espiritual_screen.dart';
import 'oficio_screen.dart';
import '../models/tipo_oficio.dart';
import '../utils/navegacion.dart';
import 'pdf_screen.dart';
import 'eucaristia_screen.dart';

class CelebracionScreen extends StatelessWidget {
  final Celebracion celebracion;

  const CelebracionScreen({super.key, required this.celebracion});

  @override
  Widget build(BuildContext context) {
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
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 0),

              Text(
                celebracion.nombre,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

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
                celebracion.tipo,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.primary,
                  fontStyle: FontStyle.italic,
                ),
              ),

              const SizedBox(height: 24),

              if (celebracion.imagen != null)
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      celebracion.imagen!,
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

              const SizedBox(height: 30),

              _BotonCelebracion(
                icono: Icons.person_outline,
                titulo: 'Biografía breve',
                onTap: () {
                  abrirPantalla(
                    context,
                    InformacionCelebracionScreen(celebracion: celebracion),
                  );
                },
              ),

              if (celebracion.primerasVisperas)
                _BotonCelebracion(
                  icono: Icons.nights_stay_outlined,
                  titulo: 'I Vísperas',
                  onTap: () {
                    abrirPantalla(
                      context,
                      OficioScreen(
                        celebracion: celebracion,
                        tipo: TipoOficio.primerasVisperas,
                      ),
                    );
                  },
                ),

              if (celebracion.laudes)
                _BotonCelebracion(
                  icono: Icons.wb_sunny_outlined,
                  titulo: 'Laudes',
                  onTap: () {
                    abrirPantalla(
                      context,
                      OficioScreen(
                        celebracion: celebracion,
                        tipo: TipoOficio.laudes,
                      ),
                    );
                  },
                ),

              if (celebracion.eucaristia)
                _BotonCelebracion(
                  icono: Icons.church_outlined,
                  titulo: 'Eucaristía',
                  onTap: () {
                    abrirPantalla(
                      context,
                      EucaristiaScreen(celebracion: celebracion),
                    );
                  },
                ),

              if (celebracion.segundasVisperas)
                _BotonCelebracion(
                  icono: Icons.nights_stay_outlined,
                  titulo: 'II Vísperas',
                  onTap: () {
                    abrirPantalla(
                      context,
                      OficioScreen(
                        celebracion: celebracion,
                        tipo: TipoOficio.segundasVisperas,
                      ),
                    );
                  },
                ),

              if (!celebracion.primerasVisperas &&
                  !celebracion.laudes &&
                  !celebracion.eucaristia &&
                  !celebracion.segundasVisperas &&
                  celebracion.pdfUrl != null)
                _BotonCelebracion(
                  icono: Icons.picture_as_pdf_outlined,
                  titulo: 'Ver celebración',
                  onTap: () {
                    abrirPantalla(
                      context,
                      PdfScreen(
                        titulo: celebracion.nombre,
                        url: celebracion.pdfUrl!,
                      ),
                    );
                  },
                ),

              if (celebracion.lecturaEspiritual)
                _BotonCelebracion(
                  icono: Icons.menu_book_outlined,
                  titulo: 'Lectura espiritual',
                  onTap: () {
                    abrirPantalla(
                      context,
                      LecturaEspiritualScreen(celebracion: celebracion),
                    );
                  },
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

class _BotonCelebracion extends StatelessWidget {
  final IconData icono;
  final String titulo;
  final VoidCallback onTap;

  const _BotonCelebracion({
    required this.icono,
    required this.titulo,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        leading: Icon(icono, size: 30),
        title: Text(
          titulo,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
