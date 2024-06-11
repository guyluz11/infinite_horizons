part of 'package:infinite_horizons/domain/notifications_controller.dart';

class _NotificationsRepository extends NotificationsController {
  late AwesomeNotifications controller;

  @override
  void init() {
    controller = AwesomeNotifications();
    controller.initialize(
      // set the icon to null if you want to use the default app icon
      // 'resource://drawable/res_app_icon',
      null,
      [
        NotificationChannel(
          channelGroupKey: 'basic_channel_group',
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: const Color(0xFF9D50DD),
          ledColor: Colors.white,
        ),
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
          channelGroupKey: 'basic_channel_group',
          channelGroupName: 'Basic group',
        ),
      ],
      debug: true,
    );

    controller.requestPermissionToSendNotifications();
    // controller.setListeners(
    //   onActionReceivedMethod: (ReceivedAction receivedAction){
    //     onActionReceivedMethod(context, receivedAction);
    //   },
    //   onNotificationCreatedMethod: (ReceivedNotification receivedNotification){
    //     onNotificationCreatedMethod(context, receivedNotification);
    //   },
    //   onNotificationDisplayedMethod: (ReceivedNotification receivedNotification){
    //     onNotificationDisplayedMethod(context, receivedNotification);
    //   },
    //   onDismissActionReceivedMethod: (ReceivedAction receivedAction){
    //     onDismissActionReceivedMethod(context, receivedAction);
    //   },
    // );
  }

  @override
  void send() {
    controller.createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'basic_channel',
        title: 'Hello World!',
        body: 'This is my first notification!',
      ),
    );
  }

  /// Use this method to detect when a new notification or a schedule is created
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
    ReceivedNotification receivedNotification,
  ) async {
    // Your code goes here
  }

  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
    ReceivedNotification receivedNotification,
  ) async {
    // Your code goes here
  }

  /// Use this method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
    ReceivedAction receivedAction,
  ) async {
    // Your code goes here
  }

  /// Use this method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
    ReceivedAction receivedAction,
  ) async {
    // Your code goes here

    // Navigate into pages, avoiding to open the notification details page over another details page already opened
    // MyApp.navigatorKey.currentState?.pushNamedAndRemoveUntil(
    //     '/notification-page',
    //     (route) =>
    //         (route.settings.name != '/notification-page') || route.isFirst,
    //     arguments: receivedAction);
  }
}
