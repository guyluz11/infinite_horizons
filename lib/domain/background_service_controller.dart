import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:infinite_horizons/domain/energy_level.dart';
import 'package:infinite_horizons/domain/player_controller.dart';
import 'package:infinite_horizons/domain/preferences_controller.dart';
import 'package:infinite_horizons/domain/study_type_abstract.dart';
import 'package:infinite_horizons/domain/study_type_analytical.dart';
import 'package:infinite_horizons/domain/study_type_creatively.dart';
import 'package:infinite_horizons/domain/tip.dart';
import 'package:infinite_horizons/domain/vibration_controller.dart';
import 'package:infinite_horizons/infrastructure/core/logger.dart';
import 'package:infinite_horizons/presentation/organisms/timer_organism.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'package:infinite_horizons/infrastructure/background_service_repository.dart';

abstract class BackgroundServiceController {
  static BackgroundServiceController? _instance;

  static BackgroundServiceController get instance =>
      _instance ??= _BackgroundServiceRepository();

  Future init();

  Future<bool> startService();
  void stopService();

  void startIterateTimerStates(
    TipType tipType,
    EnergyType energyType,
    TimerState timerState,
    Duration remainingTime,
  );

  void stopIterateTimerStates();
}
