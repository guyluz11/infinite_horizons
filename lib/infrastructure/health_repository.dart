part of 'package:infinite_horizons/domain/controllers/health_controller.dart';

class _HealthRepository extends HealthController {
  late Health health;

  @override
  void init() {
    health = Health();
    health.configure(useHealthConnectIfAvailable: true);
  }

  @override
  Future<DateTime> getWakeUpTime() async {
    await PermissionsController.instance.requestSleepDataPermission();
    final DateTime now = DateTime.now();
    final HealthDataPoint data = (await health.getHealthAggregateDataFromTypes(
      startDate: now.copyWith(hour: 0, minute: 0, second: 0),
      endDate: now.copyWith(hour: 23, minute: 59, second: 59),
      types: [HealthDataType.SLEEP_AWAKE],
    ))
        .first;
    return data.dateFrom;
  }
}
