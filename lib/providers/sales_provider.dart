import 'package:admin_dashboard/models/sales_model.dart';
import 'package:admin_dashboard/models/sales_today_model.dart';
import 'package:admin_dashboard/services/back_servie.dart';
import 'package:admin_dashboard/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class SalesProvider extends ChangeNotifier with BackService {
  List<Sales> sales = [];
  List<SalesToday> salesToday = [];
  List<SalesToday> salesMonth = [];
  String total = '0';
  String totalToday = '0';
  bool ascending = true;
  int? sortColumnIndex;

  SalesProvider() {
    initializeDateFormatting();
  }

  getSales() async {
    final json = await getData('bar/sales');
    sales = await SalesResponse().jsonDecodes(json);

    getTotal();
    notifyListeners();
  }

  getTotal() {
    var privateTotal = 0;
    for (var element in sales) {
      privateTotal += int.parse(element.total.replaceAll('\$', '').replaceAll('.00', '').replaceAll('.', '').replaceAll(',', ''));
    }
    total = privateTotal.toString();
  }

  getSaleTodays() async {
    final json = await getData('bar/totalToday');
    salesToday = await SalesTodayResponse().jsonDecodes(json);
    getTotalToday();
    notifyListeners();
  }

  getTotalToday() {
    var privateTotal = 0;
    for (var element in salesToday) {
      privateTotal += int.parse(element.total);
    }
    totalToday = privateTotal.toString();
  }

  saveTodaySales() async {
    final totalToday = LocalStorage().getInternalTotal();
    if(totalToday != null) {
      final now = DateTime.now();
      String formatter = DateFormat('yMd').format(now);// 28/03/2020
      final data = { "total": totalToday.toString(), 'fecha': formatter };
      final response = await newData(data, 'bar/totalToday', null);
      if(response != null) {
        LocalStorage().removeInternalTotal();
      }
    }
  }

  getSaleMonth() async {
    final json = await getData('bar/totalMonth');
    if(json != null) {
      salesMonth = await SalesTodayResponse().jsonDecodes(json);
    }
    notifyListeners();
  }

  saveMonthSales() async {
    final now = DateTime.now().toLocal();
    String formatter = DateFormat.yMMMM('es_ES') .format(now);
    final data = { "total": totalToday.toString(), 'fecha': formatter };
    await newData(data, 'bar/totalMonth', null);
  }

  void sort<T>(Comparable<T> Function(Sales product) getField ) {
    sales.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending ? Comparable.compare(aValue, bValue) : Comparable.compare(bValue, aValue);
    });

    ascending = !ascending;
    notifyListeners();
  }
}