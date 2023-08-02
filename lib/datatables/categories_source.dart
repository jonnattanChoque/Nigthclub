// ignore_for_file: use_build_context_synchronously

import 'package:admin_dashboard/models/category_model.dart';
import 'package:admin_dashboard/providers/categories_provider.dart';
import 'package:admin_dashboard/services/notifications_service.dart';
import 'package:admin_dashboard/ui/shared/modals/category_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesDTS extends DataTableSource {
  final List<Category> categories;
  final BuildContext context;

  CategoriesDTS(this.categories, this.context);

  @override
  DataRow? getRow(int index) {
    final categoryModel = categories[index];
    final tableProvider = Provider.of<CategoriesProvider>(context, listen: false);
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text((index + 1).toString())),
        DataCell(Text(categoryModel.name)),
        DataCell(
          Center(
            child: Row(
              children: [
                IconButton(onPressed: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context, 
                    builder: (_) => CategoryModal(table: categoryModel)
                  );
                }, icon: const Icon(Icons.edit_outlined)),
                const SizedBox(width: 20),
                IconButton(onPressed: () {
                  final dialog = AlertDialog(
                    title: const Text('Borrar'),
                    content: Text('Borrar la categoría ${categoryModel.name} ?'),
                    actions: [
                      TextButton(onPressed: () {
                        Navigator.of(context).pop();
                      }, child: const Text('No')),
                      TextButton(onPressed: () async {
                        final response = await tableProvider.removeCategory(categoryModel.id);
                        Navigator.of(context).pop();
                        if(response) {
                          NotificationsService.showSnackBar('Categoría eliminada', false);
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
  int get rowCount => categories.length;

  @override
  int get selectedRowCount => 0;
  
}