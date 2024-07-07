import 'dart:io';

import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';

part 'package:infinite_horizons/infrastructure/health_repository.dart';

abstract class HealthController {
  static HealthController? _instance;

  static HealthController get instance => _instance ??= _HealthRepository();

  late bool supported;

  void init();

  Future<bool> isPermissionsSleepInBedGranted();

  Future<bool> requestSleepDataPermission();

  Future<DateTime?> getWakeUpTime();
}
