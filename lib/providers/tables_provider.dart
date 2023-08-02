import 'package:admin_dashboard/models/table_model.dart';
import 'package:admin_dashboard/services/back_servie.dart';
import 'package:flutter/material.dart';

class TablesProvider extends ChangeNotifier with BackService {
  List<Tables> tables = [];
  List<String> listTables = [];
  bool ascending = true;
  int? sortColumnIndex;

  getTables() async {
    final json = await getData('bar/tables');
    tables = await TableResponse().jsonDecodes(json);
    notifyListeners();
  }

  newTable(String name) async {
    final data = { "name": name };
    final response = await newData(data, 'bar/tables', null);
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
      final data = {"id": id, "name": name };
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

  getTablesNames() async {
    listTables = [];
    await getTables();

    for (var element in tables) {
      listTables.add(element.name);
    }
  }

  void sort<T>(Comparable<T> Function(Tables product) getField ) {
    tables.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending ? Comparable.compare(aValue, bValue) : Comparable.compare(bValue, aValue);
    });

    ascending = !ascending;
    notifyListeners();
  }
}