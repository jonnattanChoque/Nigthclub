// ignore_for_file: use_build_context_synchronously
import 'package:admin_dashboard/models/product_model.dart';
import 'package:admin_dashboard/providers/orders_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersDTS extends DataTableSource {
  final List<Products> products;
  final BuildContext context;
  final String titleTable;

  OrdersDTS(this.products, this.context, this.titleTable);

  @override
  DataRow? getRow(int index) {
    final productModel = products[index];

    final ordersProvider = Provider.of<OrdersProvider>(context, listen: false);

    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(productModel.category)),
        DataCell(Text(productModel.name)),
        DataCell(Text(productModel.price)),
        DataCell(
          Center(
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    ordersProvider.newOrder(titleTable, productModel.name, productModel.price);
                  },
                  icon: Icon(Icons.add_circle_outline_outlined, color: Colors.green.shade700,)
                ),
                const SizedBox(width: 20),
                IconButton(
                  onPressed: () {
                    ordersProvider.removeOneOrder(titleTable, productModel.name, productModel.price);
                  },
                  icon: Icon(Icons.remove_circle_outline_outlined, color: Colors.red.shade700)
                ),
              ],
            ),
          )
        ),
      ]
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => products.length;

  @override
  int get selectedRowCount => 0;
  
}