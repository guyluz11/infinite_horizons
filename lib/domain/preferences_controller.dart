import 'package:shared_preferences/shared_preferences.dart';

part 'package:infinite_horizons/infrastructure/preferences_repository.dart';

abstract class PreferencesController {
  static PreferencesController? _instance;

  static PreferencesController get instance =>
      _instance ??= _PreferencesRepository();

  Future init();

  String? getString(String key);

  void remove(String key);

  void setString(String key, String value);
}
