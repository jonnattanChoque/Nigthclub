import 'package:admin_dashboard/services/notifications_service.dart';
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

class SalesTodayView extends StatefulWidget {
  /// Creates the home page.
  const SalesTodayView({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SalesTodayViewState createState() => _SalesTodayViewState();
}

class _SalesTodayViewState extends State<SalesTodayView> {
  final GlobalKey<SfDataGridState> _key = GlobalKey<SfDataGridState>();

  @override
  void initState() {
    super.initState();
    Provider.of<SalesProvider>(context, listen: false).getSaleTodays();
  }

  Future<void> exportDataGridToExcel() async {
    final now = DateTime.now();
    String formatter = DateFormat('yMd').format(now);
    final Workbook workbook = _key.currentState!.exportToExcelWorkbook();
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    await helper.FileSaveHelper.saveAndLaunchFile(bytes, 'venta_diaria_$formatter.xlsx');
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SalesProvider>(context);
    final employeeDataSource = SalesTodayDTS(employeeData: provider.salesToday);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Ventas diarias', style: CustomLabels.h1),
          const SizedBox(height: 30),
          Text('Listado de ventas por día', style: CustomLabels.h2),
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
              const SizedBox(width: 50),
              SizedBox(
                height: 40.0,
                width: 150.0,
                child: MaterialButton(
                  color: Colors.green,
                  onPressed: () {
                    final dialog = AlertDialog(
                      content: const Text('Crear la venta del mes?'),
                      actions: [
                        TextButton(onPressed: () {
                          Navigator.pop(context);
                        }, child: const Text('No')),
                        TextButton(onPressed: () async {
                          provider.saveMonthSales();
                          NotificationsService.showSnackBar('Reporte del mes guardado', false);
                          Navigator.of(context).pop();
                        }, child: const Text('Si')),
                      ],
                    );
                    showDialog(context: context, builder: (_) => dialog );
                  },
                  child: const Center(
                    child: Text(
                      'Crear venta mensual',
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
                columnName: 'date',
                label: Container(padding: const EdgeInsets.all(16.0), alignment: Alignment.center, child: const Text('Fecha',))),
              GridColumn(
                columnName: 'total',
                label: Container(padding: const EdgeInsets.all(16.0), alignment: Alignment.center, child: const Text('Vendido',))),
            ],
          ),
        ],
      )
    );
  }
}
