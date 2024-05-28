import 'package:shared_preferences/shared_preferences.dart';

part 'package:infinite_horizons/infrastructure/preferences_repository.dart';

abstract class PreferencesController {
  static PreferencesController? _instance;

  static PreferencesController get instance =>
      _instance ??= _PreferencesRepository();

  Future init();

  String? getString(String key);

  bool? getBool(String key);

  void remove(String key);

  void setString(String key, String value);

  void setBool(String key, bool value);

}

// class PreferencesController extends PreferencesController {
//   late SharedPreferences preferences;
//
//   init() async {
//     preferences = await SharedPreferences.getInstance();
//     PreferencesController.instance = this;
//   }
//
//   @override
//   String? getString(String key) {
//     return preferences.getString(key);
//   }
//
//   @override
//   bool? getBool(String key) {
//     return preferences.getBool(key);
//   }
//
//   @override
//   int? getInt(String key) {
//     try {
//       return preferences.getInt(key);
//     } catch (e) {
//       return null;
//     }
//   }
//
//   @override
//   Iterable<int>? getIntIterator(String key) {
//     try {
//       return preferences.getStringList(key)?.map((e) => int.parse(e));
//     } catch (e) {
//       return null;
//     }
//   }
//
//   @override
//   void remove(String key) {
//     preferences.remove(key);
//   }
//
//   @override
//   void setString(String key, String value) {
//     preferences.setString(key, value);
//   }
//
//   @override
//   void setBool(String key, bool value) {
//     preferences.setBool(key, value);
//   }
//
//   @override
//   void setInt(String key, int value) {
//     preferences.setInt(key, value);
//   }
//
//   @override
//   void setIntIterator(String key, Iterable<int> value) {
//     preferences.setStringList(key, List.from(value.map((e) => e.toString())));
//   }
// }
