import 'package:admin_dashboard/models/category_model.dart';
import 'package:admin_dashboard/services/back_servie.dart';
import 'package:admin_dashboard/utils/local_storage.dart';
import 'package:flutter/material.dart';

class CategoriesProvider extends ChangeNotifier with BackService {
  List<Category> categories = [];

  getCategory() async {
    final json = await getData('bar/categories');
    categories = await CategoryResponse().jsonDecodes(json);
    LocalStorage().setInternalCategory(json);
    notifyListeners();
  }

  newCategory(String name) async {
    final data = { "name": name };
    final response = await newData(data, 'bar/categories', null);
    final newTable = await CategoryResponse().jsonDecodeSingle(response);
    if(newTable != null) {
      categories.add(newTable);
      getCategory();
      return true;
    } else {
      return false;
    }
  }

  updateCategory(String name, String id) async {
    if(name.isNotEmpty) {
      final data = {"id": id, "name": name };
      final response = await updateData(data, 'bar/categories/$id');
      final updateTable = await CategoryResponse().jsonDecodeSingle(response);
      if(updateTable != null) {
        final index = categories.indexWhere((table) => table.id == id);
        categories[index] = updateTable;
        getCategory();
        return true;
      } else {
        return false;
      }
    }
  }

  removeCategory(String id) async {
    if(id.isNotEmpty) {
      final response = removeData('bar/categories/$id');
      final index = categories.indexWhere((table) => table.id == id);
      categories.removeAt(index);
      getCategory();
      return response;
    }
  }
}