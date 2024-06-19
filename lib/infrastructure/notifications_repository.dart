part of 'package:infinite_horizons/domain/notifications_controller.dart';

class _NotificationsRepository extends NotificationsController {
  late AwesomeNotifications controller;
  int notificationIdCounter = 1;

  @override
  void init() {
    controller = AwesomeNotifications();
    controller.initialize(
      // set the icon to null if you want to use the default app icon
      // 'resource://drawable/res_app_icon',
      null,
      [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: const Color(0xFF9D50DD),
          ledColor: Colors.white,
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
  Future send({
    required DateTime date,
    required String title,
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
          channelKey: 'basic_channel',
          title: title,
          body: body,
          criticalAlert: true,
          wakeUpScreen: true,
        ),
      );

  @override
  Future generalPermission() =>
      controller.requestPermissionToSendNotifications();

  @override
  Future preciseAlarmPermission() => controller.showAlarmPage();

  @override
  Future cancelAllNotifications() => controller.cancelAll();

  /// Use this method to detect when the user taps on a notification or action button
  /// Also capture when there is a message from firebase messaging
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
    ReceivedAction receivedAction,
  ) async {}

  /// Use this method to detect when a new notification or a schedule is created
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
    ReceivedNotification receivedNotification,
  ) async {}

  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
    ReceivedNotification receivedNotification,
  ) async {}

  /// Use this method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
    ReceivedAction receivedAction,
  ) async {}
}
