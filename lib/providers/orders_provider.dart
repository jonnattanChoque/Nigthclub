import 'package:admin_dashboard/models/card_model.dart';
import 'package:admin_dashboard/models/order_model.dart';
import 'package:admin_dashboard/models/product_model.dart';
import 'package:admin_dashboard/models/sales_model.dart';
import 'package:admin_dashboard/services/back_servie.dart';
import 'package:admin_dashboard/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrdersProvider extends ChangeNotifier with BackService {
  List<Products> products = [];
  List<Orders> orders = [];
  Sales? sale;
  CardValue card = CardValue(id: '', name: '', date: '');
  int cardPercent = 0;
  String totalCurrency = '0';
  String totalPre = '0';
  String totalPercent = '0';
  double addPercent = 0;
  bool ascending = true;
  int? sortColumnIndex;
  final oCcy = NumberFormat.simpleCurrency();

  OrdersProvider() {
    getProducts();
  }

  getProducts() async {
    final json = await getData('bar/products');
    products = await ProductResponse().jsonDecodes(json);
    notifyListeners();
  }

  getPercent() async {
    final json = await getData('bar/card');
    var cards = await CardResponse().jsonDecodes(json);
    card = cards[0];
    cardPercent = int.parse(card.name);
    notifyListeners();
  }

  getOrders(String table) async {
    final json = await getData('bar/order $table');
    if(json != null ) {
      orders = await OrdersResponse().jsonDecodes(json);
    } else {
      orders = [];
    }
    setTotalPercent(0);
    notifyListeners();
  }

  setTotalPercent(int value) {
    var total = 0;
    for (var element in orders) {
      total += int.parse(element.price);
    }
    var percent = value / 100;
    addPercent = total * percent;
    var totalIncr = addPercent + total;
    totalCurrency = oCcy.format(totalIncr);
    totalPre = oCcy.format(total);
    totalPercent = oCcy.format(addPercent);
  }

  newOrder(String table, String name, String price) async {
    final json = await getData('bar/order $table');
    //SINO HAY NADA
    if (json == null) {
      final precio = int.parse(price) * 1;
      final data = { "name": name, "price": precio.toString(), "count": '1' };
      final response = await newData(data, 'bar/order $table', null);
      final newProduct = await OrdersResponse().jsonDecodeSingle(response);
      if(newProduct != null) {
        orders.add(newProduct);
        setTotalPercent(0);
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } else {
      orders = await OrdersResponse().jsonDecodes(json);
      final ordersCreated = orders.where((element) => element.name == name);
      if(ordersCreated.isEmpty) {
        final precio = int.parse(price) * 1;
        final data = { "name": name, "price": precio.toString(), "count": '1' };
          final response = await newData(data, 'bar/order $table', null);
          final newProduct = await OrdersResponse().jsonDecodeSingle(response);
          if(newProduct != null) {
            orders.add(newProduct);
            setTotalPercent(0);
            notifyListeners();
            return true;
          } else {
            return false;
          }
      }
      for (var order in orders) {
        if(order.name == name && order.id.isNotEmpty) {
          var total = int.parse(order.count) + 1;
          final precio = int.parse(price) * total;
          final data = {"id": order.id, "name": name, "price": precio.toString(), "count": total.toString() };
          updateOrder(data, table, order.id);
        }
      }
    }
  }

  removeOneOrder(String table, String name, String price) async {
    final ordersCreated = orders.where((element) => element.name == name);
    final order = ordersCreated.first;
    final total = int.parse(order.count) - 1;
    final precio = int.parse(price) * total;
    
    if(total <= 0) {
      removeOrder(table, order.id);
    } else {
      final data = {"id": order.id, "name": order.name, "price": precio.toString(), "count": total.toString()};
      updateOrder(data, table, order.id);
    }

    getOrders(table);
    setTotalPercent(0);
    notifyListeners();
  }

  updateOrder(Map<String, String> data, String table, String id) async {
    final response = await updateData(data, 'bar/order $table/$id');
    final updateTable = await OrdersResponse().jsonDecodeSingle(response);
    if(updateTable != null) {
      final index = orders.indexWhere((table) => table.id == id);
      orders[index] = updateTable;
      setTotalPercent(0);
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  removeOrder(String table, String id) async {
    if(id.isNotEmpty) {
      final response = removeData('bar/order $table/$id');
      final index = orders.indexWhere((table) => table.id == id);
      orders.removeAt(index);
      setTotalPercent(0);
      notifyListeners();
      return response;
    }
  }

  removeOrderTotal(String table) async {
    final response = removeData('bar/order $table');
    notifyListeners();
    return response;
  }

  saveOrderTotal(String table, String total, String id) async {
    _write(total.replaceAll('.00', '').replaceAll('\$', '').replaceAll('.', '').replaceAll(',', ''));
    await getSale(id);
    if(sale?.total == null) {
      final totalString = total.toString().replaceAll('.00', '').replaceAll('\$', '').replaceAll('.', '').replaceAll(',', '');
      final data = {"table": table, "total": totalString };
      await newData(data, 'bar/sales', id);
    } else {
      final price = sale?.total.replaceAll('\$', '').replaceAll('.', '').replaceAll(',', '');
      final newTotal = int.parse(price!) + int.parse(total.replaceAll('.00', '').replaceAll('\$', '').replaceAll('.', '').replaceAll(',', ''));
      final totalString = newTotal.toString().replaceAll('.00', '');
      final data = {"table": table, "total":  totalString};
      await updateData(data, 'bar/sales/$id');
    }
    
    totalCurrency = '0';
    totalPercent = '0';
    addPercent = 0;
    orders = [];
    sale = null;
    removeOrderTotal(table);
    notifyListeners();
    return true;
  }

  _write(String total) async {
    double endTotal;
    final totalSaved = LocalStorage().getInternalTotal();
    if(totalSaved != null) {
      endTotal = double.parse(totalSaved) + double.parse(total);
    } else {
      endTotal = double.parse(total);
    }
    LocalStorage().setInternalTotal(endTotal.toString());
  }

  getSale(String id) async {
    final json = await getData('bar/sales/$id');
    if(json != null) {
      sale = await SalesResponse().jsonDecodeSingle(json);
      notifyListeners();
    }
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