import 'package:admin_dashboard/utils/api_http.dart';
import 'package:uuid/uuid.dart';

class BackService {

  getData(String table) async {
    final json = await ApiHtttp.httpGet(table);
    return json;
  }

  newData(Map<String, Object> data, String table, String? id) async {
    var uuid = '';
    (id != null) ? uuid = id : uuid = const Uuid().v1();
    var created = (DateTime.now().millisecondsSinceEpoch);
    data["created_at"] = created.toString();
    await ApiHtttp.httpNew('$table/$uuid', data);
    data["id"] = uuid;
    return data;
  }

  Future updateData(Map<String, Object> data, String table) async {
    await ApiHtttp.httpUpdate(table, data);
    return data;
  }

  Future removeData(String table) async {
    if(table.isNotEmpty) {
      final response = await ApiHtttp.httpDelete(table);
      return response;
    }
  }
}