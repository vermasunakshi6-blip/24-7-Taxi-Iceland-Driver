

import '../../apppackages.dart';

class SharedPrefProvider extends ChangeNotifier {
  SharedPreferences? prefs;

  SharedPrefProvider() {
    _initPreferences();
  }

  Future<void> _initPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future setBool(String key) async {
    prefs!.setBool(key, true);
  }

  Future<bool> getBool(String key, bool value) async {
    return prefs!.getBool(key) ?? false;
  }

  String getString(String key) {
    return prefs!.getString(key) ?? "";
  }

  Future<void> setString(String key, String value) {
    return prefs!.setString(key, value);
  }

  Future setInt(String key, int val) {
    return prefs!.setInt(key, val);
  }

  int getInt(
    String key,
  ) {
    return prefs!.getInt(key) ?? 0;
  }

  Future<void> setDouble(String key, double val) {
    return prefs!.setDouble(key, val);
  }

  double getDouble(
    String key,
  ) {
    return prefs!.getDouble(key) ?? 0.0;
  }

  Future setMap(String key, Map value) {
    return prefs!.setString(key, jsonEncode(value));
  }

  Map getMap(
    String key,
  ) {
    return jsonDecode(prefs!.getString(key) ?? "") ?? {
      
    };
  }

  Future clearSharedPref() async {
    prefs!.clear();
  }
}
