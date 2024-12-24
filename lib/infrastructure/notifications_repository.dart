part of 'package:infinite_horizons/domain/controllers/notifications_controller.dart';

class _NotificationsRepository extends NotificationsController {
  late AwesomeNotifications controller;
  int notificationIdCounter = 1;

  @override
  void init() {
    controller = AwesomeNotifications();
    controller.initialize(
      'resource://drawable/res_app_icon',
      [
        NotificationChannel(
          channelKey: NotificationVariant.workEnded.channelKey,
          channelName: 'Work Ended',
          channelDescription: 'Work time ended',
          soundSource: 'resource://raw/session_completed',
          defaultColor: AppThemeData.logoBackgroundColor,
          ledColor: AppThemeData.logoBackgroundColor,
          criticalAlerts: true,
        ),
        NotificationChannel(
          channelKey: NotificationVariant.breakEnded.channelKey,
          channelName: 'Break Ended',
          channelDescription: 'Break time ended',
          soundSource: 'resource://raw/break_ended',
          defaultColor: AppThemeData.logoBackgroundColor,
          ledColor: AppThemeData.logoBackgroundColor,
          criticalAlerts: true,
        ),
      ],
    );
    controller.setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
      onNotificationCreatedMethod: onNotificationCreatedMethod,
      onNotificationDisplayedMethod: onNotificationDisplayedMethod,
      onDismissActionReceivedMethod: onDismissActionReceivedMethod,
    );
  }

  @override
  Future<bool> isPermissionGranted() async {
    final List<NotificationPermission> permissionsExpected = [
      NotificationPermission.Badge,
      NotificationPermission.Alert,
      NotificationPermission.Sound,
      NotificationPermission.Vibration,
      NotificationPermission.Light,
    ];

    final List<NotificationPermission> grantedPermissions =
        await controller.checkPermissionList(permissions: permissionsExpected);
    for (final NotificationPermission permission in permissionsExpected) {
      if (!grantedPermissions.contains(permission)) {
        return false;
      }
    }
    return true;
  }

  @override
  Future send({
    required DateTime date,
    required String title,
    required NotificationVariant variant,
    String? body,
  }) async =>
      controller.createNotification(
        schedule: NotificationCalendar.fromDate(
          date: date,
          allowWhileIdle: true,
          preciseAlarm: true,
        ),
        content: NotificationContent(
          id: notificationIdCounter++,
          channelKey: variant.channelKey,
          title: title,
          body: body,
          criticalAlert: true,
          wakeUpScreen: true,
        ),
      );

  @override
  Future cancelAllNotifications() => controller.cancelAll();

  /// Use this method to detect when the user taps on a notification or action button
  /// Also capture when there is a message from firebase messaging
  @pragma('vm:entry-point')
  static Future<void> onActionReceivedMethod(
    ReceivedAction receivedAction,
  ) async {}

  /// Use this method to detect when a new notification or a schedule is created
  @pragma('vm:entry-point')
  static Future<void> onNotificationCreatedMethod(
    ReceivedNotification receivedNotification,
  ) async {}

  /// Use this method to detect every time that a new notification is displayed
  @pragma('vm:entry-point')
  static Future<void> onNotificationDisplayedMethod(
    ReceivedNotification receivedNotification,
  ) async {}

  /// Use this method to detect if the user dismissed a notification
  @pragma('vm:entry-point')
  static Future<void> onDismissActionReceivedMethod(
    ReceivedAction receivedAction,
  ) async {}
}

enum NotificationVariant {
  workEnded('work_ended'),
  breakEnded('break_ended'),
  ;

  const NotificationVariant(this.channelKey);

  final String channelKey;
}
