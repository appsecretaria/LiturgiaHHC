import 'package:flutter/material.dart';

import 'screens/splash_screen.dart';
import 'settings/app_settings.dart';

void main() {
  runApp(
    AppSettingsScope(
      settings: AppSettings(),
      child: const LiturgiaVicencianaApp(),
    ),
  );
}

class AppSettingsScope extends InheritedNotifier<AppSettings> {
  const AppSettingsScope({
    super.key,
    required AppSettings settings,
    required super.child,
  }) : super(notifier: settings);

  static AppSettings of(BuildContext context) {
    final scope = context
        .dependOnInheritedWidgetOfExactType<AppSettingsScope>();

    assert(scope != null, 'AppSettingsScope no encontrado');

    return scope!.notifier!;
  }
}

class LiturgiaVicencianaApp extends StatelessWidget {
  const LiturgiaVicencianaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Liturgia Vicenciana',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF9E1B1B),
      ),
      home: const SplashScreen(),
    );
  }
}
