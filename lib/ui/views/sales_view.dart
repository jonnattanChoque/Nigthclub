import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:admin_dashboard/datatables/sales_source.dart';
import 'package:admin_dashboard/providers/sales_provider.dart';
import 'package:admin_dashboard/ui/shared/labels/custom_labels.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';
// ignore: depend_on_referenced_packages
import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Column, Row;
import '../../utils/save_file_web.dart' as helper;

class SalesView extends StatefulWidget {
  /// Creates the home page.
  const SalesView({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SalesViewState createState() => _SalesViewState();
}

class _SalesViewState extends State<SalesView> {
  final GlobalKey<SfDataGridState> _key = GlobalKey<SfDataGridState>();

  @override
  void initState() {
    super.initState();
    Provider.of<SalesProvider>(context, listen: false).getSales();
  }

  Future<void> exportDataGridToExcel() async {
    final now = DateTime.now();
    String formatter = DateFormat('yMd').format(now);// 28/03/2020
    final Workbook workbook = _key.currentState!.exportToExcelWorkbook();
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    await helper.FileSaveHelper.saveAndLaunchFile(bytes, 'venta_total_$formatter.xlsx');
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SalesProvider>(context);
    final employeeDataSource = SalesDTS(employeeData: provider.sales);
    final oCcy = NumberFormat.simpleCurrency();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Ventas: ${oCcy.format(int.parse(provider.total))}', style: CustomLabels.h1),
          const SizedBox(height: 30),
          Text('Listado de ventas por mesas', style: CustomLabels.h2),
          const SizedBox(height: 20),
          Row(
            children: [
              SizedBox(
                height: 40.0,
                width: 150.0,
                child: MaterialButton(
                  color: Colors.blue,
                  onPressed: exportDataGridToExcel,
                  child: const Center(
                      child: Text(
                      'Exportar a Excel',
                      style: TextStyle(color: Colors.white),
                    )
                  )
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          SfDataGrid(
            key: _key,
            source: employeeDataSource,
            columnWidthMode: ColumnWidthMode.fill,
            columns: <GridColumn>[
              GridColumn(
                columnName: 'name',
                label: Container(padding: const EdgeInsets.all(16.0), alignment: Alignment.center, child: const Text('Nombre',))),
              GridColumn(
                columnName: 'buy',
                label: Container(padding: const EdgeInsets.all(16.0), alignment: Alignment.center, child: const Text('Vendido',))),
            ],
          ),
        ],
      )
    );
  }
}
