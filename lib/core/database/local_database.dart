import 'package:shared_preferences/shared_preferences.dart';

class LocalDatabase {
  static SharedPreferences? _prefs;

  /// Initializes the SharedPreferences instance.
  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
    print("✅ LocalDatabase initialized.");
  }

  /// Ensures the database is initialized.
  void _ensureInitialized() {
    if (_prefs == null) {
      throw Exception(
        "LocalDatabase not initialized. Call 'LocalDatabase.init()' before using it.",
      );
    }
  }

  /// Saves a list of strings to local storage.
  Future<void> saveStringList(String key, List<String> values) async {
    _ensureInitialized();
    await _prefs!.setStringList(key, values);
  }

  /// Retrieves a list of strings from local storage.
  Future<List<String>> getStringList(String key) async {
    _ensureInitialized();
    return _prefs!.getStringList(key) ?? [];
  }

  /// Saves a single string value to local storage.
  Future<void> saveString(String key, String value) async {
    _ensureInitialized();
    await _prefs!.setString(key, value);
  }

  /// Retrieves a single string value from local storage.
  Future<String?> getString(String key) async {
    _ensureInitialized();
    return _prefs!.getString(key);
  }

  /// Removes a value from local storage.
  Future<void> remove(String key) async {
    _ensureInitialized();
    await _prefs!.remove(key);
  }
}
