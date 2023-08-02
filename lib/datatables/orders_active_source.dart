// ignore_for_file: use_build_context_synchronously

import 'package:admin_dashboard/datatables/sales_source.dart';
import 'package:admin_dashboard/models/order_model.dart';
import 'package:flutter/material.dart';

class OrdersActiveDTS extends DataTableSource {
  final List<Orders> categories;
  final BuildContext context;

  OrdersActiveDTS(this.categories, this.context);

  @override
  DataRow? getRow(int index) {
    final categoryModel = categories[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(categoryModel.name)),
        DataCell(Text(categoryModel.count)),
        DataCell(Text(oCcy.format(int.parse(categoryModel.price)))),

      ]
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => categories.length;

  @override
  int get selectedRowCount => 0;
  
}