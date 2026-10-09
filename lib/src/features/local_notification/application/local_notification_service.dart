import 'dart:io';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vndb_lite/src/constants/app_info.dart';

part 'local_notification_service.g.dart';

class LocalNotificationService {
  LocalNotificationService(this._instance);

  final FlutterLocalNotificationsPlugin _instance;
  bool _isInitialized = false;

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/sync');

    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
          requestSoundPermission: false,
          requestBadgePermission: true,
          requestAlertPermission: true,
        );

    const InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsDarwin,
          macOS: initializationSettingsDarwin,
          linux: LinuxInitializationSettings(
            defaultActionName: 'Open VNPockets',
          ),
        );

    _isInitialized =
        await _instance.initialize(
          initializationSettings,
          onDidReceiveNotificationResponse: (_) {},
        ) ??
        true;
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  Future<void> askPermissions() async {
    if (Platform.isAndroid) {
      await _instance
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()!
          .requestNotificationsPermission();

      return;
    }

    if (Platform.isIOS || Platform.isMacOS) {
      await _instance
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >()
          ?.requestPermissions(alert: true, badge: true, sound: false);

      await _instance
          .resolvePlatformSpecificImplementation<
            MacOSFlutterLocalNotificationsPlugin
          >()
          ?.requestPermissions(alert: true, badge: true, sound: false);
      return;
    }
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  Future<void> show({
    required String title,
    required NotificationDetails detail,
  }) async {
    if (!_isInitialized) return;

    try {
      await _instance.cancelAll();
      await _instance.show(1, title, AppInfo.TITLE, detail);
    } catch (error) {
      // Notifications are optional; an unavailable desktop notification
      // daemon must not interrupt the underlying sync operation.
      debugPrint('Unable to show notification: $error');
    }
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //
}

@Riverpod(keepAlive: true)
LocalNotificationService localNotifService(Ref ref) {
  return LocalNotificationService(FlutterLocalNotificationsPlugin());
}
