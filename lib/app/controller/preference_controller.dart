///
import 'package:shared_preferences/shared_preferences.dart';

///
import '../../_view.dart';

class Prefs extends StateXController {
  //
  /// Loads and parses the [SharedPreferences] for this app from disk.
  static Future<SharedPreferences> get instance async =>
      _prefsInstance ??= await SharedPreferences.getInstance();

  @override
  Future<bool> initAsync() async {
    _init = true;
    _prefsInstance ??= await instance;
    return _prefsInstance != null;
  }

  /// In case the developer does not explicitly call the init() function.
  static bool _init = false;
  static SharedPreferences? _prefsInstance;

  /// Returns '' if key is null.
  static String getString(String? key, [String? defValue]) {
    if (key == null) {
      return '';
    }
    assert(_init,
        'Prefs.init() must be called first in an initState() preferably!');
    assert(_prefsInstance != null,
        'Maybe call Prefs.getStringF(key)instead. SharedPreferences not ready yet!');
    return _prefsInstance?.getString(key) ?? defValue ?? '';
  }

  /// Returns a Future.
  /// Returns '' if key is null.
  static Future<String> getStringF(String? key, [String? defValue]) async {
    String value;
    if (key == null) {
      return '';
    }
    if (_prefsInstance == null) {
      final prefs = await instance;
      value = prefs.getString(key) ?? defValue ?? '';
    } else {
      // SharedPreferences is available. Ignore init() function.
      _init = true;
      value = getString(key, defValue);
    }
    return value;
  }

  /// Saves a string [value] to persistent storage in the background.
  /// Returns false if key is null.
  static Future<bool> setString(String? key, String? value) async {
    if (key == null || value == null) {
      return false;
    }
    final prefs = await instance;
    return prefs.setString(key, value);
  }

  /// Return false if key is null
  // ignore: avoid_positional_boolean_parameters
  static bool getBool(String? key, [bool? defValue]) {
    if (key == null) {
      return false;
    }
    assert(_init,
        'Prefs.init() must be called first in an initState() preferably!');
    assert(_prefsInstance != null,
        'Maybe call Prefs.getBoolF(key) instead. SharedPreferences not ready yet!');
    return _prefsInstance?.getBool(key) ?? defValue ?? false;
  }

  /// Returns a Future.
  /// Returns false if key is null.
  // ignore: avoid_positional_boolean_parameters
  static Future<bool> getBoolF(String? key, [bool? defValue]) async {
    if (key == null) {
      return false;
    }
    bool value;
    if (_prefsInstance == null) {
      final prefs = await instance;
      value = prefs.getBool(key) ?? defValue ?? false;
    } else {
      // SharedPreferences is available. Ignore init() function.
      _init = true;
      value = getBool(key, defValue);
    }
    return value;
  }

  /// Saves a boolean [value] to persistent storage in the background.
  /// Returns false if key is null.
  // ignore: avoid_positional_boolean_parameters
  static Future<bool> setBool(String? key, bool? value) async {
    if (key == null || value == null) {
      return false;
    }
    final prefs = await instance;
    return prefs.setBool(key, value);
  }
}
