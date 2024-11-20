import 'package:shared_preferences/shared_preferences.dart';

part 'package:infinite_horizons/infrastructure/preferences_repository.dart';

abstract class PreferencesController {
  static PreferencesController? _instance;

  static PreferencesController get instance =>
      _instance ??= _PreferencesRepository();

  Future init();

  String? getString(PreferenceKeys key);

  int? getInt(PreferenceKeys key);

  bool? getBool(PreferenceKeys key);

  Duration? getDuration(PreferenceKeys key);

  DateTime? getDateTime(PreferenceKeys key);

  void remove(PreferenceKeys key);

  void setString(PreferenceKeys key, String value);

  void setInt(PreferenceKeys key, int value);

  void setBool(PreferenceKeys key, bool value);

  void setDuration(PreferenceKeys key, Duration value);

  void setDateTime(PreferenceKeys key, DateTime value);
}

enum PreferenceKeys {
  loginCounter,
  isLockScreen,
  isSound,
  pausedTime,
  timerState,
  remainingTimerTime,
  freeText,
  tipType,
  sleepPermissionGranted,
  finishedIntroduction,
  notificationPermissionRequested,
}
