import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

part 'package:infinite_horizons/infrastructure/notifications_repository.dart';

abstract class NotificationsController {
  static NotificationsController? _instance;

  static NotificationsController get instance =>
      _instance ??= _NotificationsRepository();

  void init();

  Future send({
    required DateTime date,
    required String title,
    String? body,
  });

  Future generalPermission();
  Future preciseAlarmPermission();
  Future cancelAllNotifications();
}
