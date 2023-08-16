import 'package:admin_dashboard/models/buy_today_model.dart';
import 'package:admin_dashboard/models/buys_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

final oCcy = NumberFormat.simpleCurrency();

class BuysReportDTS extends DataGridSource {
  BuysReportDTS({required List<BuysToday> employeeData}) {
    _employeeData = employeeData
      .map<DataGridRow>((e) => DataGridRow(cells: [
        DataGridCell<String>(columnName: 'date', value: e.date),
        DataGridCell<String>(columnName: 'buy', value: oCcy.format(int.parse(e.total))),
      ]))
      .toList();
  }

  List<DataGridRow> _employeeData = [];

  @override
  List<DataGridRow> get rows => _employeeData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: Text(e.value.toString()),
      );
    }).toList());
  }
}

class SalesTodayDTS extends DataGridSource {
  SalesTodayDTS({required List<Buy> employeeData}) {
    _employeeData = employeeData
      .map<DataGridRow>((e) => DataGridRow(cells: [
        DataGridCell<String>(columnName: 'date', value: e.datesBuy),
        DataGridCell<String>(columnName: 'total', value: oCcy.format(int.parse(e.price))),
      ]))
      .toList();
  }

  List<DataGridRow> _employeeData = [];

  @override
  List<DataGridRow> get rows => _employeeData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: Text(e.value.toString()),
      );
    }).toList());
  }
}