// ignore_for_file: use_build_context_synchronously

import 'package:admin_dashboard/models/buys_model.dart';
import 'package:admin_dashboard/providers/buys_provider.dart';
import 'package:admin_dashboard/services/notifications_service.dart';
import 'package:admin_dashboard/ui/shared/modals/buy_modal.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

final oCcy = NumberFormat.simpleCurrency();

class BuysDTS extends DataTableSource {
  final List<Buy> buys;
  final BuildContext context;

  BuysDTS(this.buys, this.context);

  @override
  DataRow? getRow(int index) {
    final buyModel = buys[index];
    final tableProvider = Provider.of<BuysProvider>(context, listen: false);
    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(buyModel.datesBuy)),
      DataCell(Text(buyModel.name)),
      DataCell(Text(oCcy.format(int.parse(buyModel.price)))),
      DataCell(Center(
        child: Row(
          children: [
            IconButton(
                onPressed: () {
                  showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (_) => BuyModal(table: buyModel));
                },
                icon: const Icon(Icons.edit_outlined)),
            const SizedBox(width: 20),
            IconButton(
              onPressed: () {
                final dialog = AlertDialog(
                  title: const Text('Borrar'),
                  content: Text('Borrar la compra ${buyModel.name} ?'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('No')),
                    TextButton(
                        onPressed: () async {
                          final response =
                              await tableProvider.removeBuys(buyModel.id);
                          Navigator.of(context).pop();
                          if (response) {
                            NotificationsService.showSnackBar(
                                'Compra eliminada', false);
                          }
                        },
                        child: const Text('Si')),
                  ],
                );
                showDialog(context: context, builder: (_) => dialog);
              },
              icon: const Icon(Icons.delete_outline),
              color: Colors.red.withOpacity(0.7),
            ),
          ],
        ),
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => buys.length;

  @override
  int get selectedRowCount => 0;
}
