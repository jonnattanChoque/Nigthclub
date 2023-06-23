import 'package:admin_dashboard/datatables/tables_source.dart';
import 'package:admin_dashboard/providers/tables_provider.dart';
import 'package:admin_dashboard/ui/shared/buttons/custom_icon_button.dart';
import 'package:admin_dashboard/ui/shared/labels/custom_labels.dart';
import 'package:admin_dashboard/ui/shared/modals/table_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TablesView extends StatefulWidget {
  const TablesView({Key? key}) : super(key: key);

  @override
  State<TablesView> createState() => _TablesViewState();
}

class _TablesViewState extends State<TablesView> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    super.initState();
    Provider.of<TablesProvider>(context, listen: false).getTables();
  }

  @override
  Widget build(BuildContext context) {
    final tables = Provider.of<TablesProvider>(context).tables;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Mesas', style: CustomLabels.h1),
          const SizedBox(height: 30),
          PaginatedDataTable(
            columns: const [
              DataColumn(label: Text('ID')),
              DataColumn(label: Text('Nombre')),
              DataColumn(label: Text('Acciones')),
            ],
            source: TablesDTS(tables, context),
            header: const Text('Listado de mesas'),
            onRowsPerPageChanged: (value) => setState(() { _rowsPerPage = value ?? 10; } ),
            rowsPerPage: _rowsPerPage,
            actions: [
              CustomIconButton(onPressed: () {
                showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context, 
                  builder: (_) => const TableModal()
                );
              }, text: 'Crear mesa', icon: Icons.add_outlined)
            ],
          )
        ],
      )
    );
  }
}