import 'package:admin_dashboard/models/product_model.dart';
import 'package:admin_dashboard/services/back_servie.dart';
import 'package:flutter/material.dart';

class ProductsProvider extends ChangeNotifier with BackService {
  List<Products> products = [];
  bool ascending = true;
  int? sortColumnIndex;

  ProductsProvider() {
    getProducts();
  }
  
  getProducts() async {
    final json = await getData('bar/products');
    products = await ProductResponse().jsonDecodes(json);
    notifyListeners();
  }

  newProduct(String category, String name, String price, String image) async {
    final data = { "category": category, "name": name, "price": price, "image": image };
    final response = await newData(data, 'bar/products', null);
    final newProduct = await ProductResponse().jsonDecodeSingle(response);
    if(newProduct != null) {
      products.add(newProduct);
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  updateProduct(String category, String name, String price, String image, String id) async {
    if(name.isNotEmpty) {
      final data = { "id": id, "category": category, "name": name, "price": price, "image": image};
      final response = await updateData(data, 'bar/products/$id');
      final updateTable = await ProductResponse().jsonDecodeSingle(response);
      if(updateTable != null) {
        final index = products.indexWhere((table) => table.id == id);
        products[index] = updateTable;
        notifyListeners();
        return true;
      } else {
        return false;
      }
    }
  }

  removeProduct(String id) async {
    if(id.isNotEmpty) {
      final response = removeData('bar/products/$id');
      final index = products.indexWhere((table) => table.id == id);
      products.removeAt(index);
      notifyListeners();
      return response;
    }
  }

  getProductsById(String id) {
    final product = products.where((element) => element.id == id).toList();
    notifyListeners();
    if(product.isEmpty) return 0;
    return product;
  }

  void sort<T>(Comparable<T> Function(Products product) getField ) {
    products.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending ? Comparable.compare(aValue, bValue) : Comparable.compare(bValue, aValue);
    });

    ascending = !ascending;
    notifyListeners();
  }
}