import 'package:flutter/material.dart';
import 'package:pdfrx/pdfrx.dart';

class PdfScreen extends StatefulWidget {
  final String titulo;
  final String url;

  const PdfScreen({super.key, required this.titulo, required this.url});

  @override
  State<PdfScreen> createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {
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
        title: Text(
          widget.titulo,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: PdfViewer.uri(
        Uri.parse(widget.url),

        params: PdfViewerParams(
          errorBannerBuilder: (context, error, stackTrace, documentRef) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.cloud_off_outlined,
                      size: 70,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'No se ha podido cargar la partitura',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Comprueba tu conexión a Internet e inténtalo de nuevo.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 17, height: 1.4),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
