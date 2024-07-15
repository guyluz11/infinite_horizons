import 'package:health/health.dart';
import 'package:infinite_horizons/domain/controllers/controllers.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:universal_io/io.dart';

part 'package:infinite_horizons/infrastructure/health_repository.dart';

abstract class HealthController {
  static HealthController? _instance;

  static HealthController get instance => _instance ??= _HealthRepository();

  late bool supported;

  void init();

  Future<bool> isPermissionsSleepInBedGranted();

  Future<bool> requestSleepDataPermission();

  Future<Duration?> getEstimatedDurationFromWake();

  void removeSleepPermission();
}
