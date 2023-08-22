// ignore_for_file: library_private_types_in_public_api

import 'package:admin_dashboard/datatables/buys_report_source.dart';
import 'package:admin_dashboard/providers/buys_provider.dart';
import 'package:admin_dashboard/services/notifications_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:admin_dashboard/ui/shared/labels/custom_labels.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';
// ignore: depend_on_referenced_packages
import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Column, Row;
import '../../utils/save_file_web.dart' as helper;

class BuyTodayView extends StatefulWidget {
  /// Creates the home page.
  const BuyTodayView({Key? key}) : super(key: key);

  @override
  @SemanticsHintOverrides()
  _BuyTodayViewState createState() => _BuyTodayViewState();
}

class _BuyTodayViewState extends State<BuyTodayView> {
  final GlobalKey<SfDataGridState> _key = GlobalKey<SfDataGridState>();

  @override
  void initState() {
    super.initState();
    Provider.of<BuysProvider>(context, listen: false).getBuysDay();
  }

  Future<void> exportDataGridToExcel() async {
    final now = DateTime.now();
    String formatter = DateFormat('yMd').format(now);
    final Workbook workbook = _key.currentState!.exportToExcelWorkbook();
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    await helper.FileSaveHelper.saveAndLaunchFile(bytes, 'compra_diaria_$formatter.xlsx');
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BuysProvider>(context);
    final employeeDataSource = BuysReportDTS(employeeData: provider.buysToday);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Compras diarias', style: CustomLabels.h1),
          const SizedBox(height: 30),
          Text('Listado de compras por día', style: CustomLabels.h2),
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
                      content: const Text('Crear la compra del mes?'),
                      actions: [
                        TextButton(onPressed: () {
                          Navigator.pop(context);
                        }, child: const Text('No')),
                        TextButton(onPressed: () async {
                          provider.saveMonthBuys();
                          NotificationsService.showSnackBar('Reporte del mes guardado', false);
                          Navigator.of(context).pop();
                        }, child: const Text('Si')),
                      ],
                    );
                    showDialog(context: context, builder: (_) => dialog );
                  },
                  child: const Center(
                    child: Text(
                      'Crear compra mensual',
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
                label: Container(padding: const EdgeInsets.all(16.0), alignment: Alignment.center, child: const Text('Valor',))),
            ],
          ),
        ],
      )
    );
  }
}
