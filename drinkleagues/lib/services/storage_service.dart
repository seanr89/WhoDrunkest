import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static final StorageService _instance = StorageService._internal();
  SharedPreferences? _prefs;

  factory StorageService() => _instance;

  StorageService._internal();

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  bool hasProfile() {
    return _prefs?.containsKey('user_name') ?? false;
  }

  // User details
  Future<void> setUserName(String name) async {
    await _prefs?.setString('user_name', name);
  }

  String getUserName() {
    return _prefs?.getString('user_name') ?? 'Arthur Shelby';
  }

  Future<void> setUserRank(String rank) async {
    await _prefs?.setString('user_rank', rank);
  }

  String getUserRank() {
    return _prefs?.getString('user_rank') ?? '#3';
  }

  Future<void> setLifetimePints(int count) async {
    await _prefs?.setInt('lifetime_pints', count);
  }

  int getLifetimePints() {
    return _prefs?.getInt('lifetime_pints') ?? 482;
  }
}
