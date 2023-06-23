import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static late SharedPreferences prefs;

  static Future<void> configurePreps() async {
    prefs = await SharedPreferences.getInstance();
  }
}