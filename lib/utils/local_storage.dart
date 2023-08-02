import 'package:admin_dashboard/models/category_model.dart';
import 'package:admin_dashboard/models/table_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static late SharedPreferences prefs;

  static Future<void> configurePreps() async {
    prefs = await SharedPreferences.getInstance();
  }
  
  setInternalCategory(dynamic json) {
    final names = CategoryResponse().jsonDecodeString(json);
    LocalStorage.prefs.setString('categories', names.toString());
  }

  getInternalCategory() {
    final json = LocalStorage.prefs.getString("categories");
    return json;
  }

  setInternalTables(dynamic json) {
    final names = TableResponse().jsonDecodeString(json);
    LocalStorage.prefs.setString('tables', names.toString());
  }

  getInternalTables() {
    final json = LocalStorage.prefs.getString("tables");
    return json;
  }

  setInternalTotal(String total) {
    LocalStorage.prefs.setString('todayTotal', total);
  }

  getInternalTotal() {
    final json = LocalStorage.prefs.getString("todayTotal");
    return json;
  }

  removeInternalTotal() {
    LocalStorage.prefs.remove("todayTotal");
  }
}
