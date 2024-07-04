import 'dart:io';

import 'package:health/health.dart';
import 'package:infinite_horizons/domain/controllers/permissions_controller.dart';

part 'package:infinite_horizons/infrastructure/health_repository.dart';

abstract class HealthController {
  static HealthController? _instance;

  static HealthController get instance => _instance ??= _HealthRepository();

  void init();

  Future<bool> requestGeneralPermissions() =>
      PermissionsController.instance.activityRecognition();

  Future<bool> requestSleepDataPermission() =>
      PermissionsController.instance.requestSleepDataPermission();

  Future<DateTime?> getWakeUpTime();
}
