import 'package:flutter/material.dart';

import 'screens/splash_screen.dart';

void main() {
  runApp(const LiturgiaVicencianaApp());
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
