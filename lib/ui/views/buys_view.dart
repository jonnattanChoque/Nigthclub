import 'package:admin_dashboard/datatables/categories_source.dart';
import 'package:admin_dashboard/providers/categories_provider.dart';
import 'package:admin_dashboard/ui/shared/buttons/custom_icon_button.dart';
import 'package:admin_dashboard/ui/shared/labels/custom_labels.dart';
import 'package:admin_dashboard/ui/shared/modals/category_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({Key? key}) : super(key: key);

  @override
  State<CategoriesView> createState() => _CategoriesView();
}

class _CategoriesView extends State<CategoriesView> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    super.initState();
    Provider.of<CategoriesProvider>(context, listen: false).getCategory();
  }

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<CategoriesProvider>(context).categories;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Categorías', style: CustomLabels.h1),
          const SizedBox(height: 30),
          PaginatedDataTable(
            columns: const [
              DataColumn(label: Text('ID')),
              DataColumn(label: Text('Nombre')),
              DataColumn(label: Text('Acciones')),
            ],
            source: CategoriesDTS(categories, context),
            header: const Text('Listado de categorías'),
            onRowsPerPageChanged: (value) => setState(() { _rowsPerPage = value ?? 10; } ),
            rowsPerPage: _rowsPerPage,
            actions: [
              CustomIconButton(onPressed: () {
                showModalBottomSheet(
                  context: context, 
                  builder: (_) => const CategoryModal()
                );
              }, text: 'Crear categoría',  icon: Icons.add_outlined, color: const Color.fromARGB(255, 58, 222, 222),)
            ],
          )
        ],
      )
    );
  }
}