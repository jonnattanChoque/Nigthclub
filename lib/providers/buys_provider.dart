import 'package:admin_dashboard/models/buys_model.dart';
import 'package:admin_dashboard/services/back_servie.dart';
import 'package:admin_dashboard/utils/local_storage.dart';
import 'package:flutter/material.dart';

class BuysProvider extends ChangeNotifier with BackService {
  List<Buy> buys = [];

  getBuys() async {
    final json = await getData('bar/buys');
    buys = await BuysResponse().jsonDecodes(json);
    LocalStorage().setInternalCategory(json);
    notifyListeners();
  }

  newBuys(String name, String price, String date) async {
    final data = {"name": name, "price": price, "datesBuy": date};
    final response = await newData(data, 'bar/buys', null);
    final newTable = await BuysResponse().jsonDecodeSingle(response);
    if (newTable != null) {
      buys.add(newTable);
      getBuys();
      return true;
    } else {
      return false;
    }
  }

  updateBuys(String name, String price, String date, String id) async {
    if (name.isNotEmpty) {
      final data = {"id": id, "name": name, "price": price, "datesBuy": date};
      final response = await updateData(data, 'bar/buys/$id');
      final updateTable = await BuysResponse().jsonDecodeSingle(response);
      if (updateTable != null) {
        final index = buys.indexWhere((table) => table.id == id);
        buys[index] = updateTable;
        getBuys();
        return true;
      } else {
        return false;
      }
    }
  }

  removeBuys(String id) async {
    if (id.isNotEmpty) {
      final response = removeData('bar/buys/$id');
      final index = buys.indexWhere((table) => table.id == id);
      buys.removeAt(index);
      getBuys();
      return response;
    }
  }
}
