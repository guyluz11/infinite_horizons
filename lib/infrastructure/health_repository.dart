part of 'package:infinite_horizons/domain/controllers/health_controller.dart';

class _HealthRepository extends HealthController {
  late Health health;
  late bool sleepPermissionGranted;

  @override
  void init() {
    // TODO: Uncomment after google approve health permission
    // supported = Platform.isAndroid || Platform.isIOS;
    supported = Platform.isIOS;
    if (!supported) {
      return;
    }
    health = Health();
    health.configure(useHealthConnectIfAvailable: true);
    sleepPermissionGranted = PreferencesController.instance
            .getBool(PreferenceKeys.sleepPermissionGranted) ??
        false;
  }

  @override
  Future<bool> isPermissionsSleepInBedGranted() async =>
      supported &&
      (await health.hasPermissions(
            [HealthDataType.SLEEP_IN_BED],
            permissions: [HealthDataAccess.READ],
          ) ??
          sleepPermissionGranted);

  Future<DateTime?> getWakeUpTime() async {
    if (!supported) {
      return null;
    }

    final bool permissionsGranted = await requestSleepDataPermission();
    if (!permissionsGranted) {
      return null;
    }

    final DateTime now = DateTime.now();

    final List<HealthDataPoint> data = await health.getHealthDataFromTypes(
      startTime: now.subtract(const Duration(days: 1)),
      endTime: now,
      types: [HealthDataType.SLEEP_IN_BED],
    );

    data.sort((a, b) => b.dateTo.compareTo(a.dateTo));

    return data.isNotEmpty ? data.first.dateTo : null;
  }

  @override
  Future<Duration?> getEstimatedDurationFromWake() async {
    DateTime? wakeUpTime = await getWakeUpTime();
    Duration? timeFromWake;

    if (wakeUpTime != null) {
      if (wakeUpTime.hour > 10) {
        wakeUpTime = wakeUpTime.copyWith(hour: 10);
      }
      timeFromWake = DateTime.now().difference(wakeUpTime);
    }

    return timeFromWake;
  }

  @override
  Future<bool> requestSleepDataPermission() async {
    PreferencesController.instance
        .setBool(PreferenceKeys.sleepPermissionGranted, true);
    sleepPermissionGranted = true;
    final PermissionStatus status =
        await Permission.activityRecognition.request();

    if (status == PermissionStatus.permanentlyDenied) {
      openAppSettings();
      return false;
    }

    return supported &&
        await health.requestAuthorization(
          [HealthDataType.SLEEP_AWAKE],
          permissions: [HealthDataAccess.READ],
        );
  }

  @override
  void removeSleepPermission() {
    PreferencesController.instance
        .setBool(PreferenceKeys.sleepPermissionGranted, false);
    sleepPermissionGranted = false;
  }
}
