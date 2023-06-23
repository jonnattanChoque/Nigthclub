import 'package:admin_dashboard/models/table_model.dart';
import 'package:admin_dashboard/services/back_servie.dart';
import 'package:flutter/material.dart';

class TablesProvider extends ChangeNotifier with BackService {
  List<Tables> tables = [];

  getTables() async {
    final json = await getData('bar/tables');
    tables = await TableResponse().jsonDecodes(json);
    notifyListeners();
  }

  newTable(String name) async {
    final data = { "name": name };
    final response = await newData(data, 'bar/tables');
    final newTable = await TableResponse().jsonDecodeSingle(response);
    if(newTable != null) {
      tables.add(newTable);
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  updateTable(String name, String id) async {
    if(name.isNotEmpty) {
      final data = { "name": name };
      final response = await updateData(data, 'bar/tables/$id');
      final updateTable = await TableResponse().jsonDecodeSingle(response);
      if(updateTable != null) {
        final index = tables.indexWhere((table) => table.id == id);
        tables[index] = updateTable;
        notifyListeners();
        return true;
      } else {
        return false;
      }
    }
  }

  removeTable(String id) async {
    if(id.isNotEmpty) {
      final response = removeData('bar/tables/$id');
      final index = tables.indexWhere((table) => table.id == id);
      tables.removeAt(index);
      notifyListeners();
      return response;
    }
  }
}