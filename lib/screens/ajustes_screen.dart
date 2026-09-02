import 'package:flutter/material.dart';

import '../main.dart';

class AjustesScreen extends StatelessWidget {
  const AjustesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = AppSettingsScope.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Ajustes')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Tamaño del texto',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),

          RadioListTile<double>(
            title: const Text('Pequeño'),
            value: 16,
            groupValue: settings.tamanoTexto,
            onChanged: (value) {
              if (value != null) {
                settings.cambiarTamanoTexto(value);
              }
            },
          ),

          RadioListTile<double>(
            title: const Text('Normal'),
            value: 18,
            groupValue: settings.tamanoTexto,
            onChanged: (value) {
              if (value != null) {
                settings.cambiarTamanoTexto(value);
              }
            },
          ),

          RadioListTile<double>(
            title: const Text('Grande'),
            value: 20,
            groupValue: settings.tamanoTexto,
            onChanged: (value) {
              if (value != null) {
                settings.cambiarTamanoTexto(value);
              }
            },
          ),

          RadioListTile<double>(
            title: const Text('Muy grande'),
            value: 22,
            groupValue: settings.tamanoTexto,
            onChanged: (value) {
              if (value != null) {
                settings.cambiarTamanoTexto(value);
              }
            },
          ),
        ],
      ),
    );
  }
}
