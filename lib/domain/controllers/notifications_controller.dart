import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:infinite_horizons/domain/controllers/permissions_controller.dart';
import 'package:infinite_horizons/presentation/core/theme_data.dart';

part 'package:infinite_horizons/infrastructure/notifications_repository.dart';

abstract class NotificationsController {
  static NotificationsController? _instance;

  static NotificationsController get instance =>
      _instance ??= _NotificationsRepository();

  void init();

  Future send({
    required DateTime date,
    required String title,
    required NotificationVariant variant,
    String? body,
  });

  Future generalPermission() =>
      PermissionsController.instance.generalNotificationPermission();

  Future preciseAlarmPermission() =>
      PermissionsController.instance.preciseAlarmPermission();

  Future cancelAllNotifications();
}
