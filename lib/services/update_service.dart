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

      final versionInstalada = packageInfo.version;

      final response = await http
          .get(Uri.parse(versionUrl))
          .timeout(const Duration(seconds: 8));

      if (response.statusCode != 200) {
        return null;
      }

      final datos = jsonDecode(response.body) as Map<String, dynamic>;

      final versionDisponible = datos['version']?.toString() ?? '';

      final buildDisponible =
          int.tryParse(datos['build']?.toString() ?? '') ?? 0;

      final apkUrl = datos['apkUrl']?.toString() ?? '';

      final mensaje =
          datos['mensaje']?.toString() ?? 'Hay una nueva versión disponible.';

      if (versionDisponible.isEmpty) {
        return null;
      }

      if (!_esVersionMasNueva(versionDisponible, versionInstalada)) {
        return null;
      }

      return UpdateInfo(
        version: versionDisponible,
        build: buildDisponible,
        apkUrl: apkUrl,
        mensaje: mensaje,
      );
    } catch (_) {
      // La comprobación de actualizaciones nunca debe impedir
      // que la aplicación funcione normalmente.
      return null;
    }
  }

  static bool _esVersionMasNueva(String disponible, String instalada) {
    final partesDisponible = disponible
        .split('.')
        .map((parte) => int.tryParse(parte) ?? 0)
        .toList();

    final partesInstalada = instalada
        .split('.')
        .map((parte) => int.tryParse(parte) ?? 0)
        .toList();

    final longitud = partesDisponible.length > partesInstalada.length
        ? partesDisponible.length
        : partesInstalada.length;

    for (var i = 0; i < longitud; i++) {
      final valorDisponible = i < partesDisponible.length
          ? partesDisponible[i]
          : 0;

      final valorInstalado = i < partesInstalada.length
          ? partesInstalada[i]
          : 0;

      if (valorDisponible > valorInstalado) {
        return true;
      }

      if (valorDisponible < valorInstalado) {
        return false;
      }
    }

    return false;
  }
}
