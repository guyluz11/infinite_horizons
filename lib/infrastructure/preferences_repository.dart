part of 'package:infinite_horizons/domain/controllers/preferences_controller.dart';

class _PreferencesRepository extends PreferencesController {
  late SharedPreferences preferences;

  @override
  Future init() async => preferences = await SharedPreferences.getInstance();

  @override
  String? getString(String key) => preferences.getString(key);

  @override
  int? getInt(String key) => preferences.getInt(key);

  @override
  bool? getBool(String key) => preferences.getBool(key);

  @override
  Duration? getDuration(String key) {
    final int? milliseconds = preferences.getInt(key);
    return milliseconds == null ? null : Duration(milliseconds: milliseconds);
  }

  @override
  DateTime? getDateTime(String key) {
    final int? milliseconds = preferences.getInt(key);
    return milliseconds == null
        ? null
        : DateTime.fromMillisecondsSinceEpoch(milliseconds);
  }

  @override
  void remove(String key) => preferences.remove(key);

  @override
  void setString(String key, String value) => preferences.setString(key, value);

  @override
  void setInt(String key, int value) => preferences.setInt(key, value);

  @override
  void setBool(String key, bool value) => preferences.setBool(key, value);

  @override
  void setDuration(String key, Duration value) =>
      preferences.setInt(key, value.inMilliseconds);

  @override
  void setDateTime(String key, DateTime value) =>
      preferences.setInt(key, value.millisecondsSinceEpoch);
}
