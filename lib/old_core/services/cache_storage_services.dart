import 'package:shared_preferences/shared_preferences.dart';

class CacheStorageServices {
  static CacheStorageServices? _instance;
  static SharedPreferences? _preferences;

  CacheStorageServices._();

  factory CacheStorageServices() => _instance ??= CacheStorageServices._();

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future<void> setTopic(bool value) async =>
      await _preferences?.setBool(_Keys.isEnabled, value);
  bool get isEnalbed => _preferences?.getBool(_Keys.isEnabled) ?? true;

  Future<void> setToken(String token) async =>
      await _preferences?.setString(_Keys.token, token);
  String get token => _preferences?.getString(_Keys.token) ?? '';

  Future<void> setId(String id) async =>
      await _preferences?.setString(_Keys.id, id);
  String get id => _preferences?.getString(_Keys.id) ?? '';

  clear() async{
   await _preferences?.clear();
  }
}

class _Keys {
  static const String token = 'token';
  static const String id = 'id';
  static const String isEnabled = 'isEnabled';
}
