import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceTool {
  SharedPreferenceTool();

  static Future getMapPreferences(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final allPreferences = prefs.getString(key) ?? '{}';
    final preferenceJson = jsonDecode(allPreferences) as Map<String, dynamic>;

    return preferenceJson;
  }

  static Future getListPreferences(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final allPreferences = prefs.getString(key) ?? '[]';
    final preferenceJson = jsonDecode(allPreferences) as List;

    return preferenceJson;
  }
}
