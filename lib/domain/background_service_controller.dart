import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:infinite_horizons/domain/player_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'package:infinite_horizons/infrastructure/background_service_repository.dart';

abstract class BackgroundServiceController {
  static BackgroundServiceController? _instance;

  static BackgroundServiceController get instance =>
      _instance ??= _BackgroundServiceRepository();

  Future init();

  void startIterateTimerStates();
  void stopIterateTimerStates();
}
