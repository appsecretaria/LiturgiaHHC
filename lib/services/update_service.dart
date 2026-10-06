import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';

class UpdateInfo {
  final String version;
  final int build;
  final String apkUrl;
  final String mensaje;

  const UpdateInfo({
    required this.version,
    required this.build,
    required this.apkUrl,
    required this.mensaje,
  });
}

class UpdateService {
  static const String versionUrl =
      'https://appsecretaria.github.io/LiturgiaHHC/version.json';

  static Future<UpdateInfo?> comprobarActualizacion() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();

      final buildInstalado = int.tryParse(packageInfo.buildNumber) ?? 0;

      final response = await http.get(Uri.parse(versionUrl));

      if (response.statusCode != 200) {
        return null;
      }

      final datos = jsonDecode(response.body) as Map<String, dynamic>;

      final versionDisponible = datos['version']?.toString() ?? '';

      final buildDisponible = int.tryParse(datos['build'].toString()) ?? 0;

      final apkUrl = datos['apkUrl']?.toString() ?? '';

      final mensaje =
          datos['mensaje']?.toString() ?? 'Hay una nueva versión disponible.';

      if (buildDisponible <= buildInstalado) {
        return null;
      }

      return UpdateInfo(
        version: versionDisponible,
        build: buildDisponible,
        apkUrl: apkUrl,
        mensaje: mensaje,
      );
    } catch (_) {
      // Si no hay Internet, GitHub no responde, etc.,
      // la aplicación continúa normalmente.
      return null;
    }
  }
}
