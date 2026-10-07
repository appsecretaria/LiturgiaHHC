import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'dart:async';

import '../data/celebraciones.dart';

class NotificationService {
  NotificationService._();

  static final NotificationService instance = NotificationService._();

  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  final StreamController<String> _payloadController =
      StreamController<String>.broadcast();

  Stream<String> get onNotificacionSeleccionada => _payloadController.stream;

  String? _payloadInicial;

  String? get payloadInicial => _payloadInicial;

  void limpiarPayloadInicial() {
    _payloadInicial = null;
  }

  static const String _channelId = 'celebraciones_vicencianas';
  static const String _channelName = 'Celebraciones vicencianas';
  static const String _channelDescription =
      'Avisos de las celebraciones de la Familia Vicenciana';

  Future<void> inicializar() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Europe/Madrid'));

    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const initializationSettings = InitializationSettings(
      android: androidSettings,
    );

    await _notifications.initialize(
      settings: initializationSettings,
      onDidReceiveNotificationResponse: (response) {
        final payload = response.payload;

        if (payload != null && payload.isNotEmpty) {
          _payloadController.add(payload);
        }
      },
    );

    final launchDetails = await _notifications
        .getNotificationAppLaunchDetails();

    if (launchDetails?.didNotificationLaunchApp ?? false) {
      final payload = launchDetails?.notificationResponse?.payload;

      if (payload != null && payload.isNotEmpty) {
        _payloadInicial = payload;
      }
    }
  }

  Future<bool> solicitarPermiso() async {
    final androidPlugin = _notifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    if (androidPlugin == null) return false;

    return await androidPlugin.requestNotificationsPermission() ?? false;
  }

  Future<bool> solicitarPermisoAlarmasExactas() async {
    final androidPlugin = _notifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    if (androidPlugin == null) return false;

    return await androidPlugin.requestExactAlarmsPermission() ?? false;
  }

  Future<void> programarCelebraciones({
    required int hora,
    required int minuto,
  }) async {
    await cancelarCelebraciones();

    final androidPlugin = _notifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    final permiteAlarmasExactas =
        await androidPlugin?.canScheduleExactNotifications() ?? false;

    final modoProgramacion = permiteAlarmasExactas
        ? AndroidScheduleMode.exactAllowWhileIdle
        : AndroidScheduleMode.inexactAllowWhileIdle;

    const androidDetails = AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDescription,
      importance: Importance.high,
      priority: Priority.high,
    );

    const notificationDetails = NotificationDetails(android: androidDetails);

    final ahora = tz.TZDateTime.now(tz.local);

    for (var i = 0; i < celebracionesVicencianas.length; i++) {
      final celebracion = celebracionesVicencianas[i];

      var fechaProgramada = tz.TZDateTime(
        tz.local,
        ahora.year,
        celebracion.mes,
        celebracion.dia,
        hora,
        minuto,
      );

      if (!fechaProgramada.isAfter(ahora)) {
        fechaProgramada = tz.TZDateTime(
          tz.local,
          ahora.year + 1,
          celebracion.mes,
          celebracion.dia,
          hora,
          minuto,
        );
      }

      final id = _idCelebracion(celebracion.mes, celebracion.dia, i);

      await _notifications.zonedSchedule(
        id: id,
        title: 'Liturgia Vicenciana',
        body: 'Hoy celebramos a ${celebracion.nombre}.',
        scheduledDate: fechaProgramada,
        notificationDetails: notificationDetails,
        androidScheduleMode: modoProgramacion,
        payload: '${celebracion.mes}-${celebracion.dia}',
      );
    }
  }

  Future<void> cancelarCelebraciones() async {
    for (var i = 0; i < celebracionesVicencianas.length; i++) {
      final celebracion = celebracionesVicencianas[i];

      final id = _idCelebracion(celebracion.mes, celebracion.dia, i);

      await _notifications.cancel(id: id);
    }
  }

  int _idCelebracion(int mes, int dia, int indice) {
    return 100000 + (mes * 1000) + (dia * 10) + indice;
  }

  Future<List<PendingNotificationRequest>>
  obtenerNotificacionesPendientes() async {
    return _notifications.pendingNotificationRequests();
  }
}
