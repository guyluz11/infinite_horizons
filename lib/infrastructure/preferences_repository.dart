part of 'package:infinite_horizons/domain/controllers/preferences_controller.dart';

class _PreferencesRepository extends PreferencesController {
  late SharedPreferences preferences;

  @override
  Future init() async => preferences = await SharedPreferences.getInstance();

  @override
  String? getString(PreferenceKeys key) => preferences.getString(key.name);

  @override
  int? getInt(PreferenceKeys key) => preferences.getInt(key.name);

  @override
  bool? getBool(PreferenceKeys key) => preferences.getBool(key.name);

  @override
  Duration? getDuration(PreferenceKeys key) {
    final int? milliseconds = preferences.getInt(key.name);
    return milliseconds == null ? null : Duration(milliseconds: milliseconds);
  }

  @override
  DateTime? getDateTime(PreferenceKeys key) {
    final int? milliseconds = preferences.getInt(key.name);
    return milliseconds == null
        ? null
        : DateTime.fromMillisecondsSinceEpoch(milliseconds);
  }

  @override
  void remove(PreferenceKeys key) => preferences.remove(key.name);

  @override
  void setString(PreferenceKeys key, String value) =>
      preferences.setString(key.name, value);

  @override
  void setInt(PreferenceKeys key, int value) =>
      preferences.setInt(key.name, value);

  @override
  void setBool(PreferenceKeys key, bool value) =>
      preferences.setBool(key.name, value);

  @override
  void setDuration(PreferenceKeys key, Duration value) =>
      preferences.setInt(key.name, value.inMilliseconds);

  @override
  void setDateTime(PreferenceKeys key, DateTime value) =>
      preferences.setInt(key.name, value.millisecondsSinceEpoch);
}
