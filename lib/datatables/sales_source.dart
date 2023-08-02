import 'package:admin_dashboard/models/sales_today_model.dart';
import 'package:flutter/material.dart';
import 'package:admin_dashboard/models/sales_model.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

final oCcy = NumberFormat.simpleCurrency();

class SalesDTS extends DataGridSource {
  SalesDTS({required List<Sales> employeeData}) {
    _employeeData = employeeData
      .map<DataGridRow>((e) => DataGridRow(cells: [
        DataGridCell<String>(columnName: 'name', value: e.name),
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
  SalesTodayDTS({required List<SalesToday> employeeData}) {
    _employeeData = employeeData
      .map<DataGridRow>((e) => DataGridRow(cells: [
        DataGridCell<String>(columnName: 'date', value: e.date),
        DataGridCell<String>(columnName: 'total', value: oCcy.format(int.parse(e.total))),
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