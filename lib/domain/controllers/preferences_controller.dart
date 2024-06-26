import 'package:shared_preferences/shared_preferences.dart';

part 'package:infinite_horizons/infrastructure/preferences_repository.dart';

abstract class PreferencesController {
  static PreferencesController? _instance;

  static PreferencesController get instance =>
      _instance ??= _PreferencesRepository();

  Future init();

  String? getString(String key);

  int? getInt(String key);

  bool? getBool(String key);

  Duration? getDuration(String key);

  DateTime? getDateTime(String key);

  void remove(String key);

  void setString(String key, String value);

  void setInt(String key, int value);

  void setBool(String key, bool value);

  void setDuration(String key, Duration value);

  void setDateTime(String key, DateTime value);
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
}
