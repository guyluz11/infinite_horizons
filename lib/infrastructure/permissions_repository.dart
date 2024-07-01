part of 'package:infinite_horizons/domain/controllers/permissions_controller.dart';

class _PermissionsRepository extends PermissionsController {
  @override
  Future<bool> activityRecognition() async =>
      await Permission.activityRecognition.request() ==
      PermissionStatus.granted;

  @override
  Future<bool> isNotificationPolicyAccessGranted() async =>
      await FlutterDnd.isNotificationPolicyAccessGranted ?? false;

  @override
  void gotoPolicySettings() => FlutterDnd.gotoPolicySettings();

  @override
  Future generalNotificationPermission() =>
      AwesomeNotifications().requestPermissionToSendNotifications();

  @override
  Future preciseAlarmPermission() async {
    // TODO: Fix when we ca check the permission. issue:
    // https://discord.com/channels/888523488376279050/1254751072682119208
    // final List<NotificationPermission> permissions =
    //     await AwesomeNotifications().checkPermissionList();
    if (await isAndroid12OrAbove()) {
      AwesomeNotifications().showAlarmPage();
    }
  }

  Future<bool> isAndroid12OrAbove() async {
    if (Platform.isAndroid) {
      final deviceInfo = DeviceInfoPlugin();
      final androidInfo = await deviceInfo.androidInfo;
      final sdkInt = androidInfo.version.sdkInt;
      // Android 12 is API level 31
      return sdkInt >= 31;
    }
    return false;
  }

  @override
  Future<bool> requestSleepDataPermission() =>
      Health().requestAuthorization([HealthDataType.SLEEP_AWAKE]);
}
