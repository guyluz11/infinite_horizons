import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:universal_io/io.dart';

part 'package:infinite_horizons/infrastructure/vibration_repository.dart';

abstract class VibrationController {
  static VibrationController? _instance;

  static VibrationController get instance =>
      _instance ??= _VibrationRepository();

  late bool supported;

  Future init();

  Future vibrate(VibrationType type);
}

enum VibrationType { light, medium, heavy }
