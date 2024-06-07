import 'dart:io';

import 'package:flutter_background_service/flutter_background_service.dart';

part 'package:infinite_horizons/infrastructure/background_service_repository.dart';

abstract class BackgroundServiceController {
  static BackgroundServiceController? _instance;

  static BackgroundServiceController get instance =>
      _instance ??= _BackgroundServiceRepository();

  Future init();
}
