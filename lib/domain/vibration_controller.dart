import 'package:flutter_vibrate/flutter_vibrate.dart';

part 'package:infinite_horizons/infrastructure/vibration_repository.dart';

abstract class VibrationController {
  static VibrationController? _instance;

  static VibrationController get instance {
    return _instance ??= _VibrationRepository();
  }

  Future initialize();

  Future vibrate(VibrationType type);
}

enum VibrationType { light, medium, heavy }
