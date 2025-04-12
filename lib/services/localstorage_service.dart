import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static Future<void> storeData(Map<String, dynamic> data) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      for (var entry in data.entries) {
        if (entry.value is String) {
          await prefs.setString(entry.key, entry.value);
        } else if (entry.value is int) {
          await prefs.setInt(entry.key, entry.value);
        } else if (entry.value is bool) {
          await prefs.setBool(entry.key, entry.value);
        } else if (entry.value is double) {
          await prefs.setDouble(entry.key, entry.value);
        }
      }
    } catch (e) {
      print('Error storing data: $e');
    }
  }

  static Future<dynamic> getData(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (prefs.containsKey(key)) {
        if (prefs.get(key) is String) {
          return prefs.getString(key);
        } else if (prefs.get(key) is int) {
          return prefs.getInt(key);
        } else if (prefs.get(key) is double) {
          return prefs.getDouble(key);
        } else if (prefs.get(key) is bool) {
          return prefs.getBool(key);
        }
      }
      return null;
    } catch (e) {
      print('Error fetching data: $e');
      return null;
    }
  }

  static Future<void> removeData(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (prefs.containsKey(key)) {
        await prefs.remove(key);
      }
    } catch (e) {
      print('Error removing data for key "$key": $e');
    }
  }

  static Future<void> clearData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
    } catch (e) {
      print('Error clearing data: $e');
    }
  }
}