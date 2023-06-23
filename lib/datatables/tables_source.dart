// ignore_for_file: use_build_context_synchronously

import 'package:admin_dashboard/models/table_model.dart';
import 'package:admin_dashboard/providers/tables_provider.dart';
import 'package:admin_dashboard/services/notifications_service.dart';
import 'package:admin_dashboard/ui/shared/modals/table_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TablesDTS extends DataTableSource {
  final List<Tables> tables;
  final BuildContext context;

  TablesDTS(this.tables, this.context);

  @override
  DataRow? getRow(int index) {
    final tableModel = tables[index];
    final tableProvider = Provider.of<TablesProvider>(context, listen: false);
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text((index + 1).toString())),
        DataCell(Text(tableModel.name)),
        DataCell(
          Center(
            child: Row(
              children: [
                IconButton(onPressed: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context, 
                    builder: (_) => TableModal(table: tableModel)
                  );
                }, icon: const Icon(Icons.edit_outlined)),
                const SizedBox(width: 20),
                IconButton(onPressed: () {
                  final dialog = AlertDialog(
                    title: const Text('Borrar'),
                    content: Text('Borrar la mesa ${tableModel.name} ?'),
                    actions: [
                      TextButton(onPressed: () {
                        Navigator.of(context).pop();
                      }, child: const Text('No')),
                      TextButton(onPressed: () async {
                        final response = await tableProvider.removeTable(tableModel.id);
                        Navigator.of(context).pop();
                        if(response) {
                          NotificationsService.showSnackBar('Mesa eliminada', false);
                        }
                      }, child: const Text('Si')),
                    ],
                  );
                  showDialog(context: context, builder: (_) => dialog );
                }, icon: const Icon(Icons.delete_outline), color: Colors.red.withOpacity(0.7),),
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
  int get rowCount => tables.length;

  @override
  int get selectedRowCount => 0;
  
}