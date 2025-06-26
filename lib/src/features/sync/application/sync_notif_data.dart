import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../../constants/_constants.dart';

enum SyncStatus {
  ongoing("Synchronizing VNDB account"),
  failed("Synchronization failed"),
  success("Synchronization succeed");

  const SyncStatus(this.title);
  final String title;
}

NotificationDetails getSyncNotifDetail(SyncStatus status) {
  const stringContext = "Display cloud synchronization progress.";

  final AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
    'basic_channel',
    'sync_channel',
    channelDescription: stringContext,
    ticker: '${AppInfo.TITLE} Notification',
    showWhen: true,
    colorized: true,
    playSound: false,
    onlyAlertOnce: true,
    color: Colors.transparent,
    priority: Priority.high,
    importance: Importance.max,
    ongoing: (status == SyncStatus.ongoing),
    autoCancel: (status != SyncStatus.ongoing),
    showProgress: (status == SyncStatus.ongoing),
    indeterminate: (status == SyncStatus.ongoing),
    largeIcon: const DrawableResourceAndroidBitmap('@drawable/app_icon'),
  );

  const DarwinNotificationDetails iosNotificationDetails = DarwinNotificationDetails(
    subtitle: stringContext,
  );

  return NotificationDetails(android: androidNotificationDetails, iOS: iosNotificationDetails);
}
