import 'package:admin_dashboard/models/buy_today_model.dart';
import 'package:admin_dashboard/models/buys_model.dart';
import 'package:admin_dashboard/services/back_servie.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class BuysProvider extends ChangeNotifier with BackService {
  List<Buy> buys = [];
  List<BuysToday> buysTodayTemp = [];
  List<BuysToday> buysToday = [];
  List<BuysToday> buysMonth = [];
  String total = '0';
  String totalToday = '0';
  bool ascending = true;
  int? sortColumnIndex;

  BuysProvider() {
    initializeDateFormatting();
  }

  getBuys() async {
    final json = await getData('bar/buys');
    buys = await BuysResponse().jsonDecodes(json);
    notifyListeners();
  }

  getBuysDay() async {
    final json = await getData('bar/buys');
    buys = await BuysResponse().jsonDecodes(json);
    var dates = buys.map((element) => toDateTime(int.parse(element.created)));

    for (var date in dates) {
      var newBuy = buys
      .where((element) => toDateTime(int.parse(element.created)) == date)
      .map((element) => element).toList();
      
      final total = newBuy.fold(0, (sum, item) => sum + int.parse(item.price));
      buysTodayTemp.add(BuysToday(id: '', date: (newBuy[0].datesBuy).toString(), total: total.toString()));
    }

    buysToday = buysTodayTemp.whereWithIndex((element, index) =>
        buysTodayTemp.indexWhere((element2) =>
            element2.date == element.date &&
            element2.id == element.id) ==
        index)
    .toList();

    getTotalToday();
    notifyListeners();
  }

  DateTime toDateTime(int d) {
    var dt=DateTime.fromMillisecondsSinceEpoch(d);
    return DateTime(dt.year, dt.month, dt.day);
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

  saveMonthBuys() async {
    final now = DateTime.now().toLocal();
    String formatter = DateFormat.yMMMM('es_ES') .format(now);
    final data = { "total": totalToday.toString(), 'fecha': formatter };
    await newData(data, 'bar/totalMonthBuys', null);
  }

  getTotalToday() {
    var privateTotal = 0;
    for (var element in buysToday) {
      privateTotal += int.parse(element.total);
    }
    totalToday = privateTotal.toString();
  }

  getBuysMonth() async {
    final json = await getData('bar/totalMonthBuys');
    if(json != null) {
      buysMonth = await BuysTodayResponse().jsonDecodes(json);
    }
      
  }

  removeBuysMonth() async {
    await removeData('bar/totalMonthBuys');
    buysMonth = [];
    notifyListeners();
    return true;
  }
}


extension ListExtensions<T> on List<T> {
  Iterable<T> whereWithIndex(bool Function(T element, int index) test) {
    final List<T> result = [];
    // ignore: unnecessary_this
    for (var i = 0; i < this.length; i++) {
      if (test(this[i], i)) {
        result.add(this[i]);
      }
    }
    return result;
  }
}