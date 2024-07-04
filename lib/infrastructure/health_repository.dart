part of 'package:infinite_horizons/domain/controllers/health_controller.dart';

class _HealthRepository extends HealthController {
  late Health health;
  late bool supported;

  @override
  void init() {
    supported = Platform.isAndroid || Platform.isIOS;
    if (!supported) {
      return;
    }
    health = Health();
    health.configure(useHealthConnectIfAvailable: true);
  }

  @override
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
}
