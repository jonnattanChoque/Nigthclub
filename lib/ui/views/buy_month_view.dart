import 'package:admin_dashboard/datatables/buys_report_source.dart';
import 'package:admin_dashboard/providers/buys_provider.dart';
import 'package:admin_dashboard/services/notifications_service.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:admin_dashboard/ui/shared/labels/custom_labels.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';
// ignore: depend_on_referenced_packages
import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Column, Row;
import '../../utils/save_file_web.dart' as helper;

class BuyMonthView extends StatefulWidget {
  /// Creates the home page.
  const BuyMonthView({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BuyMonthViewState createState() => _BuyMonthViewState();
}

class _BuyMonthViewState extends State<BuyMonthView> {
  final GlobalKey<SfDataGridState> _key = GlobalKey<SfDataGridState>();

  @override
  void initState() {
    super.initState();
    Provider.of<BuysProvider>(context, listen: false).getBuysMonth();
  }

  Future<void> exportDataGridToExcel() async {
    final now = DateTime.now();
    String formatter = DateFormat('yM').format(now);
    final Workbook workbook = _key.currentState!.exportToExcelWorkbook();
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    await helper.FileSaveHelper.saveAndLaunchFile(bytes, 'compra_mensual_$formatter.xlsx');
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BuysProvider>(context);
    final employeeDataSource = BuysReportDTS(employeeData: provider.buysMonth);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Compras mensuales', style: CustomLabels.h1),
          const SizedBox(height: 30),
          Text('Listado de compras por meses', style: CustomLabels.h2),
          const SizedBox(height: 20),
          if(provider.buysMonth.isEmpty)
            const Text('Debes crear el reporte en la compra diaria', style: TextStyle(color: Colors.redAccent, fontSize: 20),)
          else
            Column(
              children: [
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
                        color: Colors.red.shade400,
                        onPressed: () {
                          final dialog = AlertDialog(
                            content: const Text('Borrar todos los registros?'),
                            actions: [
                              TextButton(onPressed: () {
                                Navigator.pop(context);
                              }, child: const Text('No')),
                              TextButton(onPressed: () async {
                                provider.removeBuysMonth();
                                NotificationsService.showSnackBar('Reporte del mes eliminado', false);
                                Navigator.of(context).pop();
                              }, child: const Text('Si')),
                            ],
                          );
                          showDialog(context: context, builder: (_) => dialog );
                        },
                        child: const Center(
                          child: Text(
                            'Borrar reporte',
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
                      columnName: 'fecha',
                      label: Container(padding: const EdgeInsets.all(16.0), alignment: Alignment.center, child: const Text('Mes',))),
                    GridColumn(
                      columnName: 'total',
                      label: Container(padding: const EdgeInsets.all(16.0), alignment: Alignment.center, child: const Text('Comprado',))),
                  ],
                ),
              ],
            )
        ],
      )
    );
  }
}
